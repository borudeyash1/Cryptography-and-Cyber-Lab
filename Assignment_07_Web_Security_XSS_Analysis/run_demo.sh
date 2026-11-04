#!/bin/bash
# Assignment 07: Web Application Security Assessment (XSS Vulnerability Analysis)

TARGET_IP=${1:-"127.0.0.1"}

if [ "$TARGET_IP" == "127.0.0.1" ] || [ "$TARGET_IP" == "localhost" ]; then
    python3 dvwa_xss_server.py
else
    ping -c 2 "$TARGET_IP"
    echo "[*] DVWA Target: http://$TARGET_IP/dvwa/vulnerabilities/xss_r/"
fi
