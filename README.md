# AutomatedCyberAttacker
An Automated and Semi-Intelligent Cyber Attacker

This project is aimed to be a proof of concept towards AI hacking. With AIs being inevitible in the world of computer security, it is important to accept it and attempt to recreate what attackers may use. This way we can train to prevent these attacks or create AIs of our own to protect our data from being breached.

PyMetasploit and PySWIP are used in this project and can be found here:
```
https://github.com/allfro/pymetasploit
https://github.com/yuce/pyswip
```

And can be installed on the command line with:
```
pip install pymetasploit
pip install pyswip
```

The attacking operating system is Kali Linux and the victim machine is Metasploitable II. 
Importatant key notes:
  - Check if Metasploit server and Postgresql are up and running before using any attacks
  - Start the msfrpcd at the beginning of the session through the script (for some reason PyMetasploit does not access the current running server)
  - This project is targeting a specific IP address just as proof that automation and semi-intelligence is possible, tweaks and more reconnaissance would be needed to attack a random IP address on the network
  - This project was experimented and conducted within an isolated network
