#!/bin/bash
# Script de Configuração Automatizada do Arch Linux
# Autor: [Seu Nome]
# Data: 2026

set -e

BOLD="\e[1m"
RESET="\e[0m"
GREEN="\e[32m"
BLUE="\e[34m"
RED="\e[31m"

PACMAN_COMMON_PKGS=(
    "base-devel" "man-db" "man-pages"
    "git" "nano" "neovim" "numlockx"
    "pacman-contrib" "reflector" "expac"
    "network-manager-applet" "nm-connection-editor"
    "ufw" "gufw" "ufw-extras"
    "openssh"
    "htop" "iotop" "iftop" "nethogs"
    "inxi" "lm_sensors" "sysstat"
    "tree" "ncdu"
    "yazi" "tldr" "bc" "calc" "bat"
    "speedtest-cli" "mtr" "nmap"
    "wget" "curl" "rsync"
    "7zip" "unzip" "unrar"
    "ntfs-3g" "exfatprogs" "f2fs-tools"
    "gcc" "make" "cmake"
    "python" "python-pip" "python-virtualenv" "python-pipx"
    "nodejs" "npm"
    "pandoc" "ffmpeg"
    "acpi" "acpi_call"
    "ttf-jetbrains-mono" "ttf-nerd-fonts-symbols" "adobe-source-han-sans-otc-fonts"
    "nwg-look" "qt5ct" "qt6ct" "kvantum" "papirus-icon-theme"
)

SWAY_PKGS=(
    "sway" "wlroots" "seatd"
    "swaybg" "swayidle" "swaylock"
    "grim" "slurp" "wl-clipboard" "wf-recorder"
    "waybar" "mako" "fuzzel"
    "swaykbdd" "kanshi" "wlopm" "wlsunset"
    "xdg-desktop-portal" "xdg-desktop-portal-wlr"
    "xorg-xwayland"
    "qt5-wayland" "qt6-wayland" "glfw-wayland"
    "polkit-gnome" "gnome-keyring" "libsecret"
    "thunar" "thunar-archive-plugin" "thunar-volman" "gvfs" "tumbler" "mpv"
)

XFCE_PKGS=(
    "xfce4" "xfce4-goodies"
    "xfwm4" "xfce4-panel" "xfdesktop" "xfce4-session" "xfce4-settings"
    "thunar" "thunar-archive-plugin" "thunar-media-tags-plugin" "tumbler"
    "xfce4-appfinder" "xfce4-notifyd" "xfce4-power-manager"
    "xfce4-pulseaudio-plugin" "xfce4-screenshooter" "xfce4-taskmanager"
    "xfce4-terminal" "xfce4-whiskermenu-plugin" "xfce4-xkb-plugin"
    "gtk-engine-murrine" "gtk-engines" "xfce4-artwork"
    "gvfs" "polkit-gnome" "lightdm" "lightdm-gtk-greeter"
)

INTEL_DRIVERS=(
    "vulkan-intel"
    "intel-media-driver"
    "libva-intel-driver"
    "intel-ucode"
)

AMD_DRIVERS=(
    "vulkan-radeon"
    "libva-mesa-driver"
    "amd-ucode"
)

NVIDIA_DRIVERS=(
    "nvidia-dkms"
    "nvidia-utils"
    "nvidia-settings"
    "egl-wayland"
    "opencl-nvidia"
)

AUR_PKGS=(
    "otf-lucide-icons"
    "gruvbox-material-theme-git"
    "gruvbox-material-icon-theme-git"
    "capitaine-cursors-gruvbox"
    "kvantum-theme-gruvbox-git"
)

FLATPAK_PKGS=(
    "com.github.tchx84.Flatseal"
    "com.visualstudio.code"
    "md.obsidian.Obsidian"
    "org.libreoffice.LibreOffice"
    "org.kde.okular"
    "org.mozilla.firefox"
    "com.brave.Browser"
    "org.inkscape.Inkscape"
    "com.github.johnfactotum.Foliate"
    "org.qbittorrent.qBittorrent"
)

DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"

# --- Funções Auxiliares ---

msg_info() {
    echo -e "${BLUE}${BOLD}[INFO]${RESET} $1"
}

msg_success() {
    echo -e "${GREEN}${BOLD}[OK]${RESET} $1"
}

msg_error() {
    echo -e "${RED}${BOLD}[ERRO]${RESET} $1"
    exit 1
}

header() {
    clear
    echo -e "${BOLD}========================================${RESET}"
    echo -e "${BOLD}   ARCH LINUX SETUP - CONFIGURAÇÃO      ${RESET}"
    echo -e "${BOLD}========================================${RESET}"
    echo ""
}

# --- Funções de Seleção ---



