#!/bin/bash

# Get the current user
current_user=$(whoami)

# Replace the user "dianaa" with the current user in the config.toml file
sed -i "s|^user = \"dianaa\"|user = \"$current_user\"|" config.toml
