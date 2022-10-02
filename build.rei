require = {
    // only the core lib + arcboot should be linked
    // the core lib is good for
    core = { version = "0.1" }
    arcboot = { version = "0.1" }
}

target = {
    phantasm_ir = {
        default_target = true
        build = {
            command = "rei-vm build neutron ."
        }
        run = {
            command = "rei-vm run"
        }
        // quick run. For a full install, do the build and then run
        test = {
            command = "rei-vm test build/neutron"
        }
    }
}

lib = {
    "neutronapi" = {
        default = true
    }
}
