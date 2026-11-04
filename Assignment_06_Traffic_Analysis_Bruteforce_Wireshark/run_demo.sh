#!/bin/bash
# Assignment 06: Demo Runner for Wireshark Brute-Force Traffic Analysis
# Starts the server in background, launches Wireshark/tshark, and executes attack

echo "=========================================================="
echo "   Assignment 06: End-to-End Traffic Analysis Demo"
echo "=========================================================="

# Check and install python3, wireshark, hydra
for pkg in python3 hydra wireshark tshark; do
    if ! command -v $pkg &> /dev/null; then
        echo "[*] Installing $pkg..."
        sudo apt update && sudo apt install -y $pkg
    fi
done

echo ""
echo "[*] Starting auth_service.py in background on port 8080..."
python3 auth_service.py &
SERVER_PID=$!
sleep 1

echo "[+] Server started (PID: $SERVER_PID)"
echo ""
echo "=========================================================="
echo "INSTRUCTIONS FOR DEMONSTRATION TO EXAMINER:"
echo "1. Start Wireshark on loopback ('lo') or your LAN interface:"
echo "   Filter before attack: tcp.port == 8080"
echo ""
echo "2. Run the Hydra attack script in another terminal:"
echo "   ./attack.sh 127.0.0.1 8080"
echo ""
echo "3. In Wireshark, demonstrate the 3 key detection filters:"
echo "   a) Failed Login Spike (Brute-Force Phase):"
echo "      http.response.code == 401"
echo ""
echo "   b) Successful Compromise:"
echo "      http.response.code == 200 && http.request.uri == \"/\""
echo ""
echo "   c) Extract Credentials Sent in HTTP Packets:"
echo "      http.authorization"
echo "      (Show examiner the Authorization: Basic YWRtaW46U2VjcjN0ITIwMjY= header)"
echo "=========================================================="

read -p "Do you want to run the Hydra attack now? (y/n): " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    ./attack.sh 127.0.0.1 8080
fi

echo ""
read -p "Press Enter to shut down the auth server..."
kill $SERVER_PID
echo "[+] Server stopped."

