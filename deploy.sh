#!/bin/bash

# base
sudo apt-get update
sudo apt-get install -y aptitude vim-gnome tmux trash-cli msttcorefonts cabextract ack-grep xclip curl

# gnome 3
sudo apt-add-repository -y ppa:gnome3-team/gnome3
sudo apt-add-repository -y ppa:gnome3-team/gnome3-staging
sudo apt-add-repository -y ppa:ricotz/testing
sudo aptitude update

sudo apt-get -y dist-upgrade
sudo aptitude install -y gnome-shell gnome-shell-extensions gnome-session gnome-common
sudo aptitude install -y bijiben polari gnome-clocks gnome-weather gnome-maps gnome-music gnome-photos gnome-documents gnome-contacts gnome-sushi gnome-boxes gnome-shell-extensions gnome-weather gnome-maps gnome-photos gnome-music
sudo aptitude install gdm

# uninstall unity
sudo apt-get remove -y unity unity-asset-pool unity-control-center unity-control-center-signon unity-gtk-module-common unity-lens* unity-services unity-settings-daemon unity-webapps* unity-voice-service

# keybindings
cat org.gnome.desktop.wm.keybindings.dconf | dconf load /org/gnome/desktop/wm/keybindings/

# multiple-monitor workspaces
gsettings set org.gnome.shell.overrides workspaces-only-on-primary false

# focus follows mouse (the One True Way)
gsettings set org.gnome.desktop.wm.preferences focus-mode 'mouse'

# high-dpi gnome
gsettings set org.gnome.desktop.interface scaling-factor 1

# paper theme
sudo add-apt-repository -y ppa:snwh/pulp
sudo apt-get update
sudo apt-get install -y paper-gtk-theme paper-icon-theme

gsettings set org.gnome.shell exnabled-extensions "['user-theme@gnome-shell-extensions.gcampax.github.com']"
gsettings set org.gnome.desktop.interface gtk-theme "Paper"
gsettings set org.gnome.desktop.wm.preferences theme "Paper"
gsettings set org.gnome.shell.extensions.user-theme name "Paper" 
gsettings set org.gnome.desktop.interface icon-theme "Paper"

# powerline fonts
git clone https://github.com/powerline/fonts.git /tmp/powerline-fonts/
sudo mkdir /usr/share/fonts/powerline/
find /tmp/powerline-fonts/ \( -name '*.[o,t]tf' -o -name '*.pcf.gz' \) -type f -print0 | sudo xargs -0 -I % cp -v "%" /usr/share/fonts/powerline/
rm -rf /tmp/powerline-fonts

# vista fonts
wget 'http://download.microsoft.com/download/f/5/a/f5a3df76-d856-4a61-a6bd-722f52a5be26/PowerPointViewer.exe' -O /tmp/PowerPointViewer.exe
cabextract /tmp/PowerPointViewer.exe -d /tmp/pptviewer
cabextract /tmp/pptviewer/ppviewer.cab -d /tmp/pptviewer/cab
sudo mkdir /usr/share/fonts/vista/
find /tmp/pptviewer/cab/ -name '*.TT[F,C]' -type f -print0 | sudo xargs -0 -I % cp -v "%" /usr/share/fonts/vista/
rm -rf /tmp/pptviewer
rm /tmp/PowerPointViewer.exe

# gnome-terminal
cat org.gnome.terminal.legacy.dconf | dconf load /org/gnome/terminal/legacy/

# terminfo
tic xterm-256color-italic.terminfo

# dotfiles
mkdir -p ~/Devel
git clone https://github.com/jessedhillon/dotfiles.git ~/Devel/dotfiles
wget https://thoughtbot.github.io/rcm/debs/rcm_1.2.3-1_all.deb -O /tmp/rcm_1.2.3-1_all.deb
sudo dpkg -i /tmp/rcm_1.2.3-1_all.deb
rm /tmp/rcm_1.2.3-1_all.deb
cd ~/
rcup -v -d ~/Devel/dotfiles

# vim
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo -e ":PluginInstall\n:qall" > /tmp/plugin_install.vim
vim -s /tmp/plugin_install.vim
rm /tmp/plugin_install.vim

# google chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo aptitude update
sudo aptitude install -y google-chrome-stable

# final touch
gsettings set org.gnome.desktop.interface clock-show-date true