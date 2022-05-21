!/bin/sh

while true; do
    printf "Checking...\r"
    curl -s https://api.ipify.org
    echo
    sleep 5
done
