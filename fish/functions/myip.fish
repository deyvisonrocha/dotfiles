function myip --description 'Copia o IP local ou público para o clipboard'
    set -l publicIp (curl -Ss 'http://api64.ipify.org?format=json' | jq --raw-output '.ip')
    set -l localIp (ipconfig getifaddr en0)
    set -l defaultIp local

    if test "$argv[1]" = local
        echo $localIp | pbcopy
    else
        echo $publicIp | pbcopy
        set defaultIp public
    end

    set_color green; echo -n "Your local IP is: "; set_color normal; echo $localIp
    set_color yellow; echo -n "Your public IP is: "; set_color normal; echo $publicIp
    set_color -o brblack; echo "Copied $defaultIp IP to your clipboard! :)"; set_color normal
end
