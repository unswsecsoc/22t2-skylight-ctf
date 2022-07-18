from flask import Flask, render_template, request
from json import loads

from cbcrsa import CBCRSA

app = Flask(__name__)

cipher = CBCRSA()


@app.route("/")
def index_route():
    return render_template('index.html')


@app.route("/flag")
def flag_route():
    auth_cookie = request.cookies.get('auth')

    if auth_cookie is None:
        return "Please supply the cookie with key 'auth'"

    msg = cipher.dec(auth_cookie)
    cook_data = loads(msg)

    if cook_data["is_admin"] is True:
        return "SKYLIGHT{symm3tric_crypt0_15_34sy_2_m3ss_Up}"

    return "Cookie is valid, but you are not an admin"
