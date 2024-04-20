#!/bin/bash
figlet "Workarounds"
echo "This section is for devices that need some workarounds to get something working."
echo "More workarounds comming soon..."

# Function to explain and load a kernel module if the user has a Framework 13-inch laptop
loadKernelModuleIfFramework13() {
    # Ask the user if they have a Framework 13-inch laptop
    if ! gum confirm "Do you have a Framework 13-inch laptop?"; then
        echo "This workaround is only applicable to Framework 13-inch laptops."
        return
    fi

    # Rest of the function remains the same
    module_name="hid_sensor_hub"

    # Check if the module is already loaded
    if lsmod | grep -wq "$module_name"; then
        gum log --structured --level debug "The '$module_name' module is already loaded."
        return
    fi

    # Explain why the module is needed
    echo "The '$module_name' module is related to the autobrightness sensor on your Framework Laptop. This '$module_name' is known to not allow you to change your brightness settings and so a known way to fix this is to disable the autobrighness sensor."

    # Prompt user for confirmation to load the module using Gum
    if gum confirm "Do you want to load the '$module_name' module to disable the autobrightness sensor?"; then
        # Run the command with sudo
        sudo modprobe -i "$module_name"
        gum log --structured --level debug "Module '$module_name' loaded successfully. The autobrightness sensor is now disabled. Please restart for this to take effect."
    else
        gum log --structured --level debug "Module loading aborted. The autobrightness sensor remains enabled."
    fi
}

# Call the function to load the kernel module if the user has a Framework 13-inch laptop
loadKernelModuleIfFramework13
