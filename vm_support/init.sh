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
    echo "The script has detected that you run the installation in a KVM (virtual machine)."
    if grep -Fxq "kvm.conf" ~/dotfiles-versions/$version/hypr/conf/environment.conf
    then
        echo ":: KVM Environment already set."
    else
        if gum confirm "Do you want to install the KVM environment variables?" ;then
            echo "Setting environment variables for KVM..."
        cat > ~/dotfiles/hypr/conf/environment.conf << EOF
source = ~/dotfiles/hypr/conf/environments/kvm.conf
EOF
        fi
    fi
    if [[ $(_installPackagesPacman "${pkg}") == 0 ]]; then
        echo ":: Qemu Guest Agent already installed"
    else
        if gum confirm "Do you want to install the QEMU guest agent?" ;        then
        sudo pacman -S --needed --noconfirm qemu-guest-agent;
        fi
    fi
fi


