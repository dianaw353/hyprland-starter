figlet "Diana Starter Dotfiles"
source ./library.sh
read -p "Press enter to continue install the dotfiles."
echo "Downloading dotfiles"
cd ~/
git clone --depth=1 https://github.com/dianaw353/starter-dotfile.git
cd ~/starter-dotfile
echo "Installing dotfiles dependencies"
_installPackageAur "/home/$(whoami)/starter-dotfile/profiles/diana_dotfile/packages.txt"
version=$(cat .version/version)
echo "$version"
echo "Copping dotfiles to $version"
mkdir ~/dotfiles-versions
mkdir ~/dotfiles-versions/$version
cp -r ~/starter-dotfile/alacritty ~/dotfiles-versions/$version/
cp -r ~/starter-dotfile/gtk ~/dotfiles-versions/$version/
cp -r ~/starter-dotfile/hypr ~/dotfiles-versions/$version/
cp -r ~/starter-dotfile/dunst ~/dotfiles-versions/$version/
cp -r ~/starter-dotfile/rofi ~/dotfiles-versions/$version/
cp -r ~/starter-dotfile/scripts ~/dotfiles-versions/$version/
cp -r ~/starter-dotfile/starship ~/dotfiles-versions/$version/
cp -r ~/starter-dotfile/waybar ~/dotfiles-versions/$version/
cp -r ~/starter-dotfile/wlogout ~/dotfiles-versions/$version/
cp -r ~/starter-dotfile/.settings ~/dotfiles-versions/$version/
cp -r ~/starter-dotfile/.version ~/dotfiles-versions/$version/
cp ~/starter-dotfile/update.sh ~/dotfiles-versions/$version/
cp ~/starter-dotfile/.zshrc ~/dotfiles-versions/$version/
cp ~/starter-dotfile/.zshrc_aliases ~/dotfiles-versions/$version/
cp -r ~/starter-dotfile/wal/templates ~/dotfiles-versions/$version/wal
mkdir ~/dotfiles
cp -r ~/starter-dotfile/alacritty ~/dotfiles/
cp -r ~/starter-dotfile/hypr ~/dotfiles/
cp -r ~/starter-dotfile/gtk ~/dotfiles/
cp -r ~/starter-dotfile/dunst ~/dotfiles/
cp -r ~/starter-dotfile/rofi ~/dotfiles/
cp -r ~/starter-dotfile/scripts ~/dotfiles/
cp -r ~/starter-dotfile/starship ~/dotfiles/
cp -r ~/starter-dotfile/waybar ~/dotfiles/
cp -r ~/starter-dotfile/wlogout ~/dotfiles/
cp -r ~/starter-dotfile/.settings ~/dotfiles/
cp -r ~/starter-dotfile/.version ~/dotfiles/
cp ~/starter-dotfile/update.sh ~/dotfiles/
cp ~/starter-dotfile/.zshrc ~dotfiles/
cp ~/starter-dotfile/.zshrc_aliases ~/dotfiles/
cp -r ~/tarter-dotfile/wal/templates ~/dotfiles/wal
# Installing GTK Files
# Remove existing symbolic links
gtk_symlink=0
gtk_overwrite=1
if [ -L ~/.config/gtk-3.0 ]; then
  rm ~/.config/gtk-3.0
  gtk_symlink=1
fi

if [ -L ~/.config/gtk-4.0 ]; then
  rm ~/.config/gtk-4.0
  gtk_symlink=1
fi

if [ -L ~/.gtkrc-2.0 ]; then
  rm ~/.gtkrc-2.0
  gtk_symlink=1
fi

if [ -L ~/.Xresources ]; then
  rm ~/.Xresources
  gtk_symlink=1
fi

if [ "$gtk_symlink" == "1" ] ;then
  echo ":: Existing symbolic links to GTK configurations removed"
fi

if [ -d ~/.config/gtk-3.0 ] ;then
  echo "The script has detected an existing GTK configuration."
  if gum confirm "Do you want to overwrite your configuration?" ;then
    gtk_overwrite=1
  else
    gtk_overwrite=0
  fi
fi

if [ "$gtk_overwrite" == "1" ] ;then
  cp -r gtk/gtk-3.0 ~/.config/
  cp -r gtk/gtk-4.0 ~/.config/
  cp -r gtk/xsettingsd ~/.config/
  cp gtk/.gtkrc-2.0 ~/
  cp gtk/.Xresources ~/
  echo ":: GTK Theme installed"
fi

echo "Installing dotfiles"
if [ -d ~/dotfiles-versions/$version/alacritty ]; then
    _installSymLink alacritty ~/.config/alacritty ~/dotfiles/alacritty ~/.config
fi
if [ -d ~/dotfiles-versions/$version/hypr ]; then
    _installSymLink hypr ~/.config/hypr ~/dotfiles/hypr ~/.config
fi
if [ -d ~/dotfiles-versions/$version/dunst ]; then
    _installSymLink dunst ~/.config/dunst ~/dotfiles/dunst ~/.config
fi
if [ -d ~/dotfiles-versions/$version/rofi ]; then
    _installSymLink rofi ~/.config/rofi ~/dotfiles/rofi ~/.config
fi
if [ -d ~/dotfiles-versions/$version/scripts ]; then
    _installSymLink scripts ~/.config/scripts ~/dotfiles/scripts ~/.config
fi
if [ -d ~/dotfiles-versions/$version/starship ]; then
    _installSymLink starship ~/.config/starship ~/dotfiles/starship ~/.config
fi
if [ -d ~/dotfiles-versions/$version/waybar ]; then
    _installSymLink waybar ~/.config/waybar ~/dotfiles/waybar ~/.config
fi
if [ -d ~/dotfiles-versions/$version/wlogout ]; then
    _installSymLink wlogout ~/.config/wlogout ~/dotfiles/wlogout ~/.config
fi
if [ -d ~/dotfiles-versions/$version/wal ]; then
    _installSymLink wal ~/.config/wal ~/dotfiles/wal ~/.config
fi
cp ~/dotfiles/.zshrc ~/
cp ~/dotfiles/.zshrc_aliases ~/
mkdir ~/Pictures/screenshots
cd ~/hyprland-starter
