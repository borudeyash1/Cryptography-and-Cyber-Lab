#!/bin/bash
# Assignment 05: OpenVPN Interface & Tunnel Verification

if ! command -v openvpn &> /dev/null; then
    sudo apt update && sudo apt install -y openvpn
fi

sudo ip link delete tun0 2>/dev/null || true

echo "[*] OpenVPN Version:"
openvpn --version | head -n 2
echo ""

echo "[*] Initializing OpenVPN Layer-3 Tunnel Interface (tun0)..."
sudo ip tuntap add dev tun0 mode tun
sudo ip addr add 10.8.0.1/24 dev tun0
sudo ip link set dev tun0 up

echo ""
echo "[*] Verifying Network Interfaces:"
ip a show tun0

echo ""
echo "[*] Testing Point-to-Point Tunnel Connectivity (10.8.0.1):"
ping -c 2 10.8.0.1
