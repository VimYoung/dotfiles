#!/bin/sh
sudo dnf upgrade

# Installing Essential programs
sudo dnf install git curl wget #Mostly already installed.
# COnfigure ssh and add generate a key.

# Enabling RPM packages.
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf4 update @core
# Above didn't work and required interuption
# eww copy paste and build probably f'ed up, it didn't build up.
# oh-my-posh installation didn't work on re=opening kitty, it needs to be installed on zsh.
# Also make a way to install and setup rose pine normal and hyprcursor.

# Enabling necessary copr files
sudo dnf copr enable solopasha/hyprland
sudo dnf copr enable atim/lazygit -y
sudo dnf copr enable erikreider/SwayNotificationCenter
sudo dnf copr enable sneexy/zen-browser

# necessary Directory creations.
mkdir -p ~/Pictures/Screenshots
mkdir -p ~/Pictures/Camera
mkdir -p ~/Videos/Screencasts
mkdir -p ~/Videos/Camera
mkdir -p ~/Mail # FOr neomutt
## Creating fonts directory
sudo mkdir -p /usr/local/share/fonts/iosevka
sudo mkdir -p /usr/local/share/fonts/iA-Writer
sudo mkdir -p /usr/local/share/fonts/Panchang
sudo mkdir -p /usr/local/share/fonts/CascadiaCode

# Setup from command line, change following settings of obs studio.
# 1. Change default video typ to mp4
# 2. Change default saving location.

# Installing and setting up fonts
## Iosevka
# Permission is denied some where, some of these commands need to be run as sudo.
# zen browser not installed.
wget https://github.com/be5invis/Iosevka/releases/download/v33.0.1/PkgTTC-Iosevka-33.0.1.zip
unzip ~/PkgTTC-Iosevka-33.0.1.zip -d /usr/local/share/fonts/iosevka/
sudo chown -R root: /usr/local/share/fonts/iosevka
sudo chmod 644 /usr/local/share/fonts/iosevka/*
sudo restorecon -vFr /usr/local/share/fonts/iosevka
rm -f ~/PkgTTC-Iosevka-33.0.1.zip
## CascadiaCove font (nerd)
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/CascadiaCode.zip
unzip ~/CascadiaCode.zip -d /usr/local/share/fonts/CascadiaCode/
sudo chown -R root: /usr/local/share/fonts/CascadiaCode
sudo chmod 644 /usr/local/share/fonts/CascadiaCode/*
sudo restorecon -vFr /usr/local/share/fonts/CascadiaCode
rm -f CascadiaCode.zip
## iA writer (nerd)
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/iA-Writer.zip
unzip ~/iA-Writer.zip -d /usr/local/share/fonts/iA-Writer/
sudo chown -R root: /usr/local/share/fonts/iA-Writer
sudo chmod 644 /usr/local/share/fonts/iA-Writer/*
sudo restorecon -vFr /usr/local/share/fonts/iA-Writer
rm -f iA-Writer.zip
## Panchang for eww
wget "https://api.fontshare.com/v2/fonts/download/panchang" -O panchang.zip
unzip ~/iA-Writer.zip -d /usr/local/share/fonts/Panchang/
cp /usr/local/share/fonts/Panchang/Panchang_Complete/Fonts/TTF/Panchang-Variable.ttf /usr/local/share/fonts/Panchang/
rm -rf /usr/local/share/fonts/Panchang/Panchang_Complete/
sudo chown -R root: /usr/local/share/fonts/Panchang
sudo chmod 644 /usr/local/share/fonts/Panchang/*
sudo restorecon -vFr /usr/local/share/fonts/Panchang
rm -f ~/panchang.zip

# Updating the font cache.
sudo fc-cache -v

## Installing Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
. "$HOME/.cargo/env"
rustc --version
echo "\n\n RUST INSTALLED \n\n"

# Installing Necessary build tools
sudo dnf install cmake ninja-build g++ socat fontawesome-fonts-all

# Install papirus icon theme for fuzzel and gtk4 theme.
sudo dnf install papirus-icon-theme
# Other gtk themes/cursor themes are already included in .icons and .themes in chezmoi.
# Cloning necessary obsidian files and  moving the scripts into them.

# Installing necessary software
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin # kitty
## Hyprland and other related utils.
sudo dnf install hyprland hyprland-devel hyprpicker hypridle hyprsunset hyprpolkitagent hyprshot cliphist hyprsysteminfo hypridle hyprlock waybar
## fuzzel IMV zathura and its pdf plugin wlogout pavucontrol zen
sudo dnf install fuzzel imv zathura zathura-pdf-poppler wlogout pavucontrol
sudo dnf install zen-browser
## powernotd
cargo install powernotd

# Setting zsh, antigen and setting zsh as default.
sudo dnf install zsh
cd ~
curl -L git.io/antigen >antigen.zsh
chsh -s $(which zsh) # Sets zsh by as default but only works after logout login.
# zsh # converts to zsh for the reset of script, Might ask for config.
curl -s https://ohmyposh.dev/install.sh | bash -s
echo "\n\n ZSH ANTIGEN OHMYPOSH INSTALLED AND SET. \n\n"

# Installing necessary command line utilities.
## zoxide, bat.
cargo install zoxide --locked
cargo install --locked bat
bat --completion zsh
## peaclock
cd ~
git clone https://github.com/octobanana/peaclock
cd peaclock
./RUNME.sh install
cd ~
## tealdeer, ripgrep and eza
cargo install ripgrep eza tealdeer
## diesel CLI
curl --proto '=https' --tlsv1.2 -LsSf https://github.com/diesel-rs/diesel/releases/latest/download/diesel_cli-installer.sh | sh
## cava
sudo dnf install alsa-lib-devel fftw3-devel pulseaudio-libs-devel libtool iniparser-devel pkgconf
git clone https://github.com/karlstav/cava
cd ~/cava
./autogen.sh
./configure
sudo make
sudo make install
cd ~
## fastfetch
git clone https://github.com/fastfetch-cli/fastfetch
cd fastfetch
mkdir -p build
cd build
cmake ..
sudo cmake --build . --target fastfetch
sudo make install
cd ~
## btop brightnessctl playerctl lazygit ranger
sudo dnf install btop brightnessctl playerctl lazygit ranger SwayNotificationCenter
## nvim and vim
sudo dnf install ncurses-devel
git clone https://github.com/vim/vim.git
cd vim/src
make distclean # if you build Vim before
make
sudo make install
### neovim
cd ~
sudo dnf -y install ninja-build cmake gcc make gettext curl glibc-gconv-extra
git clone https://github.com/neovim/neovim
cd neovim
sudo make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
## Compile hyprpaper with papermerise and hyprlock natively.
git clone https://github.com/hyprwm/hyprlock
## cd hyprlock
cargo install --git https://gitlab.com/imn1/paperizer.git
## neomutt notmuch and lieer config and setup gmi and gogle auth
## harlequin
## Installing and setting up eww, also place the sound files in downloads for rightmarks to access.
sudo dnf install gtk3-devel libdbusmenu-gtk3-devel gtk-layer-shell-devel
cd ~
git clone https://github.com/elkowar/eww
cd eww
cargo build --release --no-default-features --features=wayland
cd target/release
cp ./eww ~/.local/bin/
chmod +x ~/.local/bin/eww

## nmcli and networkmanager-dmenu
mkdir -p ~/.local/bin
curl -L -o ~/.local/bin/networkmanager_dmenu https://raw.githubusercontent.com/firecat53/networkmanager-dmenu/main/networkmanager_dmenu
chmod +x ~/.local/bin/networkmanager_dmenu
## chezmoi installation itself.
## optionally install exercism
## Instructions for installing and setting up ly display manager.

# Installing necessary languages
### Installing Python command line tools.
## harlequin
## uv
## pip

## Installing Lua 5.3.6 with luarocks of the same as neovim doesn't work on the latest.
## Installing Go

## FInd a method to somehow automaticcaly install all the firefox and thinderbird and
## zen extensions.

# Installing flatpak applications.
sudo flatpak update
sudo flatpak install flathub md.obsidian.Obsidian
sudo flatpak install flathub com.discordapp.Discord
sudo flatpak install flathub com.tominlab.wonderpen
sudo flatpak install flathub com.obsproject.Studio

# Echoing necessary steps.
echo " \n 
#############################
Post Intallation Instructions
#############################

1. First open neovim and use :checkhealth for completing and downloading uninstalled utilities.
2. Open your firefox/zen browser, enable dark theme if not already.
3. Install all the extensions and import nightTab theme from assets.
4. Set VLC, zathura, Imv as default applications.
5. Set up git and ssh for your private repos to work in both github and codeberg
6. Setup and see the installation of oh-my-posh
7. Setup firefox toolbar with fullscreen and private in right and home and pocket in left.

Alternatively, you can run following commands on regular basis to keep the system updated
sudo dnf update
sudo flatpak update
cd neovim
sudo make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
cd ~
tldr --update
sudo rustup update

"
