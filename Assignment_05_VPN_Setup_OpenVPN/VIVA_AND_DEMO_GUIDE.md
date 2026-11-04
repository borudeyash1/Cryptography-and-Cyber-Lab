# Assignment 05: Design and Implement Enterprise Network Security Controls: VPN Setup for Secure Remote Connection

**Student Details:**
- **Name:** Borude Yash Ambadas
- **Roll No:** 20 | **Class:** B.Tech Computer (A)
- **PRN No:** UCS23M1020
- **Subject:** Cryptography and Cyber Security

---

## 1. Objective & Enterprise Scope
To design, install, configure, and verify an encrypted Virtual Private Network (VPN) tunnel utilizing **OpenVPN** to securely link a remote client to a protected enterprise private intranet over untrusted public networks.

---

## 2. Core Concepts & Exam Viva Q&A

### Q1: What is a VPN and what core security pillars does it guarantee?
- A VPN (Virtual Private Network) encapsulates and encrypts traffic between two endpoints across an insecure network (like the Internet).
- Guarantees:
  1. **Confidentiality:** Encryption (AES-256-GCM / AES-256-CBC) renders eavesdropped packets unreadable.
  2. **Integrity:** HMAC-SHA256 or AEAD ensures packets cannot be altered or injected in flight.
  3. **Authentication:** Uses TLS public key infrastructure (PKI certificates: CA, client cert, private key) to strictly authenticate communicating parties.

### Q2: What is the difference between `tun` and `tap` interfaces in OpenVPN?
- **`tun` (Virtual Point-to-Point Network / Layer 3):**
  - Handles IP packets directly.
  - More efficient, smaller overhead, ideal for routed internet & remote-work VPN connections.
  - This is what created `tun0` in our assignment.
- **`tap` (Virtual Ethernet / Layer 2):**
  - Handles raw Ethernet frames (carries ARP, broadcasts, non-IP protocols).
  - Used for network bridging.

### Q3: How do you verify that the OpenVPN tunnel is functioning?
1. **Network Interface Check:**
   ```bash
   ip a
   ```
   A new virtual network interface `tun0` appears with flags `POINTOPOINT, MULTICAST, NOARP, UP`.
2. **Routing Table Check:**
   ```bash
   ip route
   ```
   The default gateway or target corporate subnet route redirects traffic via `dev tun0`.
3. **Public IP Verification:**
   ```bash
   curl ifconfig.me
   ```
   Reflects the external IP of the VPN gateway rather than local ISP IP.

### Q4: What protocols and transport modes does OpenVPN support?
- Defaults to **UDP port 1194** for optimal speed (avoids TCP-over-TCP meltdown where both layers trigger retransmissions).
- Can fall back to **TCP port 443** to masquerade as standard HTTPS traffic and bypass restrictive enterprise firewalls.

---

## 3. Step-by-Step Viva Demonstration Walkthrough

1. **Check OpenVPN Installation & Supported Ciphers:**
   ```bash
   openvpn --version
   ```
   *(Show OpenSSL engine, SSL/TLS, and AEAD support).*
2. **Inspect Network Interfaces (Pre-Tunnel):**
   ```bash
   ip a
   ```
   *(Notice only `lo` and `eth0` exist).*
3. **Initiate VPN Connection:**
   ```bash
   sudo openvpn --config sample_lab.ovpn
   ```
   *(Or your lab assigned VPN file).*
4. **Verify Post-Connection Interface:**
   ```bash
   ip a show tun0
   ```
   *(Point out the assigned tunnel IP and `POINTOPOINT` flag to the examiner).*

