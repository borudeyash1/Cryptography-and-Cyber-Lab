# Assignment 02: Man-in-the-Middle (MITM) Attack Simulation in Controlled Environment

**Student Details:**
- **Name:** Yash Ambadas Borude
- **Roll No:** 20 | **Class:** B.Tech Computer (A)
- **PRN No:** UCS23M1020
- **Subject:** Cryptography and Cyber Security

---

## 1. Objective & Topology
Simulate a Man-in-the-Middle (MITM) attack in a controlled switched LAN environment using **Bettercap** to demonstrate ARP Cache Poisoning, HSTS bypass concepts, and packet sniffing.

### Lab Network Architecture:
```
[ Windows Host / Target ] <--- (ARP Spoofed) ---> [ Kali Linux (Attacker) ] <--- (ARP Spoofed) ---> [ Gateway / Hotspot ]
      (10.126.134.181)                               (10.126.134.132)                               (10.126.134.214)
```

---

## 2. Core Concepts & Exam Viva Q&A

### Q1: How does ARP Cache Poisoning (ARP Spoofing) work?
- Address Resolution Protocol (ARP) resolves Layer 3 (IP) addresses to Layer 2 (MAC) addresses on local Ethernet/Wi-Fi networks.
- ARP is **stateless and lacks authentication**: any device will accept unsolicited ARP replies (*gratuitous ARP*) and update its local ARP cache table (`arp -a`).
- In this attack:
  - Kali sends spoofed ARP responses to the **Target**: *"I am the Gateway IP, and my MAC is Kali's MAC."*
  - Kali sends spoofed ARP responses to the **Gateway**: *"I am the Target IP, and my MAC is Kali's MAC."*
  - All bidirectional network packets now route through Kali Linux.

### Q2: Why is `set arp.spoof.fullduplex true` important?
- Half-duplex ARP spoofing only intercepts packets from target to gateway (one direction).
- **Full-duplex** poisons both the Target and the Gateway simultaneously, allowing inspection and interception of incoming and outgoing traffic (both request and response).

### Q3: Why is Linux IP forwarding required (`net.ipv4.ip_forward=1`)?
- Without kernel IP forwarding enabled, the attacker machine acts as a black hole (drops packets), creating a Denial of Service (DoS) rather than a stealthy MITM.
- Forwarding lets Kali read/modify packets and pass them along to the actual destination without dropping the victim's internet connection.

### Q4: What is HSTS and why was `hstshijack` used?
- **HSTS (HTTP Strict Transport Security):** A web security header (`Strict-Transport-Security: max-age=...`) instructing browsers to only connect via HTTPS and reject invalid SSL certificates.
- **HSTSHijack:** A caplet that uses SSL stripping and DNS homograph/subdomain spoofing (e.g. replacing `secure.bank.com` with `secure.bank.com.attacker.com` or similar tricks) to downgrade connections or redirect user requests before HSTS enforcement kicks in.

### Q5: What countermeasures prevent ARP Spoofing in enterprise networks?
1. **Dynamic ARP Inspection (DAI):** Switch feature validating ARP packets against DHCP snooping database.
2. **Static ARP Tables:** Hardcoding MAC-to-IP bindings for critical servers and gateways.
3. **End-to-End Encryption:** Using TLS 1.3, VPN (IPsec/WireGuard/OpenVPN), and SSH so intercepted payloads remain encrypted.

---

## 3. Step-by-Step Viva Demonstration Walkthrough

1. **Verify Network Connectivity & IPs:**
   ```bash
   ip -4 addr show eth0
   ip route
   ```
2. **Execute Helper Script:**
   ```bash
   cd Assignment_02_MITM_Simulation_Bettercap
   chmod +x run_demo.sh
   ./run_demo.sh
   ```
3. **Inside Bettercap Interactive CLI:**
   ```text
   net.probe on
   net.recon on
   set arp.spoof.fullduplex true
   net.show
   ```
   *(Show the examiner the list of discovered IP addresses and vendor MAC addresses).*
4. **Trigger ARP Poisoning:**
   ```text
   set arp.spoof.targets <Target_IP>
   arp.spoof on
   ```
5. **Enable Sniffer to Capture Live Traffic:**
   ```text
   set net.sniff.local true
   net.sniff on
   ```
   *(Point out captured DNS queries, mDNS lookups, and cleartext HTTP/service requests from the victim).*
6. **Graceful Exit:**
   ```text
   arp.spoof off
   exit
   ```
   *(Explain that turning `arp.spoof off` restores the victim's original ARP table cleanly without crashing their connection).*

