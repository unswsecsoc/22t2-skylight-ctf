#!/usr/bin/python3
from http.server import BaseHTTPRequestHandler, HTTPServer
from hashpumpy import hashpump
from requests import Session
import subprocess
import threading

target = "http://localhost:8080/"

s = Session()

NAME = "AAAAAA"
KNOWN_PLAINTEXT = b'"admin": false, "name": "AAAAAA"'
ADDED_VALUE = b',"admin":true'


def get_cookie():
    return s.post(target + "login", json={"name": NAME}).json()


def get_flag(cookie, hmac):
    return s.post(target + "flag", json={"cookie": cookie, "hmac": hmac}).json()


cook = get_cookie()
cookie = bytes.fromhex(cook['cookie'])
hmac = bytes.fromhex(cook['hmac'])

print("Cookie:", cookie.hex())


class MyServer(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write(str(get_flag(self.path.lstrip('/'), '00')).encode())

    def log_message(self, format, *args):
        return


webServer = HTTPServer(('127.0.0.1', 9001), MyServer)


def test_server():
    webServer.serve_forever()


threading.Thread(target=test_server, daemon=True).start()

forged_hmac_hex, target_data = hashpump(
    hmac.hex(), KNOWN_PLAINTEXT, ADDED_VALUE, 16)

print("HMAC", forged_hmac_hex)

print("Running padbuster... This could take a while")

res = subprocess.run(["docker", "run", "--rm", "-it", "4armed/padbuster", "http://host.docker.internal:9001/" +
                      cookie.hex(), cookie.hex(), "16", "-encoding", "1", "-encodedtext", target_data.hex(), "-error", "padding invalid"], capture_output=True)

forged_cookie_hex = None
FIND_TERM = '[+] Encrypted value is: '

for l in res.stdout.decode().splitlines():
    if FIND_TERM in l:
        forged_cookie_hex = l[len(FIND_TERM):]

print("COOKIE", forged_cookie_hex)

print(get_flag(forged_cookie_hex, forged_hmac_hex))
