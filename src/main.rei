use interrupt

main: (arcservices: ArcServices) -> Status {
    // NOTE: interrupt handlers should be registered in the code itself
    // but to let the vector table see it... you have to call the fn

    // note you dont actually have to pass in a lambda like () => ...
    // if the params itself is the fn's type
    // if not, then prob just pass the lambda with captured vals

    arcservices.interrupt_vector_table.register_interrupts(InterruptHandlers)

    // load filesystem view (neutronfs)
    Filesystem::load(&arcservices)

    // start spx:system
    Process::load("/sys/spx/system").run()

    // spx:system exited, exit to arcboot
}

Filesystem: {
    # attempt to load a filesystem view from booted partition
    load: (arcservices: ArcServices) {
        let nefs_view = arcservices.boot_partition.view()
        // map the view to a specific set of frames that can then be remapped into other process' memory
        // and the current process (kernel)
        // only privileged processes can call this fn (or maybe anything can? cause you need to be in mapped memory)
        arcservices.map_memory(nefs_view, Permissions::ReadWrite)

        // call map_memory() again to map the memory to another userspace process
    }
}
