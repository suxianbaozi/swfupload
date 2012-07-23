import socket
import time
from threading import Thread

class returnCrossDomain(Thread):
    def __init__(self,connection):
        Thread.__init__(self)
        self.con = connection
    def run(self):
        try:
            self.con.send('''\n
            <?xml version="1.0" encoding="utf-8"?>\n
            <!DOCTYPE cross-domain-policy SYSTEM "http://www.adobe.com/xml/dtds/cross-domain-policy.dtd">\n
            <cross-domain-policy><site-control permitted-cross-domain-policies="all"/>\n
            <allow-access-from domain="*.sofock.com" to-ports="*" />\n
            <allow-access-from domain="*.pages.aifcdn.com" to-ports="*" />\n
            <allow-access-from domain="*.aifcdn.com" to-ports="*" />\n
            <allow-access-from domain="anjuke.adsame.com" to-ports="*" />\n
            <allow-access-from domain="anjuke.adsame.com" to-ports="*" />\n
            </cross-domain-policy>\0\n
            ''')
        except:
            pass
        self.con.close()
        
        
def main():
    sock = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
    sock.bind(('',843))
    sock.listen(100)
    while True:
        try:
            connection,address = sock.accept()
            returnCrossDomain(connection).start()
        except:
            time.sleep(1)

if __name__=="__main__":
    main()
            


 
