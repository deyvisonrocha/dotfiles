# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export DOTFILES_PATH="$HOME/.dotfiles"
export EDITOR='nvim'

source "/opt/homebrew/opt/spaceship/spaceship.zsh"

plugins=(
  git
  z
  brew
  history
  vscode
)

# Sources
source $ZSH/oh-my-zsh.sh
source $DOTFILES_PATH/zsh/config/paths.zsh
source $DOTFILES_PATH/zsh/config/aliases.zsh
source $DOTFILES_PATH/zsh/config/functions.zsh
source $DOTFILES_PATH/zsh/config/zinit

export GITHUB_TOKEN=$(gh auth token 2>/dev/null)
# Created by `pipx` on 2025-06-27 14:26:46
export PATH="$PATH:/Users/deyvisonrocha/.local/bin"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$(brew --prefix python)/libexec/bin:$PATH"
# Added by Antigravity
export PATH="/Users/deyvisonrocha/.antigravity/antigravity/bin:$PATH"

# Added by Antigravity IDE
export PATH="/Users/deyvisonrocha/.antigravity-ide/antigravity-ide/bin:$PATH"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/deyvisonrocha/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions
