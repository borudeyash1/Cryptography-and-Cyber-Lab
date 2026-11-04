# Assignment 06: Threat Detection & Incident Response: Detect HTTP Bruteforce Login Attempt Through Traffic Analysis

**Student Details:**
- **Name:** Borude Yash Ambadas
- **Roll No:** 20 | **Class:** B.Tech Computer (A)
- **PRN No:** UCS23M1020
- **Subject:** Cryptography and Cyber Security

---

## 1. Objective & Scenario
To simulate an active HTTP Basic Authentication dictionary brute-force attack from an attacker machine (Kali Linux with Hydra) against a web server (`auth_service.py`) and analyze the resulting pcap network packets in **Wireshark** to establish indicators of compromise (IoC) and intrusion detection filters.

---

## 2. Core Concepts & Exam Viva Q&A

### Q1: How does HTTP Basic Authentication transmit credentials across the wire?
- When challenged with HTTP `401 Unauthorized` and `WWW-Authenticate: Basic realm="..."`, the client transmits:
  `Authorization: Basic <base64-encoded string>`
- The string format is `username:password` encoded in Base64 (e.g., `admin:Secr3t!2026` becomes `YWRtaW46U2VjcjN0ITIwMjY=`).
- **Critical Security Flaw:** Base64 is an **encoding scheme, NOT encryption**. Anyone sniffing the network traffic can decode the cleartext password in milliseconds. To be secure, it must be encapsulated in HTTPS (TLS).

### Q2: How do you identify a brute-force attack in Wireshark?
1. **High Packet Frequency:** Rapid burst of TCP SYN/ACK followed by HTTP GET requests within seconds.
2. **Spike in HTTP 401s:** An abnormal volume of `401 Unauthorized` responses from the target server:
   - Wireshark Display Filter: `http.response.code == 401`
3. **Repeated Requests from Single Source IP:** One source IP attempting dozens or hundreds of requests against an authentication endpoint.

### Q3: How do you detect the exact point of breach (compromise)?
- After dozens of `401 Unauthorized` responses, a sudden `200 OK` indicates a valid combination was successfully supplied.
- Wireshark Display Filter:
  ```wireshark
  http.response.code == 200 && http.request.uri == "/"
  ```
- Right-click the corresponding HTTP GET request packet -> **Follow -> HTTP Stream** to see the exact winning `Authorization: Basic ...` header.

### Q4: What filter extracts all attempted credentials from the packet capture?
- Wireshark Display Filter:
  ```wireshark
  http.authorization
  ```
- Adding `http.authorization` as a column in Wireshark lets a security analyst see every password attempted by the attacker in sequential order.

### Q5: How would an enterprise SOC / SIEM detect and prevent this?
- **SIEM Correlation Rule:** Threshold alert: *>10 HTTP 401 responses within 60 seconds from the same source IP = High Severity Brute-Force Alert*.
- **WAF / Reverse Proxy Rate Limiting:** Enforcing Nginx/HAProxy `limit_req_zone` or Cloudflare Bot Management.
- **Fail2ban Integration:** Inspecting web server logs and automatically adding offending attacker IPs to `iptables` drop chains.

---

## 3. Step-by-Step Viva Demonstration Walkthrough

1. **Start the Lab Setup:**
   ```bash
   cd Assignment_06_Traffic_Analysis_Bruteforce_Wireshark
   chmod +x *.sh
   ./run_demo.sh
   ```
2. **Open Wireshark:**
   - Listen on `lo` (if running locally) or your LAN/host-only adapter (`eth0`).
   - Filter bar: `tcp.port == 8080`.
3. **Execute Hydra:**
   - In terminal, confirm attack against `127.0.0.1:8080` (or host IP).
   - Hydra finds: `login: admin password: Secr3t!2026`.
4. **Demonstrate 3 Key Wireshark Filters to Examiner:**
   - **Filter 1:** `http.response.code == 401`
     *(Show the burst of red/black 401 Unauthorized frames during brute-force)*.
   - **Filter 2:** `http.response.code == 200`
     *(Show the single 200 OK frame indicating success)*.
   - **Filter 3:** `http.authorization`
     *(Expand Hypertext Transfer Protocol tree -> show `Credentials: admin:Secr3t!2026` decoded directly by Wireshark)*.

