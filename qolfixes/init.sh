figlet "Laptop quality of life fixes"
echo "This section will add some laptop improvements to the system. These things include better hyprland, hyprlock settings, and more soon to come."

if gum confirm "Do you want to add some quality of life improvements for laptop usage?"; then
  # Read the file line by line
while IFS= read -r line; do
  # If the line starts with # and the next line is not the lines to be added
  if [[ $line == \#HandleLidSwitchDocked=ignore ]]; then
    # Add the new lines
    echo "HandleLidSwitchDocked=ignore" | sudo tee -a /etc/systemd/logind.conf > /dev/null
  fi
  if [[ $line == \#HoldoffTimeoutSec=5s ]]; then
    # Add the new lines
    echo "HoldoffTimeoutSec=5s" | sudo tee -a /etc/systemd/logind.conf > /dev/null
  fi
done < /etc/systemd/logind.conf
fi
