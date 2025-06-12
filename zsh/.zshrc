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
source $DOTFILES_PATH/zsh/.paths
source $DOTFILES_PATH/zsh/.aliases
source $DOTFILES_PATH/zsh/.functions
source $DOTFILES_PATH/zsh/.zinit
