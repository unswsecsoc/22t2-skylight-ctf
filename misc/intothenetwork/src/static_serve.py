from http.server import HTTPServer, BaseHTTPRequestHandler

with open("static.html", "r") as f:
    static_data = f.read()


class StaticServer(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(static_data.encode())


def run_static():
    HTTPServer(('0.0.0.0', 8000), StaticServer).serve_forever()
