#!/bin/bash

config() {
  /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME "$@"
}

# 1. Arquivos da Raiz
config add ~/.bashrc ~/.bash_profile ~/.zshrc ~/.gitconfig ~/.makepkg.conf ~/README.md

# 2. Scripts
config add ~/.local/bin/

# 3. Configurações Principais (.config)
config add ~/.config/sway/
config add ~/.config/waybar/
config add ~/.config/foot/
config add ~/.config/fuzzel/
config add ~/.config/mako/
config add ~/.config/nvim/
config add ~/.config/yazi/
config add ~/.config/starship.toml

# 4. Configurações de Sistema/GUI
config add ~/.config/gtk-3.0/
config add ~/.config/Thunar/uca.xml
config add ~/.config/mimeapps.list
config add ~/.config/user-dirs.dirs
config add ~/.config/code-flags.conf
config add ~/.config/xdg-desktop-portal/sway-portals.conf
config add ~/.config/mimeapps.list

# 5. Backup do Sistema
config add ~/.cfg-system/ 2>/dev/null

# 6. Backup Setup VsCode
# Adiciona as configurações de usuário
config add ~/.config/Code/User/settings.json
config add ~/.config/Code/User/keybindings.json
config add ~/.config/code-flags.conf
env -i sh -c 'code --list-extensions > ~/.config/Code/User/extensions.txt'
config add ~/.config/Code/User/extensions.txt

# Commit, Pull & Push
config commit -m "Atualização de todos os arquivos"
config pull
config push origin main
