# Assignment 04: Real-World Cyber Attacks & Security Weaknesses: Password Attack Simulation using Hydra

**Student Details:**
- **Name:** Yash Ambadas Borude
- **Roll No:** 20 | **Class:** B.Tech Computer (A)
- **PRN No:** UCS23M1020
- **Subject:** Cryptography and Cyber Security

---

## 1. Objective & Target Overview
To demonstrate how automated online password brute-force and dictionary attacks work against network services (SSH protocol on port 22 and HTTP Basic Authentication) using **THC-Hydra**.

### Targets:
1. **Target 1 (SSH - Matrix-1 VM):** IP `10.126.134.108:22` (Found user: `guest`, cracked password: `k1ll0r7n`).
2. **Target 2 (HTTP GET /protected):** IP `10.49.183.74:80` (Target user: `bob`, cracked password: `bubbles` via wordlist).

---

## 2. Core Concepts & Exam Viva Q&A

### Q1: What is the difference between an online and offline password attack?
- **Online Password Attack (e.g. Hydra, Medusa):** The attacker interacts directly with an active network service (SSH, HTTP, FTP, RDP) by sending sequential auth requests.
  - *Limitation:* Network latency, bandwidth bottlenecks, and active rate limiting / account lockouts.
- **Offline Password Attack (e.g. Hashcat, John the Ripper):** The attacker has obtained the database hash dump (`/etc/shadow`, NTLM hashes, database MD5/SHA256) and computes candidate hashes locally.
  - *Speed:* Millions or billions of guesses per second on GPUs without alerting the target server.

### Q2: What do Hydra command options `-L`, `-P`, `-l`, `-p`, and `-t` mean?
- `-l <username>`: Single specific target username (e.g. `bob`).
- `-L <file>`: Wordlist of usernames to try.
- `-p <password>`: Single password guess.
- `-P <file>`: Wordlist of candidate passwords.
- `-t <num>`: Number of parallel tasks/threads (default 16; `-t 4` is recommended for SSH to avoid dropped connections).
- `ssh://<ip>:<port>` or `<ip> http-get <path>`: Specifies protocol and endpoint format.

### Q3: Why is SSH brute-forcing prone to connection resets or bans?
- OpenSSH daemons feature `MaxStartups` which restricts unauthenticated concurrent connections.
- Exceeding connection thresholds causes dropped packets or connection refused warnings (`[WARNING] Many SSH configurations limit parallel tasks`).

### Q4: How did you verify the cracked credentials in Part 1?
- Executed an active SSH login:
  ```bash
  ssh guest@10.126.134.108
  ```
- Provided password `k1ll0r7n`.
- Successfully obtained shell prompt (`guest@portaos:~$ whoami`).

### Q5: What security countermeasures mitigate automated brute-force attacks?
1. **Fail2ban / IP Rate Limiting:** Automatically blocks IP addresses that trigger repeated authentication failures (e.g., 5 failed attempts = 15-minute ban in `iptables`).
2. **Multi-Factor Authentication (MFA / 2FA):** Even with a cracked password, attacker cannot provide the TOTP/SMS/FIDO2 second factor.
3. **Key-based Authentication:** Disabling password authentication entirely in `/etc/ssh/sshd_config` (`PasswordAuthentication no`) in favor of Ed25519/RSA public keys.
4. **Account Lockout Thresholds:** Temporarily locking accounts after repeated invalid password attempts.

---

## 3. Step-by-Step Viva Demonstration Walkthrough

1. **Review Wordlist:**
   ```bash
   cd Assignment_04_Password_Cracking_Hydra
   head -n 20 wordlist.txt
   ```
2. **Run Part 1 (SSH Cracking):**
   ```bash
   nmap -sV -p 22 <TARGET_SSH_IP>
   hydra -L wordlist.txt -P wordlist.txt -t 4 ssh://<TARGET_SSH_IP>:22
   ```
   *(Point to Hydra terminal output: `[22][ssh] host: ... login: guest password: k1ll0r7n`)*.
3. **Demonstrate SSH Login:**
   ```bash
   ssh guest@<TARGET_SSH_IP>
   ```
4. **Run Part 2 (HTTP Basic Auth Cracking):**
   ```bash
   hydra -l bob -P wordlist.txt <TARGET_HTTP_IP> http-get /protected
   ```
   *(Point to output finding `login: bob password: bubbles`).*

