figlet "Profiles"
echo "What profile would you like to use?"

# Find the hyprland-starter directory in the home directory
hyprland_starter_dir="$HOME/hyprland-starter"

# Generate a list of profiles (directories) in the hyprland-starter directory
profiles=("$hyprland_starter_dir/profiles/"*/)

# Remove the trailing slash from each profile name and the hyprland-starter directory
profiles=("${profiles[@]%/}")
hyprland_starter_dir="${hyprland_starter_dir%/}"

# Extract the names of the profiles (directories) from the full paths
profile_names=("${profiles[@]##$hyprland_starter_dir/profiles/}")

# Display the list of profiles using gum and prompt the user to make a selection
profile=$(gum choose "${profile_names[@]}")

# If a profile was selected
if [[ -n $profile ]]; then
    # Print the selected profile
    echo "You have selected $profile."

    # Get the full path of the selected profile
    profile_path="${hyprland_starter_dir}/profiles/$profile"
    echo "$profile_path"
    # Source the init.sh script in the selected profile directory
    if [[ -f "$profile_path/init.sh" ]]; then
        source "$profile_path/init.sh"
    else
        echo "The init.sh script in the $profile directory could not be found."
    fi
fi
