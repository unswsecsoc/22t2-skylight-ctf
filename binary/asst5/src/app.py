##########################################################################
# Welcome to the webserver! If you're playing the CTF, reading this file #
# won't help you :(                                                      #
##########################################################################

from flask import Flask, send_file, request
import secrets
import subprocess
import time
import os

app = Flask(__name__)

INDEX_FILE = '''
<!doctype html>
<html lang="en" data-theme="dark">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://unpkg.com/@picocss/pico@latest/css/pico.min.css">
    <title>COMP3891 - ASST5</title>
  </head>
  <body>
    <main class="container">
      <h1>COMP3891 - ASST5</h1>

      <p>Once you have used "compile_pwn.sh" (from "files.zip") upload the
      "pwn" binary here. Good luck!</p>

      <form action="/exploit" method="post" enctype="multipart/form-data">
        <input type="file" id="pwnbin" name="pwnbin">
        <input type="submit">
      </form>

      <!--
        If you want the server source code: /source
      -->

    </main>
  </body>
</html>
'''

# Script used to execute os161
RUN_CMD = '''
bin={}
export PATH="$PATH":/app/files/tools/os161/bin
export PATH="$PATH":/app/files/tools/sys161/bin
cd /app/dojo/

# Shouldn't take longer than 5 seconds
timeout 5 sys161 -X kernel "p $bin"
'''

@app.route('/')
def index():
    return INDEX_FILE


@app.route('/exploit', methods=['POST'])
def exploit():

    rnd = secrets.token_hex(16)
    dest = f'/app/dojo/bin/{rnd}.bin'

    cmd=RUN_CMD.format(f'/bin/{rnd}.bin')

    try:
        f = request.files['pwnbin']
        f.save(dest)

        # No brute forcing allowed :(
        time.sleep(secrets.randbelow(5) + 5)

        # Sys161 gets sad when we don't own the file
        subprocess.run(['chown', 'sky:sky', dest])

        proc = subprocess.run(
            ['runuser', '--login', 'sky', '/bin/bash', '-c', cmd],
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT
        )
    except KeyError:
        return request.files
        return 'Invalid request :(\n'
    finally:
        subprocess.run(['rm', '-f', dest])

    return b'<pre>' + proc.stdout + b'</pre>'


@app.route('/source')
def source():
    return send_file('/app/app.py')


if __name__ == '__main__':
    app.run(host='0.0.0.0')


