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

