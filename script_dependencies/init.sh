figlet "Script Dependencies"
echo "Checking if pacman.conf parallel downloads is disabled and if so enable it."
echo "We want to enable parallel downloads so we can download all required packages effectively and effeciently."

# Search for the line containing "ParallelDownloads = 5"
line=$(grep "ParallelDownloads = 5" /etc/pacman.conf)

# Check if the line starts with a '#' character
if [[ $line == \#* ]]; then
  # Remove the '#' character from the beginning of the line
  echo "Modifying pacman.conf to enable parallel downloads."
  new_line=$(echo $line | sed 's/^#//')

  # Replace the original line with the new line in the configuration file
  sudo sed -i "s/$line/$new_line/g" /etc/pacman.conf

  # Display a message indicating that the line was modified
  echo "Modified line: $new_line"
else
  # Check if the line is already uncommented
  if [[ $line == ParallelDownloads\ =\ 5 ]]; then
    # Display a message indicating that the line does not need to be modified
    echo "Line already uncommented: $line"
  else
    # Display a message indicating that the line is missing or commented out
    echo "Line not found or commented out: $line"
  fi
fi

echo "Installing script dependencies..."
sudo pacman -Syy
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

echo "Checking if pacman.conf has multilib repository enabled and enabling it if not."
echo "We want to enable the multilib repository so we can install 32-bit packages."

# Check if the '[multilib]' section exists and is uncommented
if grep -Fxq "[multilib]" /etc/pacman.conf; then
  echo "The '[multilib]' section already exists in pacman.conf."
  if grep -Fxq "#\[multilib\]" /etc/pacman.conf; then
    echo "The '[multilib]' section is commented out. Uncommenting it."
    sudo sed -i "s/#\[multilib\]/\[multilib\]/g" /etc/pacman.conf
  else
    echo "The '[multilib]' section is already uncommented."
  fi
else
  echo "The '[multilib]' section does not exist in pacman.conf. Adding it."
  sudo sed -i '$a\[multilib]\nInclude = /etc/pacman.d/mirrorlist' /etc/pacman.conf
fi

echo "Modified pacman.conf to add or enable the multilib repository."
