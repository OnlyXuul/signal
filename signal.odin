package signal

import "core:c/libc"
import "base:intrinsics"

//	terminal command trap -l will list all supported signals
//	The signals SIGKILL and SIGSTOP cannot be caught, blocked, or ignored

when ODIN_OS == .Windows {
	SIG_ERR   :: rawptr(~uintptr(0)) //	signal() error - invalid proc pointer
	SIG_DFL   :: rawptr(uintptr(0))  //	system use default for specified signal (i.e. no user defined signal handler)
	SIG_IGN   :: rawptr(uintptr(1))  // system ignore specified signal if raised

	SIGINT    :: i32(2)  //	ctrl+c
	SIGILL    :: i32(4)  //	illegal instruction
	SIGABRT   :: i32(22) //	abnormal termination (abort)
	SIGFPE    :: i32(8)  //	floating-point exception
	SIGSEGV   :: i32(11) //	segmentation fault
	SIGTERM   :: i32(15) //	termination signal

	SIG :: enum i32 {
		NONE    = 0,
		SIGINT  = SIGINT,
		SIGILL  = SIGILL,
		SIGABRT = SIGABRT,
		SIGFPE  = SIGFPE,
		SIGSEGV = SIGSEGV,
		SIGTERM = SIGTERM,
	}
}

