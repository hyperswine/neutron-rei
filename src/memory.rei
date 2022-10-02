#*
    Reexport Arcboot Primitives
*#

MemoryMap: {}

// to communicate with hardware, use its bound NeutronDevice methods

Action: {
    # DMA an arbitrary chunk of memory to a device
    DMAReadBuffer
    # Ask for a certain chunk of memory from a device
    DMAWriteBuffer
}

// DMA semantics
// DMA prob uses MMIO to tell the device of interest, to start doing an action

NeutronDevice: {

}

// EXPORT MEMORY MANAGEMENT PROTOCOLS TO spx:mem

// intercept memory faults

DescriptorError: {}

FaultType: enum {
    NullRead
    UninitalizedMemory
    DescriptorError: enum extend {
        PageDesc: {level: Level}
        BlockDesc: {level: Level}
    }
}

@interrupt_handler(PageFault)
handle_hardware_completion: (fault_address: u64, fault_type: FaultType) {
    match fault_type {
        NullRead => _
        UninitalizedMemory => _
        DescriptorError => _
    }
}
