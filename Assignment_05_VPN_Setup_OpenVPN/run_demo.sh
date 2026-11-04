#!/bin/bash
# Assignment 05: OpenVPN Point-to-Point Tunnel Setup

if ! command -v openvpn &> /dev/null; then
    sudo apt update && sudo apt install -y openvpn
fi

sudo pkill -f "openvpn.*vpn_test" 2>/dev/null || true
sleep 1

openvpn --version | head -n 2
echo ""

if [ ! -f "static.key" ]; then
    openvpn --genkey secret static.key
fi

echo "[*] Starting OpenVPN Tunnel..."
sudo openvpn \
    --dev tun0 \
    --ifconfig 10.8.0.1 10.8.0.2 \
    --secret static.key \
    --cipher AES-256-GCM \
    --verb 1 \
    --daemon vpn_test

sleep 2

echo "[*] Active Tunnel Interface (tun0):"
ip a show tun0
echo ""
echo "[*] Ping Test through Tunnel (10.8.0.1):"
ping -c 2 10.8.0.1
