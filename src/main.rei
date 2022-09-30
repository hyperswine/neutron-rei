main: (arcservices: ArcServices) {

}

// NOTE: the default arcboot handler actually saves the state and such, so interrupt_handler is used for defining the logic only

NeutronSyscall: enum {
    // generate an authentication pub/priv key pair or some other scheme
    Verify
    // attempt to access some computing resource (usually memory mapped)
    Access
}

// setup interrupt handlers from arcboot
// basically, registers the fn with arcservices.register() at initialisation
@interrupt_handler(Syscall)
handle_syscall: (number: NeutronSyscall) {
    // HOW syscalls work on neutron
    // neutronapi uses the syscall enum'd numbers and sets them in a0

    match number {
        Verify => _
        Access => _
    }
}
