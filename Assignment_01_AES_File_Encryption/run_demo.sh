#!/bin/bash
# Assignment 01: AES-based file encryption system

if ! python3 -c "import cryptography" &> /dev/null; then
    sudo apt update && sudo apt install -y python3-cryptography || pip3 install cryptography
fi

if [ ! -f "secret.txt" ]; then
    echo "This is confidential lab demo data for AES encryption." > secret.txt
fi

python3 Program.py
