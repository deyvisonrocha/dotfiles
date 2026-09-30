# Aliases — só em shell interativo
status is-interactive; or exit

# Git
alias g 'git'
alias gp 'git push'
alias gpr 'git pull --rebase'
alias gc 'git checkout'
alias gs 'git status'
alias glcp "git log --pretty=format:'%h' -n 1 | pbcopy"
alias gbpurge "git branch -vv | grep 'gone]' | awk '{print \$1}' | xargs git branch -D"

# GitHub CLI
alias gh-auth 'env -u GITHUB_TOKEN gh auth'
alias gh-auth-login 'env -u GITHUB_TOKEN gh auth login --scopes repo,admin:org,write:packages'
