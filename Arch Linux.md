# Setup: Arch Linux 

## Instalação do Arch Linux
- ArchInstall Minima (BTRFS, Zram, Snapshot auto, etc...)

## Pós Instalação

### Pré-Interface Gráfica
- Editor de Texto: `nano` e `neovim`
- Configurar  o "Network Manager"
- Conectar-se a Internet: `nmcli`, `nm-applet`
- Configurar "Num Lock"
- Configuração do "Pac-Man"
- Instalação do `Paru` e `Yay`
- Configuração da instalação e armazenamento via `Paru`e `Yay`
- Script para ajuste das "Mirror" com `reflector`
- Instalar e Configurar o `flatpak` + `flatseal` e `flathub`
- Aplicações:
	- Documentação: `man-db`, `man-pages`, `man-pages-pt_br`,  `info`, `tldr`
	- ~~Editor de Texto: `nano` e `neovim`~~
	- Gerenciador de Arquivos: `yazi`
	- Monitoramento do Sistema: `htop` e `atop`
	- Informações do Sistema: `inxi` e `lshw`
	- ~~Ajuste de "Mirror":  `reflector`~~
	- Desenvolvimento: `base-devel`, `git`

#### Edições

`~/.bashrc`
```
export PATH=~/.npm-global/bin:$PATH
export PATH=$PATH:~/.local/bin
```

Arch, Debian: `/etc/bash.bashr` ou Fedora `/etc/bashrc` 

```
export LS_COLORS='di=1;34:ln=1;36:ex=1;31:*.tar=31:*.tgz=31:*.zip=31:*.gz=31'
alias ls='ls --color=auto --group-directories-first -F'

# Set collation to 'C' locale for natural, case-sensitive sorting (0,1,2...9,10)
export LC_COLLATE="C.UTF-8"

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias ..='cd ..'
alias ...='cd ../..'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# PS1

```

