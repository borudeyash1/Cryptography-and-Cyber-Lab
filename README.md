# Cryptography and Cyber Security (CCS) Lab Repository

**Student Information:**
- **Name:** Yash Ambadas Borude
- **Roll No:** 20 | **Class:** B.Tech Computer Engineering (A)
- **PRN:** UCS23M1020
- **Course:** Cryptography and Cyber Security Lab (CCS)

---

## Repository Structure & Assignments

```
.
├── setup_environment.sh                          # Master script to install all tools across all assignments
│
├── Assignment_01_AES_File_Encryption/
│   ├── Program.py                                # AES-256 GCM file encryption/decryption source code
│   ├── secret.txt                                # Sample plaintext data file for viva demo
│   ├── run_demo.sh                               # Shell script to test & demonstrate
│   └── VIVA_AND_DEMO_GUIDE.md                    # Theory, cryptographic concepts & viva Q&A
│
├── Assignment_02_MITM_Simulation_Bettercap/
│   ├── mitm_session.cap                          # Bettercap caplet configuration
│   ├── run_demo.sh                               # Helper script with IP checks and Bettercap launch
│   └── VIVA_AND_DEMO_GUIDE.md                    # ARP poisoning theory, HSTS hijack, viva Q&A
│
├── Assignment_03_Recon_Vulnerability_Assessment_Nmap/
│   ├── run_demo.sh                               # Port scan, OS detection, NSE vuln scripts, Nikto & searchsploit
│   └── VIVA_AND_DEMO_GUIDE.md                    # Recon stages, vsftpd backdoor, viva Q&A
│
├── Assignment_04_Password_Cracking_Hydra/
│   ├── wordlist.txt                              # Custom password dictionary
│   ├── run_demo.sh                               # Script executing Hydra against SSH and HTTP Basic Auth
│   └── VIVA_AND_DEMO_GUIDE.md                    # Online vs offline cracking, SSH rate limits, viva Q&A
│
├── Assignment_05_VPN_Setup_OpenVPN/
│   ├── sample_lab.ovpn                           # OpenVPN client profile configuration
│   ├── run_demo.sh                               # Verification of OpenVPN, crypto flags, tun0 interface
│   └── VIVA_AND_DEMO_GUIDE.md                    # VPN security pillars, tun vs tap, routing, viva Q&A
│
├── Assignment_06_Traffic_Analysis_Bruteforce_Wireshark/
│   ├── auth_service.py                           # Python HTTP Basic Auth web server
│   ├── wordlist.txt                              # Target wordlist containing password Secr3t!2026
│   ├── attack.sh                                 # Hydra attack runner
│   ├── run_demo.sh                               # Automated runner launching server and attack
│   └── VIVA_AND_DEMO_GUIDE.md                    # Wireshark detection filters, HTTP 401/200, viva Q&A
│
├── Assignment_07_Web_Security_XSS_Analysis/
│   ├── dvwa_xss_server.py                        # Standalone DVWA Reflected XSS server (offline demo backup)
│   ├── run_demo.sh                               # Interactive launcher for VM DVWA or local replica
│   └── VIVA_AND_DEMO_GUIDE.md                    # XSS types, context escape, cookie theft, viva Q&A
│
└── Assignment_08_Automated_Web_Vulnerability_Scanning_Nikto/
    ├── run_demo.sh                               # Nikto scan runner against Juice Shop or custom target
    ├── scan_results/
    │   └── sample_nikto_findings.txt             # Pre-recorded scan results for instant oral exam reference
    └── VIVA_AND_DEMO_GUIDE.md                    # Nikto methodology, missing headers, backup leaks, viva Q&A
```

---

## Quick Start on Linux (Kali / Ubuntu VirtualBox)

Once you clone this repository inside your VirtualBox:

1. **One-time environment setup:**
   ```bash
   chmod +x setup_environment.sh
   ./setup_environment.sh
   ```

2. **Run any assignment demonstration directly:**
   ```bash
   cd Assignment_01_AES_File_Encryption
   ./run_demo.sh
   ```

3. **Prepare for your viva questions:**
   Open the `VIVA_AND_DEMO_GUIDE.md` located inside each assignment folder.

