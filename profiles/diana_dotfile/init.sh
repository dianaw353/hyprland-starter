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
cp -r ~/starter-dotfile/gtk ~/dotfiles/
cp -r ~/starter-dotfile/hypr ~/dotfiles/
echo "Installing dotfiles"
if [ -d ~/dotfiles-versions/$version/alacritty ]; then
    _installSymLink alacritty ~/.config/alacritty ~/dotfiles/alacritty ~/.config
fi
if [ -d ~/dotfiles-versions/$version/hypr ]; then
    _installSymLink hypr ~/.config/hypr ~/dotfiles/hypr ~/.config
fi
if [ -d ~/dotfiles-versions/$version/gtk ]; then
    _installSymLink gtk ~/.config/gtk ~/dotfiles/gtk ~/.config
fi
cd ~/hyprland-starter
