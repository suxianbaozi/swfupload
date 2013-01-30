import socket
import time
from threading import Thread
import os
import sys



class returnCrossDomain(Thread):
    def __init__(self,connection):
        Thread.__init__(self)
        self.con = connection
    def run(self):
        xmlData  = '''<?xml version="1.0" encoding="utf-8"?>'''
        xmlData += '''<!DOCTYPE cross-domain-policy SYSTEM "http://www.adobe.com/xml/dtds/cross-domain-policy.dtd">'''
        xmlData += '''<cross-domain-policy><site-control permitted-cross-domain-policies="all"/>'''
        xmlData += '''<allow-access-from domain="*.aifang.com" to-ports="*" />'''
        xmlData += '''<allow-access-from domain="*.anjuke.com" to-ports="*" />'''
        xmlData += '''<allow-access-from domain="*.haozu.com" to-ports="*" />'''
        xmlData += '''<allow-access-from domain="*.jinpu.com" to-ports="*" />'''
        xmlData += '''<allow-access-from domain="*.ajkcdn.com" to-ports="*" />'''
        xmlData += '''<allow-access-from domain="*.aifcdn.com" to-ports="*" />'''
        xmlData += '''<allow-access-from domain="*.anjukestatic.com" to-ports="*" />'''
	xmlData += '''</cross-domain-policy>\0'''
        try:
            self.con.send(xmlData)
        except Excepiton,e:
            pass
        self.con.close()

def demaeon():
    try:
        pid = os.fork()
        if pid > 0:
            sys.exit(0)
    except OSError, e:
        sys.exit(4)

    os.chdir('/')
    os.umask(0)
    os.setsid()

    try:
        pid = os.fork()
        if pid > 0:
            sys.exit(0)
    except OSError, e:
        sys.exit(4)


    for f in sys.stdout, sys.stderr: f.flush()


    si = file("/dev/null", 'r')
    so = file("/tmp/server.log", 'a+')
    se = file("/tmp/servererror.log", 'a+', 0)
    os.dup2(si.fileno(), sys.stdin.fileno())
    os.dup2(so.fileno(), sys.stdout.fileno())
    os.dup2(se.fileno(), sys.stderr.fileno())


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
    demaeon()
    main()
            


 
