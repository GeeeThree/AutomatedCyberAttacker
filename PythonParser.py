import os
import sys
import string
import time

ports = open("/home/PortsAndPortTypes.txt", "r")
openorclosed = open("/home/openports.txt", "w")
portno = open("/home/portumber.txt", "w")
porttype = open("/home/porttype.txt", "w")

ipline = ports.readline()
for x in ipline:
	openorclosed.write(x.split('\t')[1])
	portno.write(x.split('\t')[2])
	porttype.write(x.split('\t')[3])
