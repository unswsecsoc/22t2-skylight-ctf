from flask import Flask, request

app = Flask(__name__)

@app.route("/")
def hello_world():
    if request.headers['Host'] == 'super.secret.dev.environment.com':
        return "<h1>Super secret dev environment</h1><p>Well done, here's your flag: SKYLIGHT{sn4zzy_1ns3cure_v1rtual_h0sting}</p>"
    else:
        return open('hello.html', 'r').read()

