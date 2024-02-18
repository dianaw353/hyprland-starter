echo "Installing script dependencies..."
while read p; do
  if pacman -Q $p &> /dev/null; then
    echo "The package '$p' is already installed."
  else
    echo "The package '$p' is not installed. Installing..."
    if sudo pacman -S --needed --noconfirm $p; then
      echo "The package '$p' has been installed successfully."
    else
      echo "Failed to install the package '$p'. Exiting the script."
      exit 1
    fi
  fi
done <~/hyprland-starter/script_dependencies/packages.txt
echo "All packages installed correctly."
