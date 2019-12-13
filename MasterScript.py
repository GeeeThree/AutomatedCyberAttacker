import os
import sys
import string
import time

os.system("gnome-terminal -e 'python PyScript.py'")
time.sleep(90)
os.system("gnome-terminal -e 'python PythonParser.py'")
time.sleep(10)
os.system("gnome-terminal -e 'python InferenceEngine2.py'")
