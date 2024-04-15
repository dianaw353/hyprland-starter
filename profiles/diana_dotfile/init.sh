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
mkdir ~/dotfiles
cp -r ~/starter-dotfile/alacritty ~/dotfiles/
cp -r ~/starter-dotfile/hypr ~/dotfiles/
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
cd ~/hyprland-starter
