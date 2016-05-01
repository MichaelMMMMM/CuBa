import serial
import thread

class CCOMInterface:
    def __init__(self):
        self.mSerial = serial.Serial("COM12", baudrate=9600, timeout=None)
        self.mReceivedPackages = list()
        self.mTxBufferEmpty = True
        self.mTxBuffer = None
        self.mComponentIDDict = {"CONTROL_COMP" : 0, \
                                 "COMM_COMP" : 1 }
        self.mControlEventDict = { "EV_START" : 1, \
                                   "EV_STOP" : 2, \
                                   "EV_SET_JUMP_FLAG" : 3, \
                                   "EV_SET_BALANCE_FLAG" : 4, \
                                   "EV_SET_TRANSMIT_FLAG" : 5, \
                                   "EV_SET_JUMP_VELOCITY" : 6, \
                                   "EV_SET_PID_VALUES" : 7, \
                                   "EV_JUMP" : 8, \
                                   "EV_BRAKE" : 9, \
                                   "EV_PHIK_IN_BALANCEAREA" : 10,\
                                   "EV_PHIK_NOT_IN_BALANCEAREA" : 11,\
                                   "EV_TIMER" : 12, \
                                   "EV_INIT" : 13, \
                                   "EV_EXIT" : 14, \
                                   "EV_RESTING" : 15, \
                                   "EV_NOT_RESTING" : 16, \
                                   "EV_JUMP_VELOCITY_REACHED" : 17}
        self.mCommEventDict = { "EV_TRANSMIT_TORQUE" : 2, \
                                "EV_TRANSMIT_PHI_K" : 3, \
                                "EV_TRANSMIT_PHI_K_D" : 4, \
                                "EV_TRANSMIT_PHI_K_DD" : 5, \
                                "EV_TRANSMIT_PHI_R_D" : 6, \
                                "EV_TRANSMIT_BRAKE_STATE" : 7, \
                                "EV_TRANSMIT_STATE_ENTRY" : 8, \
                                "EV_TRANSMIT_UNHANDELED_EV" : 9}
        self.mStateList = ["CONFIGURATION", "RUNNING", "IDLE", "BALANCE", "JUMP", "WAITING", "ACCELERATE", "BRAKE"]
        self.mLock = thread.allocate_lock()
    def run(self):
        while(True):
            if(self.mSerial.in_waiting >= 4):
                receivedPackage = self.mSerial.read(4)
                self.mReceivedPackages.append(receivedPackage)
                event = int(receivedPackage[1].encode('hex'), 16)
                if(event == self.mCommEventDict["EV_TRANSMIT_STATE_ENTRY"]):
                    state = int(receivedPackage[2].encode('hex'), 16)
                    print "[*] CuBa entered State: " + self.mStateList[state]
            if(self.mTxBufferEmpty == False):
                self.mLock.acquire()
                self.mSerial.write(self.mTxBuffer)
                self.mTxBufferEmpty = True
                self.mLock.release()
    def setTransmitFlag(self, flagValue):
        txPack = chr(self.mComponentIDDict["CONTROL_COMP"])
        txPack += chr(self.mControlEventDict["EV_SET_TRANSMIT_FLAG"])
        txPack += chr(flagValue)
        txPack += chr(0)
        self.writeTxBuffer(txPack)
    def setBalanceFlag(self, flagValue):
        txPack = chr(self.mComponentIDDict["CONTROL_COMP"])
        txPack += chr(self.mControlEventDict["EV_SET_BALANCE_FLAG"])
        txPack += chr(flagValue)
        txPack += chr(0)
        self.writeTxBuffer(txPack)
    def setJumpFlag(self, flagValue):
        txPack = chr(self.mComponentIDDict["CONTROL_COMP"])
        txPack += chr(self.mControlEventDict["EV_SET_JUMP_FLAG"])
        txPack += chr(flagValue)
        txPack += chr(0)
        self.writeTxBuffer(txPack)
        self.writeTxBuffer(txPack)
    def start(self):
        txPack = chr(self.mComponentIDDict["CONTROL_COMP"])
        txPack += chr(self.mControlEventDict["EV_START"])
        txPack += chr(0)
        txPack += chr(0)
        self.writeTxBuffer(txPack)
    def stop(self):
        txPack = chr(self.mComponentIDDict["CONTROL_COMP"])
        txPack += chr(self.mControlEventDict["EV_STOP"])
        txPack += chr(0)
        txPack += chr(0)
        self.writeTxBuffer(txPack)
    def jump(self):
        txPack = chr(self.mComponentIDDict["CONTROL_COMP"])
        txPack += chr(self.mControlEventDict["EV_JUMP"])
        txPack += chr(0)
        txPack += chr(0)
        self.writeTxBuffer(txPack)
    def writeTxBuffer(self, txPack):
        while(self.mTxBufferEmpty == False):
            pass
        self.mLock.acquire()
        self.mTxBufferEmpty = False
        self.mTxBuffer = txPack
        self.mLock.release()
        