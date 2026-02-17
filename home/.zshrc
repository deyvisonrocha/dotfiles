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
