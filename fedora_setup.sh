#!/bin/bash
# Fedora Installation Script
# This script removes KDE bloatware and installs niri window manager with a complete ricing setup
# Exit on error
set -e
# Color codes for better readability
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color
echo -e "${GREEN}=== Starting installation process ===${NC}"
echo -e "${BLUE}Updating system packages...${NC}"
sudo dnf update -y
# Remove KDE Plasma bloatware
echo -e "${RED}Removing KDE Plasma bloatware...${NC}"
sudo dnf remove -y \
    kaddressbook kmail kontact korganizer akregator konversation \
    kmahjongg kmines kpat ksudoku dragon kmag kmousetool kmouth \
    krfb krdc plasma-discover kde-connect telepathy* kf5-akonadi* \
    kwrite k3b kget kamoso juk kcolorchooser falkon kcharselect \
    kbackup kdeconnect* kdegraphics-thumbnailers kdenetwork-filesharing \
    kdeplasma-addons kdepim* kdepim-* kfind khelpcenter khotkeys kinfocenter \
    kmousetool kmouth kolourpaint konqueror konsole krfb kruler krusader \
    kscreen ksshaskpass ktorrent kwalletmanager 
# Clean up dependencies
echo -e "${BLUE}Cleaning up dependencies...${NC}"
sudo dnf autoremove -y
# Enable RPM Fusion repositories for additional packages
echo -e "${BLUE}Setting up RPM Fusion repositories...${NC}"
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
# Install Terminal Apps
echo -e "${BLUE}Installing terminal applications...${NC}"
sudo dnf install -y kitty zsh vim neovim tmux fastfetch
# Install Shell Customization
echo -e "${BLUE}Installing Oh My Zsh...${NC}"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# Install Zsh plugins and themes
echo -e "${BLUE}Installing Zsh plugins...${NC}"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
# Install Wayland Tools
echo -e "${BLUE}Installing Wayland tools...${NC}"
sudo dnf install -y rofi waybar mako wl-clipboard grim slurp
# Install Terminal Apps
echo -e "${BLUE}Installing terminal applications...${NC}"
sudo dnf install -y kitty zsh vim neovim tmux fastfetch
# Install Shell Customization
echo -e "${BLUE}Installing Oh My Zsh...${NC}"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# Install useful plugins (removed zsh-autosuggestions)
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
# Install Wayland Tools
echo -e "${BLUE}Installing Wayland tools...${NC}"
sudo dnf install -y rofi waybar mako wl-clipboard grim slurp
  
# Install Yazi file manager
echo -e "${BLUE}Installing Yazi file manager...${NC}"
cargo install yazi
# Install Thunar file manager
echo -e "${BLUE}Installing Thunar file manager...${NC}"
sudo dnf install -y thunar thunar-archive-plugin thunar-volman
# Install Media Tools
echo -e "${BLUE}Installing media applications...${NC}"
sudo dnf install -y vlc mpv cava
# Install Messaging & Gaming
echo -e "${BLUE}Installing Discord and Steam...${NC}"
sudo dnf install -y discord steam
# Install spotify-player
echo -e "${BLUE}Installing spotify-player...${NC}"
cargo install spotify-player
# Note: You'll need to configure spotify-player with your Spotify credentials
# Install Vencord (Discord client mod)
echo -e "${BLUE}Installing Vencord...${NC}"
curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh | sh
# Install Brave browser
echo "Installing Brave browser..."
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install -y brave-browser

# Install Proton Suite
echo -e "${BLUE}Installing Proton suite (Pass, VPN, Mail)...${NC}"

# Install Proton Pass
echo -e "${BLUE}Installing Proton Pass...${NC}"
sudo dnf install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.proton.pass

# Install Proton VPN
echo -e "${BLUE}Installing Proton VPN...${NC}"
cd /tmp
wget https://repo.protonvpn.com/fedora-$(rpm -E %fedora)/protonvpn-stable-release.rpm
sudo dnf install -y ./protonvpn-stable-release.rpm
sudo dnf install -y proton-vpn-gnome-desktop

