OS := $(shell bin/is-supported bin/is-macos macos linux)

all: $(OS)

macos: sudo core-macos

linux: upgrade-linux shortcuts-linux spaceship zshplugin ## Install all pre-requisites

sudo:
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | ruby

bash: BASH=/usr/local/bin/bash
bash: SHELLS=/private/etc/shells
bash: brew
	if ! grep -q $(BASH) $(SHELLS); then brew install bash bash-completion@2 pcre && sudo append $(BASH) $(SHELLS) && chsh -s $(BASH); fi

git: brew
	brew install git git-extras

npm:
	if ! [ -d $(NVM_DIR)/.git ]; then git clone https://github.com/creationix/nvm.git $(NVM_DIR); fi
	. $(NVM_DIR)/nvm.sh; nvm install --lts

upgrade-linux: ## Upgrade system OS
	sudo apt update
	sudo apt upgrade -y
	sudo apt install curl git zsh wget vim fonts-powerline
	#sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	sudo apt autoremove -y && sudo apt autoclean -y

shortcuts-linux: ## Create links from files
	rm $HOME/.zshrc
	ln -s $HOME/.dotfiles/zsh/.zshrc $HOME/.zshrc
	rm $HOME/.xprofile
	ln -s $HOME/.dotfiles/linux/.xprofile $HOME/.xprofile
	rm $HOME/.gitconfig
	ln -s $HOME/.dotfiles/git/.gitconfig $HOME/.gitconfig

spaceship: ## Install themes spaceship
	git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
	ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

zshplugin: ## Install ZPlugin to ZSH
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
