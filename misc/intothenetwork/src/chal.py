#!/usr/bin/env python3

import socket
import threading
import subprocess
import random

from static_serve import run_static

# Start the static html server
t = threading.Thread(target=run_static)
t.daemon = True
t.start()

# Game
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.bind(('0.0.0.0', 1234))

PASSWD = str(random.randint(0, 99999999999999999999999999999999))

while 1:
    msg, addr = s.recvfrom(1024)

    try:
        msg = msg.decode()

        if msg.startswith('hi'):
            s.sendto(b"hi\n", addr)
        elif msg.startswith('fact '):
            with open('./facts/' + msg[5:].strip(), 'rb') as f:
                s.sendto(f.read(), addr)
        elif msg.startswith('setpass '):
            # Check if being accessed by admin with specific IP
            if addr[0] == '1.2.3.4':
                new_passwd = msg[8:].strip()
                if len(new_passwd) > 5:
                    PASSWD = new_passwd
                    s.sendto(b"success\n", addr)
                else:
                    s.sendto(b"fail: bad password\n", addr)
            else:
                s.sendto(b"Only an admin can set the password\n", addr)
        elif msg.startswith('flag '):
            if msg[5:].strip() == PASSWD:
                s.sendto(subprocess.run(
                    ['./show_flag'], stdout=subprocess.PIPE).stdout, addr)
                s.sendto(b"Flag recieved! Resetting password...\n", addr)
                PASSWD = str(random.randint(
                    0, 99999999999999999999999999999999))
            else:
                s.sendto(b"Wrong password!\n", addr)
        else:
            with open('help.txt', 'rb') as f:
                s.sendto(f.read(), addr)

    except BaseException as err:
        s.sendto(b"UNEXPECTED ERROR!\n" + str(err).encode() + b"\n", addr)
