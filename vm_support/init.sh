_isKVM() {
    iskvm=$(sudo dmesg | grep "Hypervisor detected")
    if [[ "$iskvm" =~ "KVM" ]] ;then
        echo 0
    else
        echo 1
    fi
}

if [ $(_isKVM) == "0" ] ;then
    figlet "KVM VM"
    echo "The script has detected that you run the installation in a KVM virtual machine."
    if grep -Fxq "kvm.conf" ~/dotfiles-versions/$version/hypr/conf/environment.conf
    then
        echo ":: KVM Environment already set."
    else
        if gum confirm "Do you want to install the KVM environment variables?" ;then
            echo "source = ~/dotfiles/hypr/conf/environments/kvm.conf" >  ~/dotfiles-versions/$version/hypr/conf/environment.conf
            echo "Environment set to KVM."
        fi
    fi
    if [[ $(_installPackagesPacman "${pkg}") == 0 ]]; then
        echo ":: Qemu Guest Agent already installed"
    else
        if gum confirm "Do you want to install the QEMU guest agent?" ;then
            sudo pacman -S qemu-guest-agent;
        fi
    fi
fi

updateConfigFile() {
    # Ask the user if they are using a VM using Gum
    if gum confirm "Are you using a VM?"; then
        # Add a line to the config file
        echo "env = WLR_NO_HARDWARE_CURSORS, 1" >> "$HOME/.config/hypr/conf/env/default.conf"
        echo "env = WLR_RENDERER_ALLOW_SOFTWARE, 1" >> "$HOME/.config/hypr/conf/env/default.conf"
        echo "Configuration updated for VM usage."
    else
        echo "No changes made to the configuration."
    fi
}

# Call the function to update the config file
#updateConfigFile
