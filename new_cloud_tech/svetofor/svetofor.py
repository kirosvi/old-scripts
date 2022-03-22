#################
#!/usr/bin/python
import RPi.GPIO as GPIO
import time
import sys
import argparse

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
SleepTimeL=1
SleepTimeL2=2

def choices_pin(pin):
	if pin == "OK":
		pipin=4
	elif pin == "Warning":
		pipin=3
	elif pin == "Alert":
		pipin=2
	return pipin

def switch_lite_on(pipin):
	print pipin
	GPIO.setup(pipin, GPIO.OUT)
	GPIO.output(pipin, GPIO.HIGH)

"""
GPIO.setup(pipin, GPIO.OUT)
GPIO.output(pipin, GPIO.HIGH)
"""

def switch_lite_off(pipin):
	print pipin
	GPIO.setup(pipin, GPIO.OUT)
	GPIO.output(pipin, GPIO.LOW)
	GPIO.cleanup(pipin)
"""
GPIO.cleanup(pipin)


GPIO.setmode(GPIO.BCM)
"""
def switch_blink_all():
	pinList = [2, 3, 4]
	while 1<2:
		for pin in pinList:
			GPIO.setup(pin, GPIO.OUT)
			GPIO.output(pin, GPIO.HIGH)
			print pin
			time.sleep(SleepTimeL);
			GPIO.output(pin, GPIO.LOW)
			GPIO.cleanup(pin)



def switch_blink(pin):
	pinList = [pin, 40]
	while 1<2:
		for i in pinList:
			GPIO.setup(i, GPIO.OUT)
			GPIO.output(i, GPIO.HIGH)
			time.sleep(SleepTimeL);
			GPIO.output(i, GPIO.LOW)
			GPIO.cleanup(i)

def switch_cleanup():
	pinList = [2, 3, 4]
	for i in pinList:
		GPIO.setup(i, GPIO.OUT)
		GPIO.output(i, GPIO.LOW)
		GPIO.cleanup(i)




parser = argparse.ArgumentParser()
parser.add_argument("-t", "--turn", choices=['none', 'On', 'Off', 'Blink', 'Blinkall', 'Cleanup'], help="chose turn on or turn off")
parser.add_argument("-p", "--pipin", choices=['none', 'OK', 'Warning', 'Alert'], help="chose what action you want")
args = parser.parse_args()
namespace = parser.parse_args(sys.argv[1:])
print args
print namespace.turn
print namespace.pipin




if namespace.turn == "On":
	switch_lite_on(choices_pin(namespace.pipin))
elif namespace.turn == "Off":
	switch_lite_off(choices_pin(namespace.pipin))
elif namespace.turn == "Blinkall":
	switch_blink_all()
elif namespace.turn == "Blink":
	switch_blink(choices_pin(namespace.pipin))
elif namespace.turn == "Cleanup":
	switch_cleanup()

"""
end 
"""