//	non-windows signals
when ODIN_OS == .Linux || ODIN_OS == .FreeBSD || ODIN_OS == .Haiku || ODIN_OS == .OpenBSD || ODIN_OS == .NetBSD || ODIN_OS == .Darwin {
	SIG_ERR     :: rawptr(~uintptr(0)) //	signal() error - invalid proc pointer
	SIG_DFL     :: rawptr(uintptr(0))  //	system use default for specified signal (i.e. no user defined signal handler)
	SIG_IGN     :: rawptr(uintptr(1))  // system ignore specified signal if raised

	SIGHUP      :: i32(1)	 //	hangup detected
	SIGINT      :: i32(2)  //	ctrl+c
	SIGQUIT     :: i32(3)  //	quit from keyboard
	SIGILL      :: i32(4)  //	illegal instruction
	SIGTRAP     :: i32(5)  //	trace/breakpoint trap
	SIGABRT     :: i32(6)  //	abnormal termination (abort)
	SIGBUS      :: i32(7)  //	bus error (bad memory access)
	SIGFPE      :: i32(8)  //	floating-point exception // seems to occur when a signal is raised that is not handled
	SIGKILL     :: i32(9)  //	pre-meditated murder of a process
	SIGUSR1     :: i32(10) //	User-defined signal 1
	SIGSEGV     :: i32(11) //	segmentation fault
	SIGUSR2     :: i32(12) //	User-defined signal 2
	SIGPIPE     :: i32(13) //	broken pipe: write to pipe with no readers
	SIGALRM     :: i32(14) // timer signal from alarm(2)
	SIGTERM     :: i32(15) //	termination signal
	SIGSTKFLT   :: i32(16) //	stack fault on coprocessor (unused)
	SIGCHLD     :: i32(17) //	child stopped or terminated
	SIGCONT     :: i32(18) //	resume from ctrl+z
	SIGSTOP	    :: i32(19) //	raised when system captures SIGTSTP // do not capture this, just raise it when capturing SIGTSTP
	SIGTSTP     :: i32(20) //	ctrl+z - after capturing this, then raise SIGSTOP
	SIGTTIN     :: i32(21) //	terminal input for background process
	SIGTTOU     :: i32(22) //	terminal output for background process
	SIGURG      :: i32(23) //	urgent condition on socket
	SIGXCPU     :: i32(24) //	CPU time limit exceeded
	SIGXFSZ     :: i32(25) //	file size limit exceeded
	SIGVTALRM   :: i32(26) //	virtual alarm clock
	SIGPROF     :: i32(27) //	profiling timer expired
	SIGWINCH    :: i32(28) //	window resize signal
	SIGIO       :: i32(29) //	i/o now possible - also SIGPOLL
	SIGPWR      :: i32(30) //	power failure
	SIGSYS      :: i32(31) //	bad argument to routine - terminates with core-dump

	//min/max realtime signals
	SIGRTMIN    :: i32(34)
	SIGRTMIN1   :: i32(35)
	SIGRTMIN2   :: i32(36)
	SIGRTMIN3   :: i32(37)
	SIGRTMIN4   :: i32(38)
	SIGRTMIN5   :: i32(39)
	SIGRTMIN6   :: i32(40)
	SIGRTMIN7   :: i32(41)
	SIGRTMIN8   :: i32(42)
	SIGRTMIN9   :: i32(43)
	SIGRTMIN10  :: i32(44)
	SIGRTMIN11  :: i32(45)
	SIGRTMIN12  :: i32(46)
	SIGRTMIN13  :: i32(47)
	SIGRTMIN14  :: i32(48)
	SIGRTMIN15  :: i32(49) //SIGRTMIN + 15
	SIGRTMAX14  :: i32(50) //SIGRTMAX - 14
	SIGRTMAX13  :: i32(51)
	SIGRTMAX12  :: i32(52)
	SIGRTMAX11  :: i32(53)
	SIGRTMAX10  :: i32(54)
	SIGRTMAX9   :: i32(55)
	SIGRTMAX8   :: i32(56)
	SIGRTMAX7   :: i32(57)
	SIGRTMAX6   :: i32(58)
	SIGRTMAX5   :: i32(59)
	SIGRTMAX4   :: i32(60)
	SIGRTMAX3   :: i32(61)
	SIGRTMAX2   :: i32(62)
	SIGRTMAX1   :: i32(63)
	SIGRTMAX    :: i32(64)

	SIG :: enum i32 {
		SIGHUP      = SIGHUP,
		SIGINT      = SIGINT,
		SIGQUIT     = SIGQUIT,
		SIGILL      = SIGILL,
		SIGTRAP     = SIGTRAP,
		SIGABRT     = SIGABRT,
		SIGBUS      = SIGBUS,
		SIGFPE      = SIGFPE,
		SIGKILL     = SIGKILL, //	cannot be caught, blocked, or ignored
		SIGUSR1     = SIGUSR1,
		SIGSEGV     = SIGSEGV,
		SIGUSR2     = SIGUSR2,
		SIGPIPE     = SIGPIPE,
		SIGALRM     = SIGALRM,
		SIGTERM     = SIGTERM,
		SIGSTKFLT   = SIGSTKFLT,
		SIGCHLD     = SIGCHLD,
		SIGCONT     = SIGCONT,
		SIGSTOP	    = SIGSTOP, //	cannot be caught, blocked, or ignored
		SIGTSTP     = SIGTSTP,
		SIGTTIN     = SIGTTIN,
		SIGTTOU     = SIGTTOU,
		SIGURG      = SIGURG,
		SIGXCPU     = SIGXCPU,
		SIGXFSZ     = SIGXFSZ,
		SIGVTALRM   = SIGVTALRM,
		SIGPROF     = SIGPROF,
		SIGWINCH    = SIGWINCH,
		SIGIO       = SIGIO,
		SIGPWR      = SIGPWR,
		SIGSYS      = SIGSYS,
		SIGRTMIN    = SIGRTMIN,
		SIGRTMIN1   = SIGRTMIN1,
		SIGRTMIN2   = SIGRTMIN2,
		SIGRTMIN3   = SIGRTMIN3,
		SIGRTMIN4   = SIGRTMIN4,
		SIGRTMIN5   = SIGRTMIN5,
		SIGRTMIN6   = SIGRTMIN6,
		SIGRTMIN7   = SIGRTMIN7,
		SIGRTMIN8   = SIGRTMIN8,
		SIGRTMIN9   = SIGRTMIN9,
		SIGRTMIN10  = SIGRTMIN10,
		SIGRTMIN11  = SIGRTMIN11,
		SIGRTMIN12  = SIGRTMIN12,
		SIGRTMIN13  = SIGRTMIN13,
		SIGRTMIN14  = SIGRTMIN14,
		SIGRTMIN15  = SIGRTMIN15,
		SIGRTMAX14  = SIGRTMAX14,
		SIGRTMAX13  = SIGRTMAX13,
		SIGRTMAX12  = SIGRTMAX12,
		SIGRTMAX11  = SIGRTMAX11,
		SIGRTMAX10  = SIGRTMAX10,
		SIGRTMAX9   = SIGRTMAX9,
		SIGRTMAX8   = SIGRTMAX8,
		SIGRTMAX7   = SIGRTMAX7,
		SIGRTMAX6   = SIGRTMAX6,
		SIGRTMAX5   = SIGRTMAX5,
		SIGRTMAX4   = SIGRTMAX4,
		SIGRTMAX3   = SIGRTMAX3,
		SIGRTMAX2   = SIGRTMAX2,
		SIGRTMAX1   = SIGRTMAX1,
		SIGRTMAX    = SIGRTMAX,
	}
}

