/************************************************
 * Author: Michael Meindl
 * Datum : 21.04.2016
 ***********************************************/
#ifndef IHARDWAREINTERFACE_H
#define IHARDWAREINTERFACE_H
#include "Global.h"

class IHardwareInterface
{
public:
	virtual UInt16 getPhiK() = 0;
	virtual UInt16 getPhiK_d() = 0;
	virtual UInt16 getPhiK_dd() = 0;
	virtual UInt16 getPhiR_d() = 0;
	virtual void controlIteration() = 0;
	virtual void activateBrake() = 0;
	virtual void deactivateBrake() = 0;
	virtual void setMotorTorque(UInt16 torque) = 0;
public:
	IHardwareInterface() = default;
	IHardwareInterface(const IHardwareInterface&) = delete;
	IHardwareInterface& operator=(const IHardwareInterface&) = delete;
	virtual ~IHardwareInterface() = default;
};

#endif
