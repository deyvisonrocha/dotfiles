# Variáveis de ambiente e PATH — roda em todo shell (inclusive não-interativo)

set -gx DOTFILES_PATH $HOME/.dotfiles
set -gx EDITOR nvim

# PATH — prepend na ordem informada (homebrew primeiro). fish_add_path dedup.
fish_add_path -g \
    /opt/homebrew/bin \
    /opt/homebrew/opt/postgresql@17/bin \
    /opt/homebrew/opt/python/libexec/bin \
    $HOME/.local/bin \
    $HOME/.antigravity/antigravity/bin \
    $HOME/.antigravity-ide/antigravity-ide/bin

# Token do GitHub (só em shell interativo — evita spawnar gh em scripts)
if status is-interactive
    set -gx GITHUB_TOKEN (gh auth token 2>/dev/null)
end
