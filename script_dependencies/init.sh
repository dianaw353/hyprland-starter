echo "Checking if pacman.conf parallel downloads is disabled and if so enable it."
echo "We want to enable parallel downloads so we can download all required packages effectively and efficiently."

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

echo "Checking if [multilib] and Include = /etc/pacman.d/mirrorlist are uncommented and in the correct order in /etc/pacman.conf"

# Search for the lines containing "[multilib]" and "Include = /etc/pacman.d/mirrorlist"
multilib_line=$(grep "^\[multilib\]" /etc/pacman.conf)
include_line=$(grep "Include = /etc/pacman.d/mirrorlist" /etc/pacman.conf)

# Check if the lines are commented out
if [[ $multilib_line == \#* ]]; then
  echo "[multilib] line is commented out: $multilib_line"
else
  if [[ $include_line == \#* ]]; then
    echo "Include = /etc/pacman.d/mirrorlist line is commented out: $include_line"
  else
    # Check if the lines are in the correct order
    if [[ $(grep -n "^\[multilib\]" /etc/pacman.conf | cut -d: -f1) -eq $(grep -n "Include = /etc/pacman.d/mirrorlist" /etc/pacman.conf | cut -d: -f1) - 1 ]]; then
      echo "[multilib] and Include = /etc/pacman.d/mirrorlist are in the correct order: $multilib_line $include_line"
    else
      echo "[multilib] and Include = /etc/pacman.d/mirrorlist are not in the correct order: $multilib_line $include_line"
    fi
  fi
fi

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
