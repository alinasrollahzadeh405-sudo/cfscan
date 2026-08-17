### cfscan

a litewate, fast, and powerfull cloudflare clean ip scanner!

### importent:

for termux, use this command befor installing script, use this command and grant files access:

```bash
termux-setup-storage && pkg update && pkg upgrade -y && pkg install proot-distro -y && proot-distro install ubuntu && proot-distro login ubuntu
```

and grant files access.

### quic start

```bash
curl -s -o cfscan.sh https://raw.githubusercontent.com/alinasrollahzadeh405-sudo/cfscan/main/cfscan.sh && chmod +x cfscan.sh && bash cfscan.sh
```

### how it works?

this script generates random ips from cf official ranges, tests port and icmp founded ips, and saves best ips in a text file.

### notes:

after installation, run this command to start script:
```bash
bash cfscan.sh
```

### created by

ali nasrollahzadeh