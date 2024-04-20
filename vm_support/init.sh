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
    # Change the end of the first line in the environment.conf file to kvm.conf
    sed -i 's/^.*$/& kvm.conf/' ~/dotfiles/hypr/conf/environment.conf
    figlet "KVM environment variables installed!"
  fi
fi
