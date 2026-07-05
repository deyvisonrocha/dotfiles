alias g="git"
alias gp="git push"
alias gpr="git pull --rebase"
alias gc="git checkout"
alias gs="git status"
alias glcp="git log --pretty=format:'%h' -n 1 | pbcopy"
alias gbpurge="git branch --merged | grep -v "\*" | grep -v "master" | grep -v "develop" | xargs -n 1 git branch -d"

# Github CLI
alias gh-auth="env -u GITHUB_TOKEN gh auth"
alias gh-auth-login="env -u GITHUB_TOKEN gh auth login --scopes "repo,admin:org,write:packages""
