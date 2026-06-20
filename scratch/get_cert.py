import ssl
import socket

hostname = 'api.themoviedb.org'
port = 443

cert = ssl.get_server_certificate((hostname, port))
with open('certificates/themoviedb.pem', 'w') as f:
    f.write(cert)
