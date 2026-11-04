#!/bin/bash
# Assignment 05: Enterprise Network Security Controls: VPN Setup (OpenVPN)

echo "=========================================================="
echo "   Assignment 05: OpenVPN Remote Secure Tunnel Setup"
echo "=========================================================="

# Check and install OpenVPN
if ! command -v openvpn &> /dev/null; then
    echo "[*] Installing OpenVPN..."
    sudo apt update && sudo apt install -y openvpn
else
    echo "[+] OpenVPN is installed."
fi

echo ""
echo "[+] Step 1: Checking OpenVPN Version and Crypto Capabilities:"
openvpn --version | head -n 3

echo ""
echo "[+] Step 2: Displaying Network Interfaces Prior to Tunnel:"
ip a

echo ""
echo "=========================================================="
echo "Demonstration Steps to Explain to Examiner:"
echo " 1. OpenVPN establishes an encrypted virtual tunnel over Layer 3 (tun)."
echo " 2. To connect using an active client config file (.ovpn):"
echo "    sudo openvpn --config sample_lab.ovpn"
echo "    (Or use your assigned lab/enterprise .ovpn profile)"
echo " 3. Verify that the 'tun0' point-to-point interface is created:"
echo "    ip a show tun0"
echo " 4. Check routing table updates sending traffic via VPN gateway:"
echo "    ip route"
echo "=========================================================="

if ip link show tun0 &> /dev/null; then
    echo "[+] 'tun0' VPN interface is currently ACTIVE:"
    ip a show tun0
else
    echo "[-] Note: 'tun0' is not active yet (requires active remote server connection)."
fi

