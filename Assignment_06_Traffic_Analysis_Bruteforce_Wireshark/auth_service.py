import base64
from http.server import HTTPServer, BaseHTTPRequestHandler

class AuthHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        hdr = self.headers.get('Authorization', '')
        if hdr.startswith('Basic '):
            try:
                decoded = base64.b64decode(hdr[6:]).decode()
                # Target credential verified by brute-force attack
                if decoded == "admin:Secr3t!2026":
                    self.send_response(200)
                    self.send_header('Content-type', 'text/html')
                    self.end_headers()
                    self.wfile.write(b"<html><body><h1>200 OK - Access Granted! Welcome Admin.</h1></body></html>")
                    return
            except Exception:
                pass

        # If missing or incorrect credentials, challenge with HTTP 401
        self.send_response(401)
        self.send_header('WWW-Authenticate', 'Basic realm="Protected Lab Server"')
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(b"<html><body><h1>401 Unauthorized</h1></body></html>")

    def log_message(self, format, *args):
        # Print logs to console so students can watch requests arriving live
        print(f"[{self.log_date_time_string()}] {self.client_address[0]} -> {format % args}")

def run(port=8080):
    server_address = ('0.0.0.0', port)
    httpd = HTTPServer(server_address, AuthHandler)
    print("=" * 60)
    print(f"[+] Lab HTTP Basic Auth Service running on port {port}...")
    print(f"[+] Target Valid Credentials: admin : Secr3t!2026")
    print(f"[+] Press Ctrl+C to stop.")
    print("=" * 60)
    httpd.serve_forever()

if __name__ == '__main__':
    run()

