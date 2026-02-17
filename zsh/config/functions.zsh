function myip() {
  local publicIp=$(curl -Ss 'http://api64.ipify.org?format=json' | jq --raw-output '.ip')
  local localIp=$(ipconfig getifaddr en0)
  local defaultIp="local"

  if [ "$1" = "local" ]; then
    echo $localIp | pbcopy
  else
    echo $publicIp | pbcopy
    defaultIp="public"
  fi;

  print $fg[green]"Your local IP is:" $fg[white]$localIp
  print $fg[yellow]"Your public IP is:" $fg[white]$publicIp
  print $fg_bold[gray]"Copied $defaultIp IP in your clipboard! :)"
}

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
  local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

  if [ "$nvmrc_node_version" = "N/A" ]; then
    nvm install
  elif [ "$nvmrc_node_version" != "$node_version" ]; then
    nvm use
  fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
  echo "Reverting to nvm default version"
  nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
