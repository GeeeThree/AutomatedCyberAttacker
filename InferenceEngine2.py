import os
import sys
import time
from pyswip import *

prolog = Prolog()
prolog.consult("InferenceEngine.pl")
attack = Functor("attack", 1)

X = Variable(); Y = Variable(); Z = Variable()

reversetcp = 0
pwcrack = 0
denial = 0
mitm = 0

reversetcp_weight = 10
denial_weight = 8
mitm_weight = 6
pwcrack_weight = 5


q = Query(attack(X))
while q.nextSolution():
	
	if(str(X.value) == "reverse_tcp"):
		reversetcp = reversetcp + 1
	elif(str(X.value) == "pwcrack"):
		pwcrack = pwcrack + 1
	elif(str(X.value) == "denial"):
		denial = denial + 1
	elif(str(X.value) == "mitm"):
		mitm = mitm + 1
q.closeQuery()

reversetcp_total_value = reversetcp * reversetcp_weight
pwcrack_total_value = pwcrack * pwcrack_weight
denial_total_value = denial * denial_weight
mitm_total_value = mitm * mitm_weight

attack_max = max(reversetcp_total_value, pwcrack_total_value, denial_total_value, mitm_total_value)

print("The attack that should be used is: ")
if(attack_max == reversetcp_total_value):
	print("Reverse TCP")
elif(attack_max == pwcrack_total_value):
	print("Password Crack")
elif(attack_max == denial_total_value):
	print("Denial of Service or Distributed Denial of Service")
elif(attack_max == mitm_total_value):
	print("Man in the Middle attack")

time.sleep(500)








