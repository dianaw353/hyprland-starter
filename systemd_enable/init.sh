figlet "Systemd Conf"

echo "This section is for autostarting hyprland, enabling bluetooth support and among other things"

if gum confirm "Do you want to enable bluetooth service?"; then
  echo "Installing bluetooth dependencies..."
  sudo pacman -S --needed --noconfirm bluez bluez-utils
  echo "Enabling bluetooth service"
  sudo systemctl start bluetooth.service
  sudo systemctl enable bluetooth.service
else
  echo "Not enabling bluetooth service"
fi

echo "Current method of autostarting Hyprland is using greetd"

if gum confirm "Do you want to autostart hyprland upon system boot?"; then
  echo "Installing greetd..."
  sudo pacman -S --needed --noconfirm greetd
  current_user=$(whoami)
  sed -i "s|^user = \"diana\"|user = \"$current_user\"|" config.toml
  sudo mv ~/hyprland-starter/systemd_enable/config.toml /etc/greetd
else
  echo "NOT autostarting hyprland upon system boot"
fi
