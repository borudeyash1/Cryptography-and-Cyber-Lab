#!/bin/bash
# Master Lab Setup Script for Cryptography & Cyber Security (CCS)
# Student: Yash Ambadas Borude (Roll No: 20 | PRN: UCS23M1020)

echo "=========================================================="
echo "    CCS Lab Environment Initialization & Dependency Setup"
echo "=========================================================="

echo "[*] Updating apt package lists..."
sudo apt update

echo "[*] Installing required packages and tools across all assignments..."
sudo apt install -y \
    python3 \
    python3-pip \
    python3-cryptography \
    bettercap \
    nmap \
    nikto \
    exploitdb \
    hydra \
    openvpn \
    wireshark \
    tshark \
    curl \
    net-tools

echo ""
echo "[*] Setting executable permissions on all lab demo scripts..."
chmod +x Assignment_*/*.sh 2>/dev/null || true

echo ""
echo "=========================================================="
echo "[+] All lab dependencies and tools are ready!"
echo "=========================================================="
echo "You can navigate to any assignment folder and execute:"
echo "   ./run_demo.sh"
echo "Refer to each folder's VIVA_AND_DEMO_GUIDE.md for exam preparation."
echo "=========================================================="

