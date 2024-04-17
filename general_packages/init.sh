echo "General Packages"
echo "Installing general packages thats needed for any install."
_installPackagesPacman "general_packages/packages.txt"
echo "All packages installed correctly."
echo "Createing common used directories"
xdg-user-dirs-update
