from flask import Flask, render_template, request
from Crypto.Cipher import AES
from Crypto.Hash import SHA256
from util import filter_bytes, json_decode, json_encode, pad, unpad
from os import urandom

app = Flask('padmac')

KEY = urandom(16)
HASH_KEY = urandom(16)


def generate_cookie_and_hmac(name):
    iv = urandom(16)

    cipher = AES.new(KEY, AES.MODE_CBC, iv)

    msg = json_encode({
        "admin": False,
        "name": name
    })

    hmac = SHA256.new(data=(HASH_KEY + msg)).digest()

    padded_cookie = pad(msg)

    encrypted = cipher.encrypt(padded_cookie)

    return iv + encrypted, hmac


def decrypt_cookie(cookie, hmac):
    iv = bytes.fromhex(cookie)[:16]
    encrypted = bytes.fromhex(cookie)[16:]
    hmac = bytes.fromhex(hmac)

    cipher = AES.new(KEY, AES.MODE_CBC, iv)

    plaintext = cipher.decrypt(encrypted)

    unpadded = unpad(plaintext)

    expected_hmac = SHA256.new(data=(HASH_KEY + unpadded)).digest()

    if expected_hmac != hmac:
        raise Exception("hmac did not match the data!")

    # IDK if json deserialisation attacks are a thing, but I've added
    # a whitelist just in case
    cookie_data = json_decode(filter_bytes(unpadded))

    return cookie_data


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/login', methods=["POST"])
def login():
    if not "name" in request.json or type(request.json["name"]) != str:
        return {
            "error": True,
            "reason": "Must supply name"
        }

    cookie, hmac = generate_cookie_and_hmac(request.json["name"])

    return {
        "cookie": cookie.hex(),
        "hmac": hmac.hex()
    }


@app.route('/flag', methods=["POST"])
def flag():
    if not "cookie" in request.json or type(request.json["cookie"]) != str:
        return {
            "error": True,
            "reason": "Invalid cookie"
        }
    if not "hmac" in request.json or type(request.json["hmac"]) != str:
        return {
            "error": True,
            "reason": "Invalid hmac"
        }

    try:
        cookie = decrypt_cookie(
            request.json["cookie"], request.json["hmac"])
    except Exception as e:
        return {
            "error": True,
            "reason": str(e)
        }

    if "admin" in cookie and type(cookie["admin"]) == bool and cookie["admin"]:
        return {
            "flag": "SKYLIGHT{sT0p_h4cking_d4_MAC5_pl5}"
        }
    else:
        return {
            "error": True,
            "reason": "You are not an admin"
        }
