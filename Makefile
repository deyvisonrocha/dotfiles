.PHONY: all
all: enpass upgrade-os shortcuts spaceship zinit ## Install all pre-requisites

.PHONY: upgrade-os
upgrade-os: ## Upgrade system OS
	sudo apt update
	sudo apt upgrade -y
	sudo apt install curl git zsh wget vim fonts-powerline enpass -y
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	sudo apt autoremove -y && sudo apt autoclean -y

.PHONY: shortcuts
shortcuts: ## Create links from files
	rm -f $$HOME/.zshrc
	ln -s $$HOME/.dotfiles/.zshrc $$HOME/.zshrc
	rm -f $$HOME/.xprofilee
	ln -s $$HOME/.dotfiles/.xprofile $$HOME/.xprofile
	rm -f $$HOME/.gitconfig
	ln -s $$HOME/.dotfiles/.gitconfig $$HOME/.gitconfig

.PHONY: spaceship
spaceship: ## Install themes spaceship
	$(shell git clone https://github.com/denysdovhan/spaceship-prompt.git $$ZSH_CUSTOM/themes/spaceship-prompt)
	$(shell ln -sf "$$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$$ZSH_CUSTOM/themes/spaceship.zsh-theme")

.PHONY: zinit
zinit: ## Install Zinit to ZSH
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

.PHONY: enpass
enpass: ## Install Zinit to ZSH
	sudo echo "deb https://apt.enpass.io/ stable main" > /etc/apt/sources.list.d/enpass.list
	wget -qO - https://apt.enpass.io/keys/enpass-linux.key | sudo apt-key add -

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
