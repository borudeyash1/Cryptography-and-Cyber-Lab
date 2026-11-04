#!/bin/bash
# Assignment 05: Complete Working OpenVPN Point-to-Point Tunnel Demo
# Creates a local static-key VPN tunnel, generates the tun0 interface, and verifies it

echo "=========================================================="
echo "   Assignment 05: OpenVPN Point-to-Point Tunnel Setup"
echo "=========================================================="

# Check and install OpenVPN
if ! command -v openvpn &> /dev/null; then
    echo "[*] Installing OpenVPN..."
    sudo apt update && sudo apt install -y openvpn
fi

# Clean up any previous tunnel instances
sudo pkill -f "openvpn.*vpn_test" 2>/dev/null || true
sleep 1

echo ""
echo "[+] Step 1: OpenVPN Version and Crypto Engines:"
openvpn --version | head -n 2

echo ""
echo "[+] Step 2: Generating 2048-bit Static Secret Key (static.key)..."
if [ ! -f "static.key" ]; then
    openvpn --genkey secret static.key
    echo "[+] Created 'static.key' successfully."
else
    echo "[+] 'static.key' already exists."
fi

echo ""
echo "[+] Step 3: Checking Interfaces BEFORE starting VPN:"
ip a | grep -E "^[0-9]+:"

echo ""
echo "[+] Step 4: Spawning OpenVPN Tunnel with AES-256-GCM..."
# This creates a local point-to-point tunnel interface (tun0) with IPs 10.8.0.1 <-> 10.8.0.2
sudo openvpn \
    --dev tun0 \
    --ifconfig 10.8.0.1 10.8.0.2 \
    --secret static.key \
    --cipher AES-256-GCM \
    --verb 1 \
    --daemon vpn_test

sleep 2

echo ""
echo "=========================================================="
echo "[+] Step 5: VERIFYING THE 'tun0' INTERFACE (Demo Output):"
echo "=========================================================="
if ip link show tun0 &> /dev/null; then
    echo "[+] SUCCESS! tun0 interface is ACTIVE and UP:"
    echo "----------------------------------------------------------"
    ip a show tun0
    echo "----------------------------------------------------------"
    echo "[+] Testing ping through the encrypted tunnel (10.8.0.1):"
    ping -c 2 10.8.0.1
else
    echo "[-] Error: tun0 could not be created. Check 'sudo dmesg | tail'."
fi

echo ""
echo "=========================================================="
echo "Note for Viva Demonstration:"
echo " 1. Show the teacher the 'tun0' interface using: ip a show tun0"
echo " 2. Explain: tun0 is a Layer-3 point-to-point virtual adapter"
echo " 3. Show encryption cipher: AES-256-GCM using static 2048-bit key"
echo " 4. To stop the VPN tunnel after demonstration:"
echo "    sudo pkill -f vpn_test"
echo "=========================================================="
