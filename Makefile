all: core-macos

core-macos: ## Install brew, git, nvm, zsh, spaceship, zshplugin
	$(MAKE) brew
	$(MAKE) ohmyzsh
	$(MAKE) spaceship
	$(MAKE) zinit
	$(MAKE) shortcuts

ohmyzsh: ## Install oh-my-zsh
	@bash -c "$$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

brew: ## Install brew and packages
	@bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew bundle --file=./brew/Brewfile

shortcuts: ## Create links from files
	mv $$HOME/.zshrc $$HOME/.zshrc.bak
	ln -s $$HOME/.dotfiles/zsh/.zshrc $$HOME/.zshrc
	mv $$HOME/.gitconfig $$HOME/.gitconfig.bak
	mv $$HOME/.gitignore_global $$HOME/.gitignore_global.bak
	ln -s $$HOME/.dotfiles/git/.gitconfig $$HOME/.gitconfig
	ln -s $$HOME/.dotfiles/git/.gitignore_global $$HOME/.gitignore_global

spaceship: ## Install themes spaceship
	git clone https://github.com/denysdovhan/spaceship-prompt.git "$$ZSH_CUSTOM/themes/spaceship-prompt"
	ln -s "$$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$$ZSH_CUSTOM/themes/spaceship.zsh-theme"

zinit: ## Install ZInit to ZSH
	@bash -c "$$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

.PHONY: help
help: ## Command help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
