package signal_example

import "base:runtime"
import "core:fmt"
import "core:os"

import "../../signal"

//	signal handler using SIG enum from library
sig_handler :: proc(sig: signal.SIG) {
	#partial switch sig {
	case .SIGINT:
		fmt.println("\nSIGINT:","ctrl+c captured - showing cursor")
		cursor_show()
		os.exit(int(sig))
	case .SIGTERM:
		cursor_show()
		os.exit(int(sig))
	case .SIGTSTP:
		//	intercept ctrl+z, do stuff, then tell os it's ok to STOP
		fmt.println("\nSIGTSTP:", "ctrl+z captured")
		signal.raise(signal.SIG.SIGSTOP)
	case .SIGCONT:
		fmt.println("SIGCONT:", "return from ctrl+z captured")
	}
}

//	custom signal enum - enum name must match with parameter type name in signal handler
MYSIG :: enum i32 {
	NONE  = i32(0),
	SIG42 = i32(42),
}

//	custom signal handler - parameter type name must match enum name
my_sig_handler :: proc(sig: MYSIG) {
	#partial switch sig {
	case .SIG42: //	42 - ultimate answer
		fmt.println("SIG42:", "What was the question again?")
	}
}

main :: proc() {
	signal.signal(signal.SIG.SIGINT, sig_handler)
	when ODIN_OS != .Windows {
		signal.signal(signal.SIG.SIGTSTP, sig_handler)
		signal.signal(signal.SIG.SIGCONT, sig_handler)
	}

	//	use custom sig enum with custom sig handler
	//	the handler proc must use the same enum defintion for it's parameter
	signal.signal(MYSIG.SIG42, my_sig_handler)

	fmt.println("Realtime Signals -", "Min:", signal.SIG.SIGRTMIN, "Max:", signal.SIG.SIGRTMAX)

	//	uncomment to test resetting ctrl+z back to system default - linux only
	//signal.default(signal.SIG.SIGTSTP)

	//	Something to test ctrl+z and cntl+c signals
	fmt.println("Holding main process hostage and hiding the cursor! Muwaahahaa!!")
	fmt.print("\e[?25l")
	proceed: bool
	for !proceed {
		fmt.println("Proceed? Y/N or y/n")
		fmt.println("... or ... sshh, don't tell. Try ctrl+c")
		buf: [12]byte
		os.read(os.stdin, buf[:])
		if buf[0] == 'Y' || buf[0] == 'y' {
			proceed = true
			fmt.println("proceeding ...")
		}
	}

	//	uncomment to test setting system to ignore raising of a signal
	//	signal.ignore(MYSIG.SIG42)

	//	raise custom signal
	signal.raise(MYSIG.SIG42)
}

//	this if defined as fini in case a signal does not call it
@(fini) cursor_show :: proc "contextless" () {
	context = runtime.default_context()
	fmt.print("\e[?25h", flush=true)
}