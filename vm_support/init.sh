#!/bin/bash

_isKVM() {
    iskvm=$(sudo dmesg | grep "Hypervisor detected")
    if [[ "$iskvm" =~ "KVM" ]] ;then
        echo 0
    else
        echo 1
    fi
}

if [ $(_isKVM) == "0" ]; then
  figlet "KVM VM"

  # Ask the user if they want to install the KVM environment variables using gum confirm
  if gum confirm "Do you want to install KVM environment variables?"
  then
    # Empty the contents of the environment.conf file

    # Add the line to source the kvm.conf file
    echo "source = ~/dotfiles/hypr/conf/environments/kvm.conf" > ~/dotfiles/hypr/conf/environment.conf
    echo "KVM environment variables installed!"
  fi
fi
