#!/usr/bin/env python3
"""
Assignment 07: DVWA-Identical Reflected XSS Lab Server
Enables standalone offline demonstration without requiring Metasploitable2 VM.
"""
from http.server import HTTPServer, BaseHTTPRequestHandler
import urllib.parse

HTML_TEMPLATE = """<!DOCTYPE html>
<html>
<head>
    <title>Vulnerability: Reflected Cross Site Scripting (XSS)</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background-color: #f4f6f8; }
        .box { background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); max-width: 650px; margin: auto; }
        h1 { color: #d9534f; }
        input[type=text] { width: 75%; padding: 8px; font-size: 14px; }
        input[type=submit] { padding: 8px 15px; font-size: 14px; background: #337ab7; color: white; border: none; cursor: pointer; }
        pre { background: #eee; padding: 10px; border-left: 4px solid #337ab7; }
        .cookie-box { background: #e8f4fd; padding: 10px; border: 1px dashed #337ab7; margin-bottom: 15px; font-size: 13px; }
    </style>
</head>
<body>
    <div class="box">
        <h1>Reflected XSS Demonstration (DVWA Replica)</h1>
        <div class="cookie-box">
            <strong>Active Session Cookie:</strong> PHPSESSID=lab_session_token_ucs23m1020_yash_20
        </div>
        <p>What's your name?</p>
        <form method="GET" action="/">
            <input type="text" name="name" placeholder="Enter your name" value="" />
            <input type="submit" value="Submit" />
        </form>
        <br>
        <div>
            <!-- VULNERABLE REFLECTION POINT EXACTLY LIKE DVWA LOW -->
            {output}
        </div>
    </div>
</body>
</html>
"""

class XSSHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        parsed = urllib.parse.urlparse(self.path)
        params = urllib.parse.parse_qs(parsed.query)
        name_val = params.get('name', [None])[0]

        # Set a simulated session cookie so document.cookie has data to pop up!
        self.send_response(200)
        self.send_header('Content-Type', 'text/html; charset=utf-8')
        self.send_header('Set-Cookie', 'PHPSESSID=lab_session_token_ucs23m1020_yash_20; Path=/')
        self.end_headers()

        if name_val is not None:
            # Replicating DVWA low: $name reflected inside <pre> tag with NO sanitization
            rendered_output = f"<pre>Hello {name_val}</pre>"
        else:
            rendered_output = ""

        html = HTML_TEMPLATE.format(output=rendered_output)
        self.wfile.write(html.encode('utf-8'))

    def log_message(self, format, *args):
        print(f"[XSS Lab] {self.client_address[0]} - {format % args}")

def run(port=8000):
    server = HTTPServer(('0.0.0.0', port), XSSHandler)
    print("=" * 65)
    print(f"[+] DVWA XSS Simulation Server running on http://localhost:{port}/")
    print(f"[+] Test Payload 1 (Context Escape) : </pre>Suraj")
    print(f"[+] Test Payload 2 (Cookie Prompt)  : </pre><script>prompt(document.cookie)</script>")
    print("=" * 65)
    server.serve_forever()

if __name__ == '__main__':
    run()

