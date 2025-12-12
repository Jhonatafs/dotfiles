# Meu setup

_Meus dotfiles pessoais gerenciados via **Git Bare Repository**._

> ![Área de Trabalho](/.config/assets/clean.png)
> ![Grid](/.config/assets/busy.png)
> ![Info](/.config/assets/info.png)
> ![Menu](/.config/assets/menu.png)

> **Abreviações:**
>
> FP - Flatpak

## Stack

- **OS:** Arch Linux
- **WM:** Sway (Wayland)
- **Bar:** Waybar
- **Terminal:** Foot
- **Launcher:** Fuzzel
- **Browser:** Firefox (FP) & Brave (FP)
- **Editor:** VSCode (AUR) & Neovim
- **Arquivos:** Thunar & Yazi
- **Extras:** Paru (AUR)

---

## Instalação em Nova Máquina

### 1. Git (Pré-Requisito)

```bash
sudo pacman -S git
```

### 2. Clonar o Repositório (Método Bare)

O repositório ficará oculto em `.cfg` e os arquivos serão expandidos para a `$HOME`.

1. Clone o repo bare para uma pasta oculta

```bash
git clone --bare git@github.com:jhonfs/dotfiles.git $HOME/.cfg
```

2. Defina o alias temporário para esta sessão

```bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

3. Restaure os arquivos para a sua Home

```bash
config checkout
```

_Nota: Se houver erro de arquivos existentes (conflito), faça backup deles ou apague-os e rode o checkout novamente._

### 3. Pós-Instalação Automatizada

Execute o script de setup que instalará pacotes, drivers, fontes e configurará o Flatpak, etc.

- Torne executável (se ainda não for)

```bash
chmod +x ~/.local/bin/setup.sh
```

- Execute

```bash
~/.local/bin/setup.sh
```

#### Manutenção

Atualizar Tudo (Pacman + AUR + Flatpak): `up`

Gerenciar Dotfiles: Use o comando `config` (ex: `config status`, `config push)`.

---

## Comandos Úteis

Como este é um repositório bare, não use o comando `git` diretamente. Use o alias `config`:

- **Verificar status:** `config status`
- **Adicionar arquivo:** `config add arquivo`
- **Commitar:** `config commit -m "Mensagem"`
- **Enviar alterações:** `config push`

## Atalhos

### Sistema e Aplicações

| Atalho | Ação | Comando/Descrição |
| :--- | :--- | :--- |
| `$mod` + `Return` | Abrir Terminal | Executa o emulador `foot`. |
| `$mod` + `d` | Abrir Menu | Executa o lançador `fuzzel`. |
| `$mod` + `F2` | Arquivos (Terminal) | Abre o gerenciador `yazi` no terminal. |
| `$mod` + `F3` | Arquivos (GUI) | Abre o gerenciador gráfico `thunar`. |
| `$mod` + `Shift` + `q` | Menu de Sistema | Exibe barra para Desligar, Reiniciar ou Sair. |
| `$mod` + `Shift` + `r` | Recarregar | Recarrega as configurações do Sway. |
| `$mod` + `Escape` | Bloquear | Bloqueia a tela com `swaylock`. |

### 🪟 Gestão de Janelas

| Atalho | Ação | Descrição |
| :--- | :--- | :--- |
| `$mod` + `q` | Fechar | Encerra a janela focada. |
| `Alt` + `F4` | Fechar | Alternativa para encerrar a janela. |
| `$mod` + `f` | Tela Cheia | Alterna o modo *fullscreen*. |
| `$mod` + `Shift` + `Espaço` | Flutuar | Alterna entre modo tiling e flutuante. |
| `$mod` + `Espaço` | Foco de Modo | Alterna o foco entre janelas flutuantes e fixas. |

### 🧭 Navegação e Movimentação

As teclas de navegação seguem o padrão VIM (`h, j, k, l`) ou as setas direcionais.

| Atalho | Ação | Detalhes |
| :--- | :--- | :--- |
| `$mod` + `h/j/k/l` | Mover Foco | Alterna o foco para Esquerda, Baixo, Cima ou Direita. |
| `$mod` + `Setas` | Mover Foco | Alterna o foco usando as setas do teclado. |
| `$mod` + `Shift` + `h/j/k/l` | Mover Janela | Move a janela focada na direção indicada. |
| `$mod` + `Shift` + `Setas` | Mover Janela | Move a janela focada usando as setas. |

### Layouts e Divisões

| Atalho | Ação | Descrição |
| :--- | :--- | :--- |
| `Alt` + `Dir`/`Esq` | Dividir Horizontal | Prepara a próxima janela para abrir horizontalmente (`splith`). |
| `Alt` + `Cima`/`Baixo` | Dividir Vertical | Prepara a próxima janela para abrir verticalmente (`splitv`). |
| `$mod` + `s` | Empilhado | Muda o layout para *Stacking* (pilha). |
| `$mod` + `Tab` | Abas | Muda o layout para *Tabbed* (abas). |
| `$mod` + `e` | Alternar Divisão | Alterna o tipo de divisão (split) padrão. |
| `$mod` + `r` | Redimensionar | Entra no modo de ajuste de tamanho da janela. |

### Workspaces e Scratchpad

| Atalho | Ação | Descrição |
| :--- | :--- | :--- |
| `$mod` + `0-9` | Mudar Workspace | Alterna para a área de trabalho numerada. |
| `$mod` + `Shift` + `0-9` | Mover Janela | Envia a janela focada para a área numerada.  |
| `$mod` + `Shift` + `-` | Ocultar (Scratchpad) | Envia a janela para a "gaveta" invisível. |
| `$mod` + `-` | Mostrar (Scratchpad) | Traz a janela do Scratchpad de volta como flutuante. |

### Captura de Tela e Multimídia

| Atalho | Ação | Comportamento |
| :--- | :--- | :--- |
| `Print` | Captura Total | Salva a tela inteira em `~/Imagens/Screenshots`. |
| `$mod` + `Shift` + `s` | Seleção (Copiar) | Seleciona área e copia para a área de transferência. |
| `Ctrl` + `Print` | Seleção (Salvar) | Seleciona área e salva o arquivo. |
| `$mod` + `F5` | Wallpaper | Define um papel de parede aleatório da pasta `~/Imagens/wallpapers/`. |
| `$mod` + `F9` | Transparência On | Define opacidade do Firefox para 0.95. |
| `$mod` + `F10` | Transparência Off | Define opacidade do Firefox para 1.0. |