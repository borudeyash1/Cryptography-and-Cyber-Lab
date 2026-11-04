# Assignment 01: AES-Based File Encryption System

**Student Details:**
- **Name:** Yash Ambadas Borude
- **Roll No:** 20 | **Class:** B.Tech Computer (A)
- **PRN No:** UCS23M1020
- **Subject:** Cryptography and Cyber Security

---

## 1. Objective & Scope
To implement a secure, authenticated file encryption and decryption application in Python using symmetric cryptography (AES-256 in GCM mode) and key derivation (PBKDF2HMAC).

---

## 2. Core Cryptographic Concepts (Exam Viva Q&A)

### Q1: Why AES-GCM instead of AES-CBC or AES-ECB?
- **AES-ECB (Electronic Codebook):** Highly insecure because identical plaintext blocks produce identical ciphertext blocks, preserving patterns (famous ECB Penguin).
- **AES-CBC (Cipher Block Chaining):** Provides confidentiality but lacks built-in integrity/authenticity checks. Susceptible to padding oracle attacks unless paired with HMAC (Encrypt-then-MAC).
- **AES-GCM (Galois/Counter Mode):** An Authenticated Encryption with Associated Data (AEAD) scheme. It provides both **confidentiality** (via Counter mode encryption) and **integrity/authenticity** (via Galois MAC tag) simultaneously in a single pass. If even 1 bit of the ciphertext or header is altered, decryption throws `InvalidTag`.

### Q2: Why is PBKDF2 used instead of hashing the password directly with SHA-256?
- Direct hashing (e.g. `SHA-256(password)`) is vulnerable to dictionary attacks and GPU/ASIC rainbow table brute-forcing because SHA-256 is designed to be fast.
- **PBKDF2 (Password-Based Key Derivation Function 2):** Uses key stretching with a random **Salt** and **480,000 iterations** of HMAC-SHA256, dramatically slowing down attacker brute-force attempts while computing a mathematically uniform 256-bit symmetric key.

### Q3: What is the purpose of the Salt and Nonce?
- **Salt (16 bytes):** Ensures that identical passwords produce completely different encryption keys across different files or users, defeating precomputed rainbow tables.
- **Nonce / IV (12 bytes for GCM):** Number used ONCE. Ensures that encrypting identical plaintexts with the same key produces completely different ciphertexts. In AES-GCM, reusing a (Key, Nonce) pair catastrophically breaks security.

### Q4: How is the encrypted file structured on disk?
The output file (`.enc`) is serialized as:
`[ 16 bytes Salt ] + [ 12 bytes Nonce ] + [ Ciphertext + 16 bytes GCM Auth Tag ]`
During decryption, the script slices the first 16 bytes as salt, next 12 bytes as nonce, and remainder as ciphertext+tag.

---

## 3. Step-by-Step Viva Demonstration Walkthrough

1. **Open Terminal in VM / Kali / Ubuntu:**
   ```bash
   cd Assignment_01_AES_File_Encryption
   chmod +x run_demo.sh
   ./run_demo.sh
   ```
2. **Encrypt `secret.txt`:**
   - Choose `1` (Encrypt).
   - Input file path: `secret.txt`
   - Enter password: `Pass@123`
   - Output produced: `secret.txt.enc`
3. **Show Ciphertext to Examiner:**
   ```bash
   cat secret.txt.enc
   ```
   *(Notice that the data is binary/unreadable and completely protected).*
4. **Simulate File Deletion & Recovery:**
   ```bash
   rm secret.txt
   ```
   - Run `python3 Program.py`, choose `2` (Decrypt).
   - Enter path: `secret.txt.enc`
   - Enter password: `Pass@123`
   - Verify `secret.txt` is recreated with intact content (`cat secret.txt`).
5. **Demonstrate Tamper Detection (Integrity Check):**
   - Run decryption with the **wrong password** (e.g., `WrongPass`).
   - The program catches `InvalidTag` and displays:
     `[!] ACCESS DENIED: Incorrect password or file has been tampered with.`

