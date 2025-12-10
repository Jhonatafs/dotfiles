#!/bin/bash

# Cores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${GREEN}### Setup Pós-Instalação: Arch + Sway (Minimal) ###${NC}"

# 1. Lista de Pacotes Nativos (Essenciais + Drivers Genéricos)
PKGS=(
    # 1. Sistema Base, Drivers e Ferramentas de Compilação
    "base-devel" "git" "openssh" "man-db" "man-pages"
    "mesa" "libva-intel-driver" "intel-media-driver" "vulkan-intel"
    "nvidia" "nvidia-utils" "egl-wayland"
    "polkit-gnome" "xdg-desktop-portal-wlr" "xdg-user-dirs"
    "nodejs" "npm" "unzip" "flatpak"

    # 2. Interface Gráfica (Sway) e Bloqueio
    "sway" "swaybg" "swayidle" "swaylock"

    # 3. Shell (Zsh), Terminal e Prompt
    "zsh" "zsh-syntax-highlighting" "zsh-autosuggestions" "starship"
    "foot"

    # 4. Utilitários Wayland (Barra, Launcher, Notificações, Clipboard)
    "waybar" "mako" "fuzzel"
    "grim" "slurp" "wl-clipboard"
    # "gammastep"

    # 5. Gerenciadores de Arquivos (GUI + Terminal)
    "thunar" "thunar-archive-plugin" "thunar-volman" "gvfs" "gvfs-mtp" "file-roller"
    "yazi" "ffmpegthumbnailer" "unarchiver" "jq" "poppler" "fd" "ripgrep" "fzf" "zoxide"

    # 6. Editores de Texto e Monitoramento
    "neovim" "nano" "htop"

    # 7. Fontes e Tipografia
    "ttf-jetbrains-mono-nerd" "inter-font"
)

echo -e "${GREEN}-> Atualizando e instalando nativos...${NC}"
sudo pacman -Syu --needed --noconfirm "${PKGS[@]}"

# 2. Configurar Diretórios de Usuário (Downloads, Documents, etc.)
echo -e "${GREEN}-> Criando diretórios padrão (XDG)...${NC}"
xdg-user-dirs-update
mkdir ~/Imagens/Screenshots

# 3. Instalação do Paru (AUR Helper)
if ! command -v paru &> /dev/null; then
    echo -e "${BLUE}-> Instalando Paru (AUR)...${NC}"
    cd /tmp
    git clone https://aur.archlinux.org/paru-bin.git
    cd paru-bin
    makepkg -si --noconfirm
    cd ~
else
    echo -e "${BLUE}-> Paru já instalado.${NC}"
fi

# 4. Pacotes AUR
PACOTES=(
    "visual-studio-code-bin"
    "gruvbox-material-gtk-theme-git"
    # "capitaine-cursors-gruvbox"
    "nwg-look"
    "capitaine-cursors"
    # "bibata-cursor-theme"
    )
echo -e "${BLUE}-> Instalando Pacotes AUR...${NC}"
paru -S --needed --noconfirm "${PACOTES[@]}"

# 5. Configurar Flatpak e Instalar Apps
echo -e "${GREEN}-> Configurando Flatpak...${NC}"
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Lista de Flatpaks
FLATPAKS=(
    "com.github.tchx84.Flatseal"
    "org.mozilla.firefox"
    "org.inkscape.Inkscape"
)

echo -e "${GREEN}-> Instalando Flatpaks...${NC}"
for app in "${FLATPAKS[@]}"; do
    flatpak install -y flathub "$app"
done

# 6. Correções e Overrides (O Pulo do Gato)
echo -e "${GREEN}-> Aplicando correções de permissão (Sandbox)...${NC}"

# Firefox: Permitir acesso à pasta Home (resolve Downloads/Uploads)
flatpak override --user --filesystem=home org.mozilla.firefox

# Garantir posse da pasta de dados Flatpak (evita perda de senhas/config)
sudo chown -R $USER:$USER ~/.var

echo -e "${GREEN}### Setup Concluído! Reinicie o sistema ou o Sway. ###${NC}"
