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

# 5. Backup do Sistema
config add ~/.cfg-system/ 2>/dev/null

# Commit, Pull & Push
config commit -m "Atualização de todos os arquivos"
config pull
config push
