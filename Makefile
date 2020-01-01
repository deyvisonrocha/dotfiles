.PHONY: all
all: upgrade-os shortcuts spaceship zshplugin ## Install all pre-requisites

.PHONY: upgrade-os
upgrade-os: ## Upgrade system OS
	sudo apt update
	sudo apt upgrade -y
	sudo apt install curl git zsh wget vim fonts-powerline
	#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	sudo apt autoremove -y && sudo apt autoclean -y

.PHONY: shortcuts
shortcuts: ## Create links from files
	rm $HOME/.zshrc
	ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc
	rm $HOME/.xprofile
	ln -s $HOME/.dotfiles/.xprofile $HOME/.xprofile
	rm $HOME/.gitconfig
	ln -s $HOME/.dotfiles/.gitconfig $HOME/.gitconfig

.PHONY: spaceship
spaceship: ## Install themes spaceship
	git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
	ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

.PHONY: zshplugin
zshplugin: ## Install ZPlugin to ZSH
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
