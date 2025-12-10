# === ZSH CONFIG (Power Minimal) ===

# 1. Histórico
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY # Compartilha histórico entre terminais abertos

# 2. Plugins Nativos do Arch (Rapidez extrema)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# 3. Prompt (Starship)
eval "$(starship init zsh)"

# 4. Aliases (Traga os seus do bashrc)
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -l'
alias la='ls -la'
alias v='nvim'
alias vim='nvim'

# 5. Completions (Tab mágica)
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

# 6. PATH
export PATH="$HOME/.local/bin:$PATH"

# 7. Keybindings (Corrige Home/End/Delete)
bindkey "^[[3~" delete-char
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
