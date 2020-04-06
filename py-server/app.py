from http.server import HTTPServer, BaseHTTPRequestHandler
import os
from urllib import parse

import socket

APP_SERVER_PORT = int(os.getenv('PY_SERVER_PORT','8000'))
APP_SERVER_HOST_NAME = socket.gethostname() #os.getenv('PY_SERVER_HOST_NAME','')

print(f"APP_SERVER_PORT : {APP_SERVER_PORT}")
print(f"APP_SERVER_HOST_NAME : {APP_SERVER_HOST_NAME}")

class AppHttp(BaseHTTPRequestHandler):
    def do_GET(self):
        path = self.path
     
        self.send_response(200)
        self.end_headers()
        # self.wfile.write(b'Hello, world!')

        if path == "/greetings":
            message = f'Hello World from <h1>{APP_SERVER_HOST_NAME}</h1>'
            self.wfile.write(message.encode())
        elif '/square' in path:
            # parsed = urlparse.urlparse(path)
            # print(parse.parse_qs(parse.urlparse(path).query)['x'][0])
            var_x = parse.parse_qs(parse.urlparse(path).query)['x'][0]
            var_y = parse.parse_qs(parse.urlparse(path).query)['y'][0]
            var_result = int(var_x) ** int(var_y)
            message = f'Result {var_result}'
            self.wfile.write(message.encode())
        else:
            self.wfile.write(b'Hello, world!')

    

httpd = HTTPServer(('', APP_SERVER_PORT), AppHttp)
httpd.serve_forever()