#!/bin/bash
# Assignment 07: Reflected XSS Vulnerability Analysis Demo Runner
# Supports both:
# 1. Standalone local server (failsafe if Metasploitable2 VM is not running)
# 2. Remote Metasploitable2 DVWA target

TARGET_IP=${1:-"10.242.199.18"}

echo "=========================================================="
echo "   Assignment 07: Reflected XSS Vulnerability Analysis"
echo "=========================================================="
echo "Select Demonstration Mode:"
echo " 1) Metasploitable 2 VM (DVWA at http://$TARGET_IP/dvwa/vulnerabilities/xss_r/)"
echo " 2) Standalone Local DVWA XSS Replica Server (offline demo)"
echo "=========================================================="
read -p "Enter choice [1 or 2, default 2]: " mode
mode=${mode:-2}

if [ "$mode" == "1" ]; then
    echo ""
    echo "[*] Mode 1 Selected: Target DVWA on VM ($TARGET_IP)"
    echo "1. Ping check:"
    ping -c 2 "$TARGET_IP" || echo "[-] Target VM ping failed. Make sure VM is running!"
    echo ""
    echo "2. Open Browser in Kali/Host and navigate to:"
    echo "   http://$TARGET_IP/dvwa/login.php"
    echo "   Credentials: admin / password"
    echo "   DVWA Security: Low"
    echo "   Navigate to: 'XSS (Reflected)'"
    echo ""
    echo "3. Steps to Execute in browser input field:"
    echo "   - Test reflection: Enter 'Yash'"
    echo "   - Inspect HTML source: Notice '<pre>Hello Yash</pre>'"
    echo "   - Break HTML tag: </pre>Suraj"
    echo "   - Execute script: </pre><script>prompt(document.cookie)</script>"
else
    echo ""
    echo "[*] Mode 2 Selected: Starting Standalone Local DVWA Replica Server..."
    echo "[+] Launching server on http://localhost:8000"
    echo ""
    echo "Steps for Demo:"
    echo " 1. Open browser at http://localhost:8000"
    echo " 2. In 'What\'s your name?' input:"
    echo "    Step A: Yash (reflected inside <pre>Hello Yash</pre>)"
    echo "    Step B: </pre>Suraj (escapes the pre tag)"
    echo "    Step C: </pre><script>prompt(document.cookie)</script>"
    echo " 3. Observe the JavaScript prompt displaying the session cookie!"
    echo "=========================================================="
    python3 dvwa_xss_server.py
fi

