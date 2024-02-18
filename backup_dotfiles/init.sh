datets=$(date '+%Y%m%d%H%M%S')
figlet "Backup Dotfiles"
echo "Now looking for dotfiles to backup and shell scrips..."
if [ -d ~/.config ] || [ -e ~/.bashrc ] || [ -e ~/.zshrc ]; then
    if [ -d ~/dotfiles ]; then
        echo ":: The script has detected an existing dotfiles folder and will try to create a backup into the folder:"
        echo "   ~/dotfiles-versions/backups/$datets"
    fi
    if [ -e ~/.bashrc ]; then
        echo ":: The script has detected an existing .bashrc file and will try to create a backup to:"
        echo "   ~/dotfiles-versions/backups/$datets/.bashrc-old"
    fi
    if [ -e ~/.zshrc ]; then
        echo ":: The script has detected an existing .bashrc file and will try to create a backup to:"
        echo "   ~/dotfiles-versions/backups/$datets/.zshrc-old"
    fi
    if gum confirm "Do you want to create a backup?"; then
        if [ ! -d ~/dotfiles-versions ]; then
            mkdir ~/dotfiles-versions
            echo "~/dotfiles-versions created."
        fi
        if [ ! -d ~/dotfiles-versions/backups ]; then
            mkdir ~/dotfiles-versions/backups
            echo "~/dotfiles-versions/backups created"
        fi
        if [ ! -d ~/dotfiles-versions/backups/$datets ]; then
            mkdir ~/dotfiles-versions/backups/$datets
            echo "~/dotfiles-versions/backups/$datets created"
        fi
        if [ -d ~/dotfiles ]; then
            rsync -a ~/dotfiles/ ~/dotfiles-versions/backups/$datets/
            echo ":: Backup of your current dotfiles in ~/dotfiles-versions/backups/$datets created."
        fi
        if [ -e ~/.bashrc ]; then
            cp ~/.bashrc ~/dotfiles-versions/backups/$datets/.bashrc-old
            echo ":: Existing .bashrc file found in homefolder. .bashrc-old created"
        fi
        if [ -e ~/.zshrc ]; then
            cp ~/.zshrc ~/dotfiles-versions/backups/$datets/.zshrc-old
            echo ":: Existing .zshrc file found in homefolder. .zshrc-old created"
        fi

    elif [ $? -eq 130 ]; then
        exit 130
    else
        echo ":: Backup skipped."
    fi
    echo ""
fi
