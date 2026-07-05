# nvm (plugin jorgebucaran/nvm.fish — instalado via fisher, ver fish_plugins).
# Prefixo "00-" garante que este arquivo carregue ANTES do conf.d/nvm.fish do
# plugin (ordem alfabética), então nvm_default_version já existe quando o plugin
# aplica a versão padrão na abertura do shell.

set -g nvm_default_version lts

# Auto-switch por diretório: replica o load-nvmrc do zsh.
# Ao entrar num dir com .nvmrc/.node-version, `nvm use` (sem arg) aplica a versão.
function _nvm_auto_use --on-variable PWD --description 'nvm use automático via .nvmrc'
    status is-interactive; or return
    type -q nvm; or return
    test -f .nvmrc -o -f .node-version; and nvm use 2>/dev/null
end
