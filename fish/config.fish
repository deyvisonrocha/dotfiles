# ~/.config/fish/config.fish
# Entry point. Env/PATH, aliases, tools e nvm ficam em conf.d/*.fish
# (carregados automaticamente pelo fish, em ordem alfabética, antes deste arquivo).

# Sem banner ao abrir shell
set -g fish_greeting

# Google Cloud SDK (se instalado)
if test -f "$HOME/google-cloud-sdk/path.fish.inc"
    source "$HOME/google-cloud-sdk/path.fish.inc"
end
