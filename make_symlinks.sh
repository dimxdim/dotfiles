#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
# list of files/folders to symlink in homedir
files="
Xmodmap
Xresources
bash_profile
bashrc
dark-term-theme.sh
emacs
gtkrc-2.0
inputrc
no-screensaver.sh
vim-myplugins
vim-notes
vimrc
ycm-mybuildcommands
"
##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv --verbose ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s --verbose $dir/$file ~/.$file
done
