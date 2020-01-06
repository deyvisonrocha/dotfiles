# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export PLATFORM=""
export AMIGO_PATH=""

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  PLATFORM="linux"
  AMIGO_PATH="/opt/lampp/htdocs/amigo"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  PLATFORM="macos"
  AMIGO_PATH="/Applications/XAMPP/xamppfiles/htdocs/amigo"
else
  PLATFORM="unknown"
  AMIGO_PATH="unknown"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export DOTFILES_PATH="$HOME/.dotfiles"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    docker
    kubectl
    encode64
    last-working-dir
    npm
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if [[ "$PLATFORM" == "linux" ]]; then
  source $DOTFILES_PATH/linux/.paths
fi

source $DOTFILES_PATH/$PLATFORM/.aliases
source $DOTFILES_PATH/zsh/.spaceship
source $DOTFILES_PATH/zsh/.zplugin

function amigo_build_all() {
    local apiBuildNumber=$1
    local frontBuildNumber=$2

    if [ "$1" = "" ]; then
        print " Error!! "
        print "  - Build number to API is required!"
        return;
    fi

    if [ "$2" = "" ]; then
        print " Error!! "
        print "  - Build number to FRONT is required!"
        return;
    fi

    clear

    print " Preparing build ..."
    print "  - amigohub/dev-api:$apiBuildNumber ..."
    print "  - amigohub/dev-front:$frontBuildNumber ..."

    cd $AMIGO_PATH
    docker build -q -t amigohub/dev-api:$1 ./server
    docker build -q -t amigohub/dev-front:$2 ./client

    clear

    print " Success!"
    print "  - amigohub/dev-api:$apiBuildNumber OK"
    print "  - amigohub/dev-front:$frontBuildNumber OK"
    print ""
}

function amigo_push_all() {
    local apiBuildNumber=$1
    local frontBuildNumber=$2

    if [ "$1" = "" ]; then
        print " Error!! "
        print "  - Build number to API is required!"
        return;
    fi

    if [ "$2" = "" ]; then
        print " Error!! "
        print "  - Build number to FRONT is required!"
        return;
    fi

    print " Pushing ..."
    print "  - amigohub/dev-api:$apiBuildNumber"
    print "  - amigohub/dev-front:$frontBuildNumber"

    cd $AMIGO_PATH
    docker push amigohub/dev-api:$1
    docker push amigohub/dev-front:$2

    print " Success!"
    print ""
}
