import serial
import thread

class CSensorSimulation():
    def __init__(self):
        self.mPhiK        = 0
        self.mPhiK_d      = 0
        self.mPhiK_dd     = 0
        self.mPhiR_d      = 0
        self.mBrakeState  = 0
        self.mMotorTorque = 0
        
        self.mEventDict = { "REQUEST_PHI_K" : 1, \
                            "REQUEST_PHI_K_D" : 2, \
                            "REQUEST_PHI_K_DD" : 3, \
                            "REQUEST_PHI_R_D"  : 4, \
                            "SET_MOTOR_TORQUE" : 5, \
                            "SET_BRAKE_STATE"  : 6, }
        
        self.mSerial = serial.Serial("COM14", baudrate=9600, timeout=None)
        
        self.mLock = thread.allocate_lock()
        
    def run(self):
        while(True):
            rxBuffer = self.mSerial.read(3)
            event = int(rxBuffer[0].encode('hex'), 16)
            bufferValue = int(rxBuffer[1].encode('hex'), 0)
            
            if(event == self.mEventDict["REQUEST_PHI_K"]):
                self.sendPhiK()
            elif(event == self.mEventDict["REQUEST_PHI_K_D"]):
                self.sendPhiK_d()
            elif(event == self.mEventDict["REQUEST_PHI_K_DD"]):
                self.sendPhiK_dd()
            elif(event == self.mEventDict["REQUEST_PHI_R_D"]):
                self.sendPhiR_d()
            elif(event == self.mEventDict["SET_MOTOR_TORQUE"]):
                self.setMotorTorque(bufferValue)
                print "[*] MotorTorque set: " + str(bufferValue)
            elif(event == self.mEventDict["SET_BRAKE_STATE"]):
                self.setBrakeState(bufferValue)
                print "[*] BrakeState set: " + str(bufferValue)
    
    def sendPhiK(self):
        txBuffer =chr(0)
        txBuffer += chr(self.mPhiK)
        self.mSerial.write(txBuffer)
    def sendPhiK_d(self):
        txBuffer = chr(0)
        txBuffer += chr(self.mPhiK_d)
        self.mSerial.write(txBuffer)
    def sendPhiK_dd(self):
        txBuffer = chr(0)
        txBuffer += chr(self.mPhiK_dd)
        self.mSerial.write(txBuffer)
    def sendPhiR_d(self):
        txBuffer = chr(0)
        txBuffer += chr(self.mPhiR_d)
        self.mSerial.write(txBuffer)
    def setMotorTorque(self, torque):
        self.mMotorTorque = torque
    def setBrakeState(self, state):
        self.mBrakeState = state
    def setPhiK(self, phiK):
        self.mPhiK = phiK
    def setPhiK_d(self, phiK_d):
        self.mPhiK_d
    def setPhiK_dd(self, phiK_dd):
        self.mPhiK_dd = phiK_dd
    def setPhiR_d(self, phiR_d):
        self.mPhiR_d = phiR_d
    def getMotorTorque(self):
        return self.mMotorTorque
    def getBrakeState(self):
        return self.mBrakeState