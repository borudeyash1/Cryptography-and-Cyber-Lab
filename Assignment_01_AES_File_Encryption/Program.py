import os
from cryptography.hazmat.primitives.ciphers.aead import AESGCM
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.primitives import hashes
from cryptography.exceptions import InvalidTag

def derive_key(password: str, salt: bytes) -> bytes:
    """Derives a secure 256-bit AES key from the user's password using PBKDF2."""
    kdf = PBKDF2HMAC(
        algorithm=hashes.SHA256(),
        length=32,
        salt=salt,
        iterations=480000,
    )
    return kdf.derive(password.encode())

def encrypt_file():
    filepath = input("\nEnter the path of the file to encrypt: ").strip()
    if not os.path.exists(filepath):
        print("[-] File not found.")
        return

    password = input("Enter a strong password to encrypt this file: ")
    # 1. Read original file in binary mode
    try:
        with open(filepath, "rb") as f:
            plaintext = f.read()
    except Exception as e:
        print(f"[-] Error reading file: {e}")
        return

    # 2. Generate cryptographic randomness (16-byte salt, 12-byte nonce for AES-GCM)
    salt = os.urandom(16)
    nonce = os.urandom(12)

    # 3. Derive key and encrypt the binary data
    key = derive_key(password, salt)
    aesgcm = AESGCM(key)
    ciphertext = aesgcm.encrypt(nonce, plaintext, None)

    # 4. Save the encrypted file (Salt + Nonce + Ciphertext)
    enc_filepath = filepath + ".enc"
    try:
        with open(enc_filepath, "wb") as f:
            f.write(salt)
            f.write(nonce)
            f.write(ciphertext)
        print(f"\n[+] SUCCESS: File securely encrypted and saved as: {enc_filepath}")
    except Exception as e:
        print(f"[-] Error writing encrypted file: {e}")

def decrypt_file():
    filepath = input("\nEnter the path of the .enc file to decrypt: ").strip()
    if not os.path.exists(filepath):
        print("[-] File not found.")
        return

    password = input("Enter the password to unlock this file: ")

    # 1. Read the encrypted file
    try:
        with open(filepath, "rb") as f:
            file_data = f.read()
    except Exception as e:
        print(f"[-] Error reading file: {e}")
        return

    # A valid file must have at least 16 bytes for salt + 12 for nonce
    if len(file_data) < 28:
        print("[-] File is too small to be a valid encrypted file.")
        return

    # 2. Extract Salt, Nonce, and Ciphertext
    salt = file_data[:16]
    nonce = file_data[16:28]
    ciphertext = file_data[28:]

    # 3. Derive key and attempt decryption
    key = derive_key(password, salt)
    aesgcm = AESGCM(key)
    try:
        plaintext = aesgcm.decrypt(nonce, ciphertext, None)
        # Remove .enc extension for the output file
        if filepath.endswith('.enc'):
            dec_filepath = filepath[:-4]
        else:
            dec_filepath = filepath + ".dec"

        # 4. Save the restored file
        with open(dec_filepath, "wb") as f:
            f.write(plaintext)
        print(f"\n[+] SUCCESS: File successfully decrypted and restored as: {dec_filepath}")
    except InvalidTag:
        print("\n[!] ACCESS DENIED: Incorrect password or file has been tampered with.")

def main():
    while True:
        print("\n" + "="*30)
        print("     AES FILE ENCRYPTOR")
        print("="*30)
        print("1. Encrypt a File")
        print("2. Decrypt a File")
        print("3. Exit")
        choice = input("Select an option (1-3): ").strip()
        if choice == '1':
            encrypt_file()
        elif choice == '2':
            decrypt_file()
        elif choice == '3':
            print("Exiting tool. Goodbye!")
            break
        else:
            print("[-] Invalid option. Try again.")

if __name__ == "__main__":
    main()

