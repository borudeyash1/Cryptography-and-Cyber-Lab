# Assignment 07: Perform Web Application Security Assessment: XSS Vulnerability Analysis

**Student Details:**
- **Name:** Borude Yash Ambadas
- **Roll No:** 20 | **Class:** B.Tech Computer (A)
- **PRN No:** UCS23M1020
- **Subject:** Cryptography and Cyber Security

---

## 1. Objective & Lab Context
To analyze and exploit a Reflected Cross-Site Scripting (XSS) vulnerability within a web application environment (DVWA - Damn Vulnerable Web Application / Metasploitable 2) through step-by-step context escaping and JavaScript execution targeting user session cookies.

---

## 2. Core Concepts & Exam Viva Q&A

### Q1: What is Cross-Site Scripting (XSS) and what are its three major types?
- **XSS:** A client-side code injection vulnerability where malicious JavaScript scripts are injected into trusted web applications and executed by victims' browsers.
- **Three Major Types:**
  1. **Reflected (Non-Persistent) XSS:** Malicious payload is part of the request (e.g. GET parameter) and immediately bounced/reflected off the web server in the immediate response. Requires tricking victim into clicking a crafted link.
  2. **Stored (Persistent) XSS:** Payload is permanently stored in a database or server comment/profile field and executed every time any user visits that page.
  3. **DOM-based XSS:** Vulnerability resides purely in client-side JavaScript that improperly handles untrusted data from sources (e.g., `location.hash`) and writes it to sinks (e.g., `document.write()`, `innerHTML`).

### Q2: Why did we use `</pre>` in the payload?
- By inspecting the HTML page source, the server rendered user input inside an HTML preformatted block:
  ```html
  <pre>Hello Yash</pre>
  ```
- Simply injecting `<script>...</script>` while inside `<pre>` may not break the surrounding HTML block or styling in some parser contexts.
- Crafting `</pre><script>prompt(document.cookie)</script>` explicitly **closes the open HTML context** (`</pre>`), allowing the browser DOM parser to switch into JavaScript execution mode.

### Q3: Why is stealing or displaying `document.cookie` critical in cybersecurity?
- Web applications rely on HTTP session tokens (e.g. `PHPSESSID`, `JSESSIONID`) stored in cookies to authenticate stateless requests.
- An attacker executing arbitrary JavaScript can exfiltrate `document.cookie` to their remote listener (Session Hijacking), bypassing credentials, 2FA, and password checks.

### Q4: How do developers prevent Reflected XSS?
1. **Context-Aware Output Encoding (Escaping):** HTML-encode special characters before rendering user input:
   - `<` becomes `&lt;`
   - `>` becomes `&gt;`
   - `"` becomes `&quot;`
   - `'` becomes `&#x27;`
   - `&` becomes `&amp;`
2. **`HttpOnly` Cookie Flag:** Setting `Set-Cookie: PHPSESSID=...; HttpOnly` prevents client-side JavaScript (`document.cookie`) from ever accessing the cookie.
3. **Content Security Policy (CSP):** Header specifying trusted script origins and disallowing inline scripts (`script-src 'self'`).

---

## 3. Step-by-Step Viva Demonstration Walkthrough

1. **Launch Demo (Local or VM):**
   ```bash
   cd Assignment_07_Web_Security_XSS_Analysis
   chmod +x run_demo.sh
   ./run_demo.sh
   ```
2. **Step A: Normal Input Reflection:**
   - Enter `Yash`.
   - Show examiner page displays `Hello Yash`.
   - Right-click -> *View Page Source* -> highlight `<pre>Hello Yash</pre>`.
3. **Step B: Break Out of HTML Context:**
   - Enter `</pre>Suraj`.
   - Show page source: `<pre>Hello </pre>Suraj</pre>`.
   - Explain to examiner that "Suraj" successfully escaped the `<pre>` enclosure.
4. **Step C: Inject Script Payload:**
   - Enter `</pre><script>prompt(document.cookie)</script>`.
   - An alert/prompt dialog immediately pops up displaying the active `PHPSESSID` session cookie.
   - Explain to examiner the session hijacking attack vector.

