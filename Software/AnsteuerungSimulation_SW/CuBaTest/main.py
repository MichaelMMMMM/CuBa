from CSensorSimulation import CSensorSimulation
from CCOMInterface import CCOMInterface
import thread
import time
import os

def simulationThread(a):
    global sensorSimulation
    sensorSimulation = CSensorSimulation()
    sensorSimulation.run()

def comThread(a):
    global comInterface
    comInterface = CCOMInterface()
    comInterface.run()
    
def configMenu():
    print "[0] Start CuBa"
    print "[1] Set Jump Flag"
    print "[2] Set Balance Flag"
    print "[3] Set Transmit Flag"
    print "[4] End Execution"
def runningMenu():
    print "[0] Stop CuBa"
    print "[1] Jump"
    print "[2] Set PhiK"
    print "[3] Set PhiK_d"
    print "[4] Set PhiK_dd"
    print "[5] Set PhiR_d"
    print "[6] End Execution"
    
sensorSimulation = None
comInterface = None
thread.start_new_thread(simulationThread, (99,) )
thread.start_new_thread(comThread, (99,))

while(comInterface is None):
    pass

stop = False
config = True

while(stop == False):
    if(config == True):
        configMenu()
        userInput = raw_input("[*] Input: ")
        if(userInput == "0"):
            comInterface.start()
            time.sleep(0.05)
            config = False
        elif(userInput == "1"):
            flagValue = raw_input("[*] FlagValue: ")
            comInterface.setJumpFlag(int(flagValue))
        elif(userInput == "2"):
            flagvalue = raw_input("[*] FlagValue: ")
            comInterface.setBalanceFlag(int(flagValue))
        elif(userInput == "3"):
            flagValue = raw_input("[*] FlagValue: ")
            comInterface.setTransmitFlag(int(flagValue))
        elif(userInput == "4"):
            stop = True
            print "[*] ByeBye CuBa"
    else:
        runningMenu()
        userInput = raw_input("[*] Input: ")
        if(userInput == "0"):
            comInterface.stop()
            time.sleep(0.05)
            config = True
        elif(userInput == "1"):
            comInterface.jump()
            time.sleep(0.05)
        elif(userInput == "2"):
            phiValue = raw_input("[*] PhiKValue: ")
            sensorSimulation.setPhiK(int(phiValue))
        elif(userInput == "3"):
            phiValue = raw_input("[*] PhiK_dValue: ")
            sensorSimulation.setPhiK_d(int(phiValue))
        elif(userInput == "4"):
            phiValue = raw_input("[*] PhiK_ddValue: ")
            sensorSimulation.setPhiK_dd(int(phiValue))
        elif(userInput == "5"):
            phiValue = raw_input("[*] PhiR_dValue: ")
            sensorSimulation.setPhiR_d(int(phiValue))
        elif(userInput == "6"):
            stop = True
            print "[*] ByeBye CuBa"
    print "\n\n-------------------------------------------\n\n"

while(True):
    pass
print "End of Program"