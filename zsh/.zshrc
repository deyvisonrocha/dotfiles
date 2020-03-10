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
export EDITOR='vim'

ZSH_THEME="spaceship"

plugins=(
    git
    docker
    kubectl
    encode64
    last-working-dir
    npm
)

# Sources
source $ZSH/oh-my-zsh.sh
source $DOTFILES_PATH/$PLATFORM/.paths
source $DOTFILES_PATH/$PLATFORM/.aliases
source $DOTFILES_PATH/zsh/.spaceship
source $DOTFILES_PATH/zsh/.zplugin

function amigo_build_all() {
    local buildNumber=$1

    if [ "$buildNumber" = "" ]; then
        print " Error!! "
        print "  - Build number is required!"
        return;
    fi

    clear

    print " Preparing build ..."
    print "  - amigohub/dev-api:$buildNumber ..."
    print "  - amigohub/dev-front:$buildNumber ..."

    cd $AMIGO_PATH
    docker build -q -t amigohub/dev-api:$buildNumber ./server
    docker build -q -t amigohub/dev-front:$buildNumber ./client

    clear

    print " Build Success!"
    print "  - amigohub/dev-api:$buildNumber OK"
    print "  - amigohub/dev-front:$buildNumber OK"
    print ""
}

function amigo_push_all() {
    local buildNumber=$1

    if [ "$buildNumber" = "" ]; then
        print " Error!! "
        print "  - Build number is required!"
        return;
    fi

    clear

    print " Pushing ..."
    print "  - amigohub/dev-api:$buildNumber"
    print "  - amigohub/dev-front:$buildNumber"

    cd $AMIGO_PATH
    docker push amigohub/dev-api:$buildNumber
    docker push amigohub/dev-front:$buildNumber

    clear

    print " Push Success!"
    print "  - amigohub/dev-api:$buildNumber OK"
    print "  - amigohub/dev-front:$buildNumber OK"
    print ""
}