# Install Proton Mail Bridge for desktop email clients
echo -e "${BLUE}Installing Proton Mail Bridge...${NC}"
sudo dnf install -y flatpak
flatpak install -y flathub ch.protonmail.protonmail-bridge

# Install a native email client to use with Proton Mail Bridge
echo -e "${BLUE}Installing Thunderbird email client for Proton Mail...${NC}"
sudo dnf install -y thunderbird

# Install Ricing Tools
echo -e "${BLUE}Installing tools for ricing...${NC}"
# Install swww for wallpaper
echo -e "${BLUE}Installing swww wallpaper daemon...${NC}"
cargo install swww
# Install wallust for color schemes
echo -e "${BLUE}Installing wallust...${NC}"
cargo install wallust
# Install additional ricing tools
echo -e "${BLUE}Installing additional ricing tools...${NC}"
sudo dnf install -y picom lxappearance papirus-icon-theme fontconfig
cargo install hyprpicker
# Install fonts
echo -e "${BLUE}Installing fonts for customization...${NC}"
sudo dnf install -y fira-code-fonts jetbrains-mono-fonts mozilla-fira-mono-fonts google-noto-emoji-fonts
# Install Nerd Fonts
echo -e "${BLUE}Installing Nerd Fonts...${NC}"
mkdir -p ~/.local/share/fonts
cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip FiraCode.zip -d ~/.local/share/fonts/FiraCode
unzip JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMono
fc-cache -fv
# Create a base i3 configuration for inspiration (even though you'll use niri)
echo -e "${BLUE}Creating base configurations for reference...${NC}"
mkdir -p ~/.config/waybar
cat > ~/.config/waybar/config << 'EOF'
{
    "layer": "top",
    "position": "top",
    "modules-left": ["wlr/workspaces"],
    "modules-center": ["clock"],
    "modules-right": ["network", "pulseaudio", "battery"],
    "clock": {
        "format": "{:%H:%M | %d/%m/%Y}",
        "tooltip": true
    },
    "battery": {
        "format": "{capacity}% {icon}",
        "format-icons": ["", "", "", "", ""]
    },
    "network": {
        "format-wifi": " {essid}",
        "format-disconnected": "⚠ Disconnected"
    },
    "pulseaudio": {
        "format": "{volume}% {icon}",
        "format-muted": "",
        "format-icons": {
            "default": ["", ""]
        }
    }
}
EOF
# Create kitty config
mkdir -p ~/.config/kitty
cat > ~/.config/kitty/kitty.conf << 'EOF'
# Kitty Configuration
font_family      JetBrainsMono Nerd Font
bold_font        auto
italic_font      auto
bold_italic_font auto
font_size 12.0
# Window padding
window_padding_width 10
# Transparency
background_opacity 0.95
# Colors
foreground #f8f8f2
background #282a36
EOF
# Create a basic zshrc
cat > ~/.zshrc << 'EOF'
# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"
# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"
# Plugins (removed zsh-autosuggestions)
plugins=(
  git
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh
# User configuration
alias ls='ls --color=auto'
alias ll='ls -la'
alias ff='fastfetch'
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
EOF
echo -e "${GREEN}=== Installation complete! ===${NC}"
echo -e "${YELLOW}You may need to create a proper display manager entry for niri"
echo -e "or add it to your ~/.xinitrc if you're using startx.${NC}"
echo -e "${GREEN}=== Next steps for ricing ===${NC}"
echo -e "1. Configure waybar: ~/.config/waybar/config"
echo -e "2. Configure niri: ~/.config/niri/config.yaml"
echo -e "3. Set up wallpapers with swww"
echo -e "4. Generate color schemes with wallust"
echo -e "5. Customize kitty terminal: ~/.config/kitty/kitty.conf"
echo -e "6. Customize zsh with powerlevel10k: run 'p10k configure'"
echo -e "7. Install and configure bling widgets for enhanced appearance"
echo -e "${GREEN}=== Proton Suite Setup ===${NC}"
echo -e "1. Configure Proton Pass: Open the application and sign in with your Proton account"
echo -e "2. Configure Proton VPN: Open the application and sign in with your Proton account"
echo -e "3. Configure Proton Mail Bridge: Open the application, sign in, and follow instructions to set up with Thunderbird"
