from http.server import HTTPServer, BaseHTTPRequestHandler
import socket

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        html = f"""<html><body style="font-family:sans-serif;text-align:center">
<h1>Capstone Project 08</h1>
<p>Docker app running inside a container</p>
<p>Container ID: {socket.gethostname()}</p>
</body></html>"""
        self.send_response(200)
        self.send_header("Content-Type", "text/html")
        self.end_headers()
        self.wfile.write(html.encode())

print("Server running on port 8080")
HTTPServer(("0.0.0.0", 8080), Handler).serve_forever()
