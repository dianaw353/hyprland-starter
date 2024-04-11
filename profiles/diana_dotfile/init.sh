figlet "Diana Starter Dotfiles"
source ./library.sh
read -p "Press enter to continue install the dotfiles."
echo "Downloading dotfiles"
cd ~/
git clone --depth=1 https://github.com/dianaw353/starter-dotfile.git
cd ~/hyprland-starter
echo "Installing dotfiles dependencies"
_installPackageAur "/home/$(whoami)/hyprland-starter/profiles/diana_dotfile/packages.txt"
cd ~/starter-dotfile
version=$(cat .version/version)
echo "$version"
echo "Copping dotfiles to $version"
mkdir ~/dotfiles-versions
mkdir ~/dotfiles-versions/$version
cp -r ~/starter-dotfile/alacritty ~/dotfiles-versions/$version/
#cp -r ~/starter-dotfile/dunst ~/dotfiles-versions/$version/
cp -r ~/starter-dotfile/gtk ~/dotfiles-versions/$version/
cp -r ~/starter-dotfile/hypr ~/dotfiles-versions/$version/
#cp -r ~/starter-dotfile/wlogout ~/dotfiles-versions/$version/
mkdir ~/dotfiles
echo "Installing dotfiles"
if [ -d ~/dotfiles-versions/$version/alacritty ]; then
    _installSymLink alacritty ~/.config/alacritty ~/dotfiles/alacritty/ ~/.config
fi
if [ -d ~/dotfiles-versions/$version/hypr ]; then
    _installSymLink hypr ~/.config/hypr ~/dotfiles/hypr/ ~/.config
fi
if [ -d ~/dotfiles-versions/$version/gtk ]; then
    _installSymLink gtk ~/.config/gtk ~/dotfiles/gtk/ ~/.config
fi
#if [ -d ~/dotfiles-versions/$version/wlogout ]; then
#    _installSymLink wlogout ~/.config/wlogout ~/dotfiles/wlogout/ ~/.config
#fi
#if [ -d ~/dotfiles-versions/$version/dunst ]; then
#    _installSymLink dunst ~/.config/dunst ~/dotfiles/dunst/ ~/.config
#fi
cd ~/hyprland-starter
# echo "Downloading wallpaper"
# echo "Installing wallpaper"
# echo "Setting up greetd"
# echo "Switching shell to zsh"
