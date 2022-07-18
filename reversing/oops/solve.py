#!/usr/bin/env python3

import subprocess

with open("oops.js") as f:
    js = f.read().rstrip()

    for idx in range(0, len(js)):
        js_new = js[:idx] + "!" + js[idx:]

        try:
            subprocess.run(["node", "-e", js_new], stderr=subprocess.DEVNULL, check=True)
            print(idx)
        except subprocess.CalledProcessError:
            print(f"{idx:5} ", end="", flush=True)
