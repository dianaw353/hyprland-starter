figlet "Profiles"
echo "What profile would you like to use?"
# Generate a list of profiles in the current directory
profiles=($(ls -d */profiles))

# Remove the trailing slash from each profile name
profiles=("${profiles[@]%/}")

# Display the list of profiles using gum and prompt the user to make a selection
profile=$(gum choose "${profiles[@]}")

# If a profile was selected
if [[ -n $profile ]]; then
    # Print the selected profile
    echo "You have selected $profile."

    # Source the init.sh script in the selected profile directory
    if [[ -f "$profile/init.sh" ]]; then
        source "$profile/init.sh"
    else
        echo "The init.sh script in the $profile directory could not be found."
    fi
fi
