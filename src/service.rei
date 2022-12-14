use interrupt::*

// neutron basically sets up a tree of resources
// and has exclusive access to all of them
// but it is able to grant other processes the ability to directly read and write to them (NOT CHANGE THE ACTUAL TREE ITSELF)
// neutron itself doesnt contain any complex drivers

// NOTE: the default arcboot handler actually saves the state and such, so interrupt_handler is used for defining the logic only

// Representation of a specific resource, e.g. ssd, mouse input, gpu on a system
SystemResource: enum {
    MassStorage
    Input: Mouse | Keyboard | Mic
    Output: Speakers | Display | Serial | Parallel
    Accelerator: Graphics | Cryptographic | Compression
}

// could also be something more generic as well, maybe a neutron owned resource but shareable
Resource: SystemResource

NeutronSyscall: enum {
    // generate an authentication pub/priv key pair or some other scheme
    // to be able to access a specific device or resource
    Register: {
        resource: Resource
    }
    // refresh
    RefreshKey: {
        // each executable on the system has an Id associated with it
        // its runtime pid needs to be bound to it by a process_start call. Note, a spawn process service can actually be handled by a sparx/scheduler which has access to other process' page tables
        executable_id: Id
    }
    // attempt to access some computing resource (usually memory mapped)
    // Access
}

// setup interrupt handlers from arcboot
// basically, registers the fn with arcservices.register() at initialisation
@interrupt_handler(Syscall)
handle_syscall: (number: NeutronSyscall) {
    // HOW syscalls work on neutron
    // neutronapi uses the syscall enum'd numbers and sets them in a0

    // INTERNALLY, neutron uses a set of config options (stored in /sys/config) to determine:
    // expiry duration of a key (usually 3 days to 1 week)
    // the permissions a key has
    // etc.
    // Normally, spx:security should intercept all process requests to do certain things and push a notification to spx:quanta-desktop

    // when a process starts/spawns, it has to fetch its key from spx:security or the kernel or its own file (read-only by the kernel or spx:sec only) itself in order to be able to access system resources
    // each time it tries to access a system resource, it has send a request with its key to the spx's address space circular buffer through the UBus
    // which is locked behind a mutex. NOTE: if the buffer would be full, the process simply busy waits until it isnt, or can yield to the scheduler and be rescheduled later (usually at a higher priority each time it has to be rescheduled)

    // if possible, it would just have to authenticate itself once at startup or every 3 days or something
    // then it can just send requests to spx without a key
    // but that means writing to some buffer without hardware support for it. The hardware only supports ASID protections
    // up to 2^16 or was it 2^8

    // that means you can only have position independent code. No raw addresses or anything. Just stuff in .data who's vaddresses will be generated by the compiler or kernel or startup service and referencing them will be the same idea
    // the addresses must have certain ASID. Maybe a startup program can look through the binary and replace the j 0x... to something else
    // wait no, position independent just means the addresses in the binary are offsets in the binary

    match number {
        Register{resource} => {
            
        }
        RefreshKey{id} => {
            // find the executable id from the in memory key:val database

        }
    }
}
