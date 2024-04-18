# ------------------------------------------------------
# Install wallpapers
# ------------------------------------------------------
echo -e "${GREEN}"
figlet "Wallpapers"
echo -e "${NONE}"
if [ ! -d ~/wallpaper ]; then
    echo "Do you want to download the wallpapers from repository https://gitlab.com/stephan-raabe/wallpaper/ ?"
    echo "If not, the script will install 3 default wallpapers in ~/wallpaper/"
    echo ""
    if gum confirm "Do you want to download the repository?" ;then
        git clone https://github.com/dianaw353/wallpaper ~/Downloads/
        cp ~/Downloads/wallpaper ~/
        rm -rf ~/wallpaper/.git
        echo "Wallpapers from the repository installed successfully."
    elif [ $? -eq 130 ]; then
        exit 130
    else
        if [ -d ~/wallpaper/ ]; then
            echo "wallpaper folder already exists."
        else
            mkdir ~/wallpaper
        fi
        cp -r ~/hyprland-starter/wallpaper/wallpaper/* ~/wallpaper
        echo "Default wallpapers installed successfully."
    fi
else
    echo ":: ~/wallpaper folder already exists."
fi
if [ -d ~/wallpaper ]; then
    _installSymLink wallpaper ~/wallpaper ~/dotfiles/wallpaper ~/.config
fi
echo ""

# ------------------------------------------------------
# Copy default wallpaper files to .cache
# ------------------------------------------------------

# Cache file for holding the current wallpaper
cache_file="$HOME/.cache/current_wallpaper"
rasi_file="$HOME/.cache/current_wallpaper.rasi"

# Create cache file if not exists
if [ ! -f $cache_file ] ;then
    mkdir $HOME/.cache
    touch $cache_file
    echo "$HOME/wallpaper/wallpaper2.jpg" > "$cache_file"
fi

# Create rasi file if not exists
if [ ! -f $rasi_file ] ;then
    touch $rasi_file
    echo "* { current-image: url(\"$HOME/wallpaper/wallpaper2.jpg\", height); }" > "$rasi_file"
fi
