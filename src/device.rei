use interrupt::*

ServiceNumber: u64

const MAX_PENDING_SERVICES = 512

Service: {
    id: ServiceNumber
    buffer: *mut u8? = ()
    buffer_size_bytes: u64
    pid: Pid
}

// circular buffer (defined in core::types)
mut pending_services: CircularBuffer([Service; MAX_PENDING_SERVICES])

@interrupt_handler(HardwareWriteComplete)
handle_hardware_completion: (service_number: ServiceNumber, result_data: *mut u8) {
    mut res = pending_services.find(service_number).expect("Couldn't find service number...")
    // zero copy
    res.buffer = result_data
    // increase priority for pid in the global-local scheduler
    scheduler.find(pid).bump_priority()
}

HWFaultType: enum u64 => ReadError | WriteError

@interrupt_handler(HardwareFault)
handle_hardware_completion: (HWFaultType) {
    panic("Hardware fault!")
}
