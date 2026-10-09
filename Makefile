# Shell alvo do setup: fish (padrão) ou zsh.  Ex.: make TARGET_SHELL=zsh
TARGET_SHELL ?= fish
FISH := /opt/homebrew/bin/fish
DOTFILES := $(HOME)/.dotfiles

ifeq ($(TARGET_SHELL),fish)
LOGIN_SHELL := $(FISH)
else ifeq ($(TARGET_SHELL),zsh)
LOGIN_SHELL := /bin/zsh
endif

all: setup

setup: ## Setup completo do shell escolhido (TARGET_SHELL=fish|zsh)
ifeq ($(TARGET_SHELL),fish)
	$(MAKE) setup-fish
else ifeq ($(TARGET_SHELL),zsh)
	$(MAKE) setup-zsh
else
	@echo "TARGET_SHELL inválido: '$(TARGET_SHELL)'. Use fish ou zsh."; exit 1
endif

fish: ## Atalho: setup completo com fish
	$(MAKE) setup TARGET_SHELL=fish

zsh: ## Atalho: setup completo com zsh
	$(MAKE) setup TARGET_SHELL=zsh

# ---------------------- FISH ----------------------
setup-fish: ## Setup com fish (brew, symlinks, fisher, node, chsh)
	$(MAKE) brew
	$(MAKE) shortcuts-git
	$(MAKE) shortcuts-fish
	$(MAKE) shortcuts-kitty
	$(MAKE) fisher
	$(MAKE) node
	$(MAKE) default-shell TARGET_SHELL=fish

shortcuts-fish: ## Symlinks do fish, ghostty e starship
	mkdir -p $(HOME)/.config/fish/conf.d $(HOME)/.config/fish/functions $(HOME)/.config/ghostty
	@test -f $(DOTFILES)/fish/conf.d/private.fish || printf '# Aliases/env privados — NAO versionado (gitignored).\nstatus is-interactive; or exit\n' > $(DOTFILES)/fish/conf.d/private.fish
	@if [ -f $(HOME)/.config/fish/config.fish ] && [ ! -L $(HOME)/.config/fish/config.fish ]; then mv $(HOME)/.config/fish/config.fish $(HOME)/.config/fish/config.fish.pre-dotfiles; fi
	ln -sf $(DOTFILES)/fish/config.fish   $(HOME)/.config/fish/config.fish
	ln -sf $(DOTFILES)/fish/fish_plugins  $(HOME)/.config/fish/fish_plugins
	for f in $(DOTFILES)/fish/conf.d/*.fish; do ln -sf "$$f" $(HOME)/.config/fish/conf.d/; done
	for f in $(DOTFILES)/fish/functions/*.fish; do ln -sf "$$f" $(HOME)/.config/fish/functions/; done
	ln -sf $(DOTFILES)/ghostty/config $(HOME)/.config/ghostty/config
	ln -sf $(DOTFILES)/starship/starship.toml $(HOME)/.config/starship.toml

fisher: ## Instala fisher + plugins (fish_plugins)
	$(FISH) -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher && fisher update"

node: ## Instala Node LTS via nvm.fish
	$(FISH) -c "nvm install lts"

# ---------------------- ZSH ----------------------
setup-zsh: ## Setup com zsh (brew, oh-my-zsh, symlinks, chsh)
	$(MAKE) brew
	$(MAKE) ohmyzsh
	$(MAKE) shortcuts-git
	$(MAKE) shortcuts-zsh
	$(MAKE) shortcuts-kitty
	$(MAKE) default-shell TARGET_SHELL=zsh

ohmyzsh: ## Instala oh-my-zsh (zinit e spaceship carregam via .zshrc/brew)
	@test -d $(HOME)/.oh-my-zsh || bash -c "$$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended

shortcuts-zsh: ## Symlink do .zshrc
	@if [ -f $(HOME)/.zshrc ] && [ ! -L $(HOME)/.zshrc ]; then mv $(HOME)/.zshrc $(HOME)/.zshrc.pre-dotfiles; fi
	ln -sf $(DOTFILES)/home/.zshrc $(HOME)/.zshrc

# ---------------------- COMPARTILHADO ----------------------
brew: ## Instala Homebrew + pacotes do Brewfile
	@command -v brew >/dev/null || bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew bundle --file=./brew/Brewfile

shortcuts-git: ## Symlinks do git
	ln -sf $(DOTFILES)/home/.gitconfig $(HOME)/.gitconfig
	ln -sf $(DOTFILES)/home/.gitignore_global $(HOME)/.gitignore_global

shortcuts-kitty: ## Symlinks do kitty (kitty.conf + tema)
	mkdir -p $(HOME)/.config/kitty
	@if [ -f $(HOME)/.config/kitty/kitty.conf ] && [ ! -L $(HOME)/.config/kitty/kitty.conf ]; then mv $(HOME)/.config/kitty/kitty.conf $(HOME)/.config/kitty/kitty.conf.pre-dotfiles; fi
	for f in $(DOTFILES)/kitty/*.conf; do ln -sf "$$f" $(HOME)/.config/kitty/; done

default-shell: ## Define o shell de login (TARGET_SHELL=fish|zsh)
	@grep -qx $(LOGIN_SHELL) /etc/shells || echo $(LOGIN_SHELL) | sudo tee -a /etc/shells
	chsh -s $(LOGIN_SHELL)

.PHONY: all setup fish zsh setup-fish setup-zsh shortcuts-fish shortcuts-zsh shortcuts-kitty shortcuts-git fisher node ohmyzsh brew default-shell help
help: ## Command help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
