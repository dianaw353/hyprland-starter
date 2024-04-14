#!/bin/bash
figlet "GPU Drivers"
source ./library.sh
echo "What GPU drivers would you like to install?"
## Function to select GPU drivers for multiple brands
selectGPUDrivers() {
    options=("amd" "intel" "nvidia")
    selected_brands=$(gum choose --no-limit "${options[@]}")
    echo "$selected_brands"
}

installGPUDrivers() {
  local selected_brands=$1
  for selected_brand in $selected_brands; do
    local file_path="${selected_brand}.txt"
    echo "Resolved file path: $(readlink -f "$file_path")"

    if [ -f "$file_path" ]; then
      echo "Installing GPU drivers for $selected_brand from file: $file_path"
      _installPackagesPacman "$file_path" || echo "ERROR: Failed to install GPU drivers for $selected_brand"
      if [ "$selected_brand" == "nvidia" ]; then
        echo "Setting environment variables for NVIDIA drivers..."
        cat > ~/starter-dotfile/hypr/conf/environment.conf << EOF
source = ~/starter-dotfile/hypr/conf/environments/nvidia.conf
EOF
      fi
    else
      echo "No GPU drivers found for $selected_brand"
    fi
  done
}

## Function to install wine if the user chooses to install it
installWine() {
    question="Do you want to install wine? It's a compatibility layer for running Windows applications on Linux."
    if gum confirm "$question"; then
        echo "Installing wine..."
        options=("amd" "intel" "nvidia")
        selected_brands=$(gum choose --no-limit "${options[@]}")
        for selected_brand in $selected_brands; do
            local file_path="32bit${selected_brand}.txt"
            echo "Resolved file path: $(readlink -f "$file_path")"

            if [ -f "$file_path" ]; then
                echo "Installing 32bit GPU drivers for $selected_brand from file: $file_path"
                _installPackagesPacman "$file_path" || echo "ERROR: Failed to install 32bit GPU drivers for $selected_brand"
            else
                echo "No 32bit GPU drivers found for $selected_brand"
            fi
        done
    else
        echo "Skipping wine installation."
    fi
}

## Example usage:
selected_brands=$(selectGPUDrivers)
installGPUDrivers "$selected_brands"
installWine