signal :: proc {signal_i23, signal_enum}

//	the return value of the signal() function indicates the previous signal handler or an error.
//	on error, returns (proc(_: i32))(rawptr(~uintptr(0))) - invalid proc pointer
signal_i23 :: proc(sig: i32, func: proc(i32)) -> proc(_: i32) {
	return (proc(_: i32))(libc.signal(sig, (proc "cdecl" (i32))(func)))
}

//	the return value of the signal() function indicates the previous signal handler or an error.
//	on error, returns (proc(_: i32))(rawptr(~uintptr(0))) - invalid proc pointer
signal_enum :: proc(sig: $S, func: proc(S)) -> (proc(_: i32)) where intrinsics.type_is_enum(S) {
	return (proc(_: i32))(libc.signal(i32(sig), (proc "cdecl" (i32))(func)))
}

default :: proc {default_i23, default_enum}

//	tell system there is no signal handler for the given signal
//	the system should use it's default for the given signal
default_i23 :: proc(sig: i32) -> (proc(_: i32)) {
	return (proc(_: i32))(libc.signal(sig, (proc "cdecl" (i32))(SIG_DFL)))
}

//	tell system there is no signal handler for the given signal
//	the system should use it's default for the given signal
default_enum :: proc(sig: $S) -> (proc(_: i32)) where intrinsics.type_is_enum(S) {
	return (proc(_: i32))(libc.signal(i32(sig), (proc "cdecl" (i32))(SIG_DFL)))
}

ignore :: proc {ignore_i23, ignore_enum}

//	ignores a given signal (except the signals SIGKILL and SIGSTOP which can't be caught or ignored).
ignore_i23 :: proc(sig: i32) -> (proc(_: i32)) {
	return (proc(_: i32))(libc.signal(sig, (proc "cdecl" (i32))(SIG_IGN)))
}

//	ignores a given signal (except the signals SIGKILL and SIGSTOP which can't be caught or ignored).
ignore_enum :: proc(sig: $S) -> (proc(_: i32)) where intrinsics.type_is_enum(S) {
	return (proc(_: i32))(libc.signal(i32(sig), (proc "cdecl" (i32))(SIG_IGN)))
}

raise :: proc {raise_i23, raise_enum}

//	libc.raise return -1 on fail, so this does too
raise_i23 :: proc(sig: i32) -> i32 {
	return (i32)(libc.raise(sig))
}

//	libc.raise return -1 on fail, so this does too
raise_enum :: proc(sig: $S) -> (i32) where intrinsics.type_is_enum(S) {
	return (i32)(libc.raise(i32(sig)))
}