select_video_driver() {
    header
    echo "Selecione a Configuração de Hardware (GPU):"
    echo "1) Intel  (iGPU)"
    echo "2) AMD    (iGPU / Dedicada)"
    echo "3) NVIDIA"
    echo "4) Intel + NVIDIA"
    echo "5) Máquina Virtual / Genérico"
    echo -n "Opção: "
    read -r driver_opt

    case $driver_opt in
        1)
            PACMAN_COMMON_PKGS+=("${INTEL_DRIVERS[@]}")
            ;;
        2)
            PACMAN_COMMON_PKGS+=("${AMD_DRIVERS[@]}")
            ;;
        3)
            PACMAN_COMMON_PKGS+=("${NVIDIA_DRIVERS[@]}")
            ;;
        4)
            echo "Configurando modo Híbrido (Optimus)..."
            PACMAN_COMMON_PKGS+=("${INTEL_DRIVERS[@]}")
            PACMAN_COMMON_PKGS+=("${NVIDIA_DRIVERS[@]}")
            ;;
        5)
            PACMAN_COMMON_PKGS+=("xf86-video-vmware" "xf86-video-qxl" "mesa")
            ;;
        *)
            msg_error "Opção inválida."
            ;;
    esac
}

select_interface() {
    header
    echo "Selecione a Interface Gráfica:"
    echo "1) Sem Interface"
    echo "2) Sway (Wayland)"
    echo "3) XFCE (X11)"
    echo "4) Sway + XFCE"
    echo -n "Opção: "
    read -r interface_opt

    case $interface_opt in
        1)
            msg_info "Modo sem interface selecionado."
            ;;
        2)
            msg_info "Sway selecionado."
            PACMAN_COMMON_PKGS+=("${SWAY_PKGS[@]}")
            ;;
        3)
            msg_info "XFCE selecionado."
            PACMAN_COMMON_PKGS+=("${XFCE_PKGS[@]}")
            ;;
        4)
            msg_info "Sway e XFCE selecionados."
            PACMAN_COMMON_PKGS+=("${SWAY_PKGS[@]}")
            PACMAN_COMMON_PKGS+=("${XFCE_PKGS[@]}")
            ;;
        *)
            msg_error "Opção inválida."
            ;;
    esac
    sleep 1
}

# --- Funções de Instalação ---

install_pacman() {
    header
    msg_info "Atualizando sistema e instalando pacotes do Pacman..."
    
        sudo pacman -Syu --noconfirm "${PACMAN_COMMON_PKGS[@]}"

        sudo systemctl enable ufw
        sudo systemctl enable sddm

    msg_success "Pacotes base instalados e serviços habilitados."
    sleep 2
}

install_paru() {
    header
    if ! command -v paru &> /dev/null; then
        msg_info "Instalando gerenciador AUR (Paru)..."

        local TEMP_DIR=$(mktemp -d)

        git clone https://aur.archlinux.org/paru.git "$TEMP_DIR"

        chown -R "USER:$USER" "$TEMP_DIR"
        (
            cd "$TEMP_DIR"
            makepkg -si --noconfirm --needed
        )
        
        rm -rf "$TEMP_DIR"
        msg_success "Paru instalado."
    else
        msg_info "Paru já está instalado."
    fi
    sleep 2
}

install_aur() {
    header
    msg_info "Instalando pacotes AUR..."
    
    paru -S --noconfirm "${AUR_PKGS[@]}"

    msg_success "Pacotes AUR instalados."
    sleep 2
}

install_flatpak() {
    header
    msg_info "Instalando Flatpaks..."

    sudo pacman -S --noconfirm flatpak
    flatpak install -y flathub "${FLATPAK_PKGS[@]}"

    msg_success "Flatpaks instalados."
    sleep 2
}

setup_user_dirs() {
    header
    msg_info "Padronizando diretórios do usuário (XDG)..."

    mkdir -p "$HOME/.config"

    # Define a configuração explicitamente em inglês
    cat > "$HOME/.config/user-dirs.dirs" << EOF
XDG_DESKTOP_DIR="$HOME/Desktop"
XDG_DOWNLOAD_DIR="$HOME/Downloads"
XDG_TEMPLATES_DIR="$HOME/Templates"
XDG_PUBLICSHARE_DIR="$HOME/Public"
XDG_DOCUMENTS_DIR="$HOME/Documents"
XDG_MUSIC_DIR="$HOME/Music"
XDG_PICTURES_DIR="$HOME/Pictures"
XDG_VIDEOS_DIR="$HOME/Videos"
EOF

    source "$HOME/.config/user-dirs.dirs"

    mkdir -p "$XDG_DESKTOP_DIR" \
             "$XDG_DOWNLOAD_DIR" \
             "$XDG_TEMPLATES_DIR" \
             "$XDG_PUBLICSHARE_DIR" \
             "$XDG_DOCUMENTS_DIR" \
             "$XDG_MUSIC_DIR" \
             "$XDG_PICTURES_DIR" \
             "$XDG_VIDEOS_DIR"

    xdg-user-dirs-update

    msg_success "Estrutura de pastas criada."
}

