#!/bin/bash

# Cores para o output
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${GREEN}### Iniciando Setup Pós-Instalação do Arch (Sway Minimal) ###${NC}"

# 1. Lista de Pacotes Nativos (Essenciais + Drivers Genéricos)
# Nota: Incluímos ambos os drivers Intel (antigo e novo) para compatibilidade.
PKGS=(
    "sway" "swaybg" "swayidle" "swaylock" # Interface
    "waybar" "mako" "fuzzel" # Utilitários Wayland
    "foot" "neovim" "nano" "htop" "git" "base-devel" "openssh" # Ferramentas
    "polkit-gnome" "xdg-desktop-portal-wlr" # Sistema
    "ttf-jetbrains-mono-nerd" "inter-font" # Fontes
    "xdg-user-dirs" # Cria pastas Downloads, etc.
    "flatpak" # Gerenciador de pacotes isolados
    "mesa" # Gráficos base
    "libva-intel-driver" # Intel Video (Gen 2-7)
    "intel-media-driver" # Intel Video (Gen 8+)
    "vulkan-intel" # Vulkan Intel
    "man-db" "man-pages" 

    #"gammastep"
)

echo -e "${GREEN}-> Atualizando sistema e instalando pacotes nativos...${NC}"
sudo pacman -Syu --needed --noconfirm "${PKGS[@]}"

# 2. Configurar Diretórios de Usuário (Downloads, Documents, etc.)
echo -e "${GREEN}-> Criando diretórios padrão (XDG)...${NC}"
xdg-user-dirs-update

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

# 4. VSCode (Via AUR para acesso ao sistema)
echo -e "${BLUE}-> Instalando VSCode (Binário Oficial)...${NC}"
paru -S --needed --noconfirm visual-studio-code-bin

# 5. Configurar Flatpak e Instalar Apps
echo -e "${GREEN}-> Configurando Flatpak...${NC}"
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Lista de Flatpaks
FLATPAKS=(
    "org.mozilla.firefox"
    "com.github.tchx84.Flatseal"
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
