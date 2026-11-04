#!/bin/bash
# Assignment 01: AES-based file encryption system
# Run this script to setup dependencies and test the program

echo "============================================="
echo "[+] Step 1: Checking and Installing Dependencies"
echo "============================================="

if ! python3 -c "import cryptography" &> /dev/null; then
    echo "[*] Installing python3-cryptography..."
    sudo apt update && sudo apt install -y python3-cryptography || pip3 install cryptography
else
    echo "[+] python3-cryptography is already installed."
fi

echo ""
echo "============================================="
echo "[+] Step 2: Preparing Sample File for Demo"
echo "============================================="
echo "This is confidential lab demo data for AES encryption." > secret.txt
echo "[+] Created 'secret.txt' with sample content:"
cat secret.txt
echo ""

echo "============================================="
echo "[+] Step 3: Launching Program.py"
echo "============================================="
echo "Instructions for Demo:"
echo " 1) Select Option 1 (Encrypt)"
echo "    - File path: secret.txt"
echo "    - Password: e.g. Pass@123"
echo " 2) Inspect generated file: ls -l secret.txt.enc"
echo " 3) Try viewing encrypted content: cat secret.txt.enc"
echo " 4) Remove or rename secret.txt (rm secret.txt)"
echo " 5) Select Option 2 (Decrypt)"
echo "    - File path: secret.txt.enc"
echo "    - Password: Pass@123"
echo " 6) Verify recovered content: cat secret.txt"
echo "============================================="
python3 Program.py

