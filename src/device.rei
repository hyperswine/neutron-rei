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

/*
    In Memory Shared Device Tree? Maybe created here but passed (ownership via ABI? to sparx)
*/

// should they be ordered or subtree'd? Idk
// or maybe two classes "direct" and "pluggable"?
// hmm "system" and "usb controller"?
// "integrated" and "usb" and pcie and whatever
// then you just have to modify the stuff here and any neutronapi drivers?
// maybe the driver code is here?

// note X: Y is sugar for X: (Y) -> Y
// so as X: (Y)
// to do "X: (Y) -> R" you must do it directly
 
Device: enum {
    # The root
    System: Vec[Device]
    // most types
    Input: enum {
        Mouse Keyboard Microphone Headset
    }
    Output: enum {
        Speakers Display Headphones
    }
    Serial: NPinConnector
    Parallel: NPinConnector
    NPinConnector
    NetworkInterface
    Accelerator: enum {
        ParallelProcessor GraphicsProcessor CryptoProcessor DigitalSignalProcessor
    }
    // hmm... Maybe the usb driver should be used and we just dont care about the usb part?
    // maybe...
    USBController: Vec[Device]
    Processor: Vec[Core]
    // empty types can also be seen as phantom types or data
    Core: ()
    Memory: Dynamic | Static
    Drive: Flash | SolidState | HardDrive | Optical
    Router: 
}

PCIeBAR: @bits {
    is_io_space: 0
    type: 1..2
    prefetchable: 3
    base_addr: 4..31
}

const PCI_IO_ADDR = 0xCF8

PCIeDevice: {
    bar: PCIeBAR
}

PCIeDevice: enum {
    Router
    Controller
    Endpoint: Device
}

PCIeDevice: extend {
    dma_to: (&mut self) {

    }
}

// all drives have LBA
export Drive: {
    BlockNumber: Size
    BlockRange: Range[Size]

    access_block: (block_number: BlockNumber) {
        // depending on the type and make and stuff
        // tell it to do something, like pcie

        pcie::dma_to()
    }
}

/*
example:
    system
        processor
            core0..core7
        memory
            bank0[numa0]
            bank1[numa1]
        usbcontroller[id = 0]
            headset
            mouse
            keyboard
        serial[id = 1]
            p0[4-pin]
            p1
            p2
        parallel[id = 2]
            p0[16-pin]
        pcie[id = 3]
            nic
            solidstate
*/
