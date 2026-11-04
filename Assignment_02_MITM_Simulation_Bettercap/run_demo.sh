#!/bin/bash
# Assignment 02: MITM Attack Simulation using Bettercap

if ! command -v bettercap &> /dev/null; then
    sudo apt update && sudo apt install -y bettercap
fi

IFACE=$(ip route | grep '^default' | awk '{print $5}' | head -n 1)
[ -z "$IFACE" ] && IFACE="eth0"

sudo sysctl -w net.ipv4.ip_forward=1
sudo bettercap -iface "$IFACE"
