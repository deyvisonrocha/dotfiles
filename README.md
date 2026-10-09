# dotfiles

Configurações do meu ambiente para macOS. Shell: **fish** + **kitty**.

## Install

Escolha o shell alvo do setup via `TARGET_SHELL` (padrão: `fish`):

```bash
make                     # setup com fish (padrão)
make TARGET_SHELL=zsh    # setup com zsh
make fish                # atalho -> fish
make zsh                 # atalho -> zsh
```

## Stack

| Ferramenta | Papel |
|------------|-------|
| [fish](https://fishshell.com) | Shell principal |
| [kitty](https://sw.kovidgoyal.net/kitty/) | Terminal (`kitty/`) |
| [Ghostty](https://ghostty.org) | Terminal alternativo |
| [Starship](https://starship.rs) | Prompt |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | `cd` inteligente (`z`) |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder (CTRL-R/T, ALT-C) |
| [eza](https://github.com/eza-community/eza) | `ls` moderno |
| [bat](https://github.com/sharkdp/bat) | `cat` com highlight |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | `grep` rápido (`rg`) |
| [fd](https://github.com/sharkdp/fd) | `find` rápido |
| [fisher](https://github.com/jorgebucaran/fisher) + [nvm.fish](https://github.com/jorgebucaran/nvm.fish) | Plugins + Node manager |

## Estrutura do fish

```
fish/
├── config.fish          # entry point
├── fish_plugins         # plugins gerenciados pelo fisher
├── conf.d/              # auto-carregado (ordem alfabética)
│   ├── 00-nvm.fish      # nvm default + auto-switch por .nvmrc
│   ├── aliases.fish     # git, gh
│   ├── paths.fish       # env vars + PATH
│   └── tools.fish       # starship, zoxide, fzf, eza, bat
└── functions/
    └── myip.fish
```

## Targets disponíveis

| Target | Descrição |
|--------|-----------|
| `make` / `make setup` | Setup completo do shell escolhido (`TARGET_SHELL`) |
| `make fish` / `make zsh` | Atalhos para setup com fish ou zsh |
| `make setup-fish` | Setup completo com fish |
| `make setup-zsh` | Setup completo com zsh (oh-my-zsh) |
| `make brew` | Homebrew + pacotes |
| `make shortcuts-fish` | Symlinks fish, ghostty, starship |
| `make shortcuts-zsh` | Symlink do `.zshrc` |
| `make shortcuts-kitty` | Symlinks do kitty (`kitty.conf` + `dracula.conf`) |
| `make shortcuts-git` | Symlinks do git (compartilhado) |
| `make fisher` | fisher + plugins do `fish_plugins` |
| `make node` | Node LTS via nvm.fish |
| `make default-shell` | `chsh` p/ o shell escolhido (`TARGET_SHELL`) |
| `make help` | Lista os targets |
