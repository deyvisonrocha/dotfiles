# Integração das ferramentas modernas — só em shell interativo
status is-interactive; or exit

# --- Starship (prompt) ---
set -gx STARSHIP_CONFIG $HOME/.dotfiles/starship/starship.toml
starship init fish | source

# --- zoxide (cd inteligente -> comando `z`) ---
zoxide init fish | source

# --- fzf (key bindings + completion nativos, fzf >= 0.48) ---
fzf --fish | source
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git'
set -gx FZF_CTRL_T_OPTS "--preview 'bat --color=always --style=numbers --line-range=:200 {}'"
set -gx FZF_ALT_C_OPTS "--preview 'eza --tree --level=1 --icons --color=always {}'"

# --- bat (cat com syntax highlight; também vira pager do man) ---
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

# --- eza (substitui ls) ---
alias ls 'eza --group-directories-first --icons'
alias ll 'eza -l --group-directories-first --icons --git'
alias la 'eza -la --group-directories-first --icons --git'
alias lt 'eza --tree --level=2 --group-directories-first --icons'
