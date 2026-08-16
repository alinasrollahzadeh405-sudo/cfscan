#!/bin/bash

echo "welcome to cfscan! installing pakages..."

apt update && apt upgrade -y && apt install nmap curl prips -y &&curl -s -o ranges.txt "https://raw.githubusercontent.com/alinasrollahzadeh405-sudo/cfscan/main/ranges.txt"

rm -f ipcf.txt

read -p "Please enter port for testing ips (default 443): " port
port=${port:-443}

while read -r ranges; do
    echo "finding ips..."
    ipcf=$(prips "$ranges" | shuf)
    
    for ip in $ipcf; do
        echo "scanning ips..."

        if nmap "$ip" -p "$port" &> /dev/null; then
            echo "ip is alive! testing icmp..."
            if ping -c4 -W 4 "$ip" &> /dev/null; then
                echo "icmp is ok! ip saved!"
                echo "$ip" >> ipcf.txt
            fi
        fi
    done
done < ranges.txt
