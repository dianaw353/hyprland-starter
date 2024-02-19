#!/bin/bash
figlet "GPU Drivers"
echo "To provide you the best experiance its needed to install these drivers."
echo "Genernally, on linux you do not need to worry about drivers being made for a specific GPU such as a Nvidia RTX (4060)."
echo "Instead you just need to know what brand you GPU is from and the current brands that are supported are: AMD, Intel, NVIDIA."
echo "NOTE: I have provided some fixes for Nvidia but it will only be unofficall as I do not have the hardware."

# Function to select GPU drivers for multiple brands
selectGPUDrivers() {
    question="Which GPU Drivers do you want to install? (space-separated)"
    options=("amd" "intel" "nvidia")
    selected_brands=$(gum choose --no-limit "${options[@]}")
    echo "$selected_brands"
}

# Function to install GPU drivers for the selected brands
installGPUDrivers() {
    local selected_brands=$1
    for selected_brand in $selected_brands; do
        local file_path="gpu_drivers/${selected_brand}.txt"
        echo "$file_path"
        echo "Installing mesa and glu which is both library for Open GL that work no matter what brand you use."
        sudo pacman -S --noconfirm "mesa" "glu"

        if [ -f "$file_path" ]; then
            _installPackagesPacman "$file_path" || echo "ERROR: Failed to install GPU drivers for $selected_brand"

            # Set environment variables based on the selected GPU brand
            if [ "$selected_brand" == "nvidia" ]; then
                echo "Setting environment variables for NVIDIA drivers..."
                echo "env = LIBVA_DRIVER_NAME,nvidia" >> ~/Hyprland-Starter/hypr/conf/env/default.conf
                echo "env = XDG_SESSION_TYPE,wayland" >> ~/Hyprland-Starter/hypr/conf/env/default.conf
                echo "env = GBM_BACKEND,nvidia-drm" >> ~/Hyprland-Starter/hypr/conf/env/default.conf
                echo "env = __GLX_VENDOR_LIBRARY_NAME,nvidia" >> ~/Hyprland-Starter/hypr/conf/env/default.conf
                echo "env = WLR_NO_HARDWARE_CURSORS,1" >> ~/Hyprland-Starter/hypr/conf/env/default.conf
            fi
        else
            echo "ERROR: Invalid file path for $selected_brand"
        fi
    done
}

# Function to install wine if the user chooses to install it
installWine() {
    question="Do you want to install wine? It's a compatibility layer for running Windows applications on Linux."
    if gum confirm "$question"; then
        echo "Installing wine..."
        sudo pacman -S wine
    else
        echo "Skipping wine installation."
    fi
}

# Example usage:
selected_brands=$(selectGPUDrivers)
installGPUDrivers "$selected_brands"
installWine
