use arcboot::interrupt_handler

InterruptType: enum {
    Syscall
    HardwareWriteComplete
    HardwareFault
    PageFault
}

use arcboot::InterruptCount

# A collection of platform independent interrupt handlers that can be written to the IVT
export default InterruptHandlers: [Interrupt; InterruptCount]