copy_configs() {
    header

    local REPO="./files"

    msg_info "Aplicando configurações do sistema e do usuário..."
    
    # Bashrc
    if [ -f "$REPO/bashrc_append" ]; then
        if ! grep -q "### CUSTOM GLOBAL CONFIG ###" /etc/bash.bashrc; then
            msg_info "Atualizando /etc/bash.bashrc..."
            echo -e "\n### CUSTOM GLOBAL CONFIG ###" | sudo tee -a /etc/bash.bashrc
            sudo cat "$REPO/bashrc_append" | sudo tee -a /etc/bash.bashrc
        fi
    fi

    if [ -f "$REPO_SCRIPTS_DIR/numlock" ]; then
        sudo install -Dm755 "$REPO_SCRIPTS_DIR/numlock" /usr/local/bin/numlock
    fi

    if [ -f "$REPO/numlock.service" ]; then
        sudo install -Dm644 "$REPO/numlock.service" /etc/systemd/system/
        sudo systemctl enable numlock.service
    fi

    # Systemd Services
    if [ -f "system/numlock.service" ]; then
        sudo systemctl daemon-reload
        sudo systemctl enable numlock.service
    fi
    
    # Firewall (UFW)
    msg_info "Configurando Firewall (UFW)..."
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    # Permite SSH se necessário (limite para evitar brute-force)
    sudo ufw limit ssh
    # Habilita o firewall (sem pedir confirmação)
    sudo ufw --force enable

    # Sway
    if [ -d "$REPO/sway" ]; then
        msg_info "Configurando Sway Global..."
        sudo install -dm755 /etc/sway
        # Sobrescreve o config padrão do Arch
        sudo install -Dm644 "$REPO/sway/config" /etc/sway/config
        # Copia scripts auxiliares do sway (ex: weather.sh, status.sh) se houver
        if [ -d "$REPO/sway/scripts" ]; then
            sudo install -dm755 /etc/sway/scripts
            sudo install -m755 "$REPO/sway/scripts/"* /etc/sway/scripts/
        fi
    fi

    # Waybar
    if [ -d "$REPO/waybar" ]; then
        msg_info "Configurando Waybar Global..."
        sudo install -dm755 /etc/xdg/waybar
        sudo install -Dm644 "$REPO/waybar/config" /etc/xdg/waybar/config
        sudo install -Dm644 "$REPO/waybar/style.css" /etc/xdg/waybar/style.css
    fi

    if [ -d "$REPO_CONFIG_DIR/fuzzel" ]; then
        msg_info "Configurando Fuzzel Global..."
        sudo install -dm755 /etc/xdg/fuzzel
        sudo install -Dm644 "$REPO/fuzzel/fuzzel.ini" /etc/xdg/fuzzel/fuzzel.ini
    fi
    
    # Mako
    if [ -d "$REPO/mako" ]; then
        sudo install -dm755 /etc/xdg/mako
        sudo install -Dm644 "$REPO/mako/config" /etc/xdg/mako/config
    fi

    # GTK
    msg_info "Aplicando tema GTK Global..."
    sudo install -dm755 /etc/gtk-3.0
    sudo tee /etc/gtk-3.0/settings.ini > /dev/null <<EOF
[Settings]
gtk-theme-name=Gruvbox-Material-Dark
gtk-icon-theme-name=Gruvbox-Material-Dark
gtk-font-name=JetBrains Mono 10
gtk-cursor-theme-name=Capitaine-Cursors-Gruvbox
gtk-application-prefer-dark-theme=1
EOF

    # Wallpapaer
    if [ -d "$REPO/wallpaper" ]; then
        msg_info "Instalando papéis de parede..."
        sudo install -dm755 /usr/share/backgrounds/gruvbox
        sudo install -m644 "$REPO/wallpaper/"* /usr/share/backgrounds/gruvbox/
    fi

    # SDDM
    if [ -f "$REPO/sddm.conf" ]; then
        msg_info "Configurando SDDM..."
        sudo install -dm755 /etc/sddm.conf.d
        sudo install -Dm644 "$REPO/sddm.conf" /etc/sddm.conf.d/custom.conf
        
        if [ -d "$REPO/sddm-theme" ]; then
             sudo cp -r "$REPO/sddm-theme" /usr/share/sddm/themes/gruvbox-custom
        fi
    fi

    # Paru

    if [ -f "$DIR" ]; then
        msg_info "Aplicando configurações otimizadas em /etc/paru.conf..."
        sudo install -Dm644 "$DIR/paru.conf" /etc/paru.conf
        msg_success "Configuração do Paru aplicada."
    fi

    msg_success "Configurações globais aplicadas. Novos usuários herdarão este padrão."
    sleep 1
}

# --- Execução Principal ---

main() {
    select_video_driver
    select_interface
    
    install_pacman
    setup_user_dirs
    copy_configs
    install_paru
    install_aur
    install_flatpak
    
    header
    msg_success "Instalação concluída com êxito."
}

main