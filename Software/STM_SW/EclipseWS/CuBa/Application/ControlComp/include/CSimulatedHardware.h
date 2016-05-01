/************************************************
 * Author: Michael Meindl
 * Datum : 21.04.2016
 ***********************************************/
#ifndef CSIMULATEDHARDWARE_H
#define CSIMULATEDHARDWARE_H
#include "IHardwareInterface.h"
#include "TUSART.h"

class CSimulatedHardware : public IHardwareInterface
{
public:
	UInt16 getPhiK() override;
	UInt16 getPhiK_d() override;
	UInt16 getPhiK_dd() override;
	UInt16 getPhiR_d() override;
	void controlIteration() override;
	void activateBrake() override;
	void deactivateBrake() override;
	void setMotorTorque(UInt16 torque) override;
public:
	CSimulatedHardware();
	CSimulatedHardware(const CSimulatedHardware&) = delete;
	CSimulatedHardware& operator=(const CSimulatedHardware&) = delete;
	~CSimulatedHardware() = default;
private:
	TUSART<ERegister::rUSART3> mUSART;
};

#endif
