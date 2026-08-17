
#!/bin/bash

echo "welcome to cfscan!"

if command -v nmap &> /dev/null && command -v curl &> /dev/null && command -v prips &> /dev/null; then
    echo "packages are already installed. skipping installation..."
else
    echo "installing required packages..."
    apt update && apt upgrade -y && apt install nmap curl prips -y
fi

curl -s -o ranges.txt "https://raw.githubusercontent.com/alinasrollahzadeh405-sudo/cfscan/main/ranges.txt"

rm -f ipcf.txt

read -p "Please enter port for testing ips (default 443): " port
port=${port:-443}

read -p "How many clean IPs do you want? (default 10): " target_count
target_count=${target_count:-10}
found_count=0

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
                
                found_count=$((found_count + 1))
                echo "Progress: $found_count / $target_count IPs found."

                if [ "$found_count" -ge "$target_count" ]; then
                    echo "Target reached successfully! Exiting..."
                    exit 0
                fi
            fi
        fi
    done
done < ranges.txt
