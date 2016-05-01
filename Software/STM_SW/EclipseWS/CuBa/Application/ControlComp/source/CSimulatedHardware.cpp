/************************************************
 * Author: Michael Meindl
 * Datum : 21.04.2016
 ***********************************************/
#include "CSimulatedHardware.h"
#include "ETestCoding.h"

CSimulatedHardware::CSimulatedHardware() : mUSART() {}
UInt16 CSimulatedHardware::getPhiK()
{
	mUSART.blockSendByte(static_cast<UInt8>(ETestCoding::REQUEST_PHI_K));
	mUSART.blockSendByte(0U);
	mUSART.blockSendByte(0U);
	union
	{
		UInt8 mUSARTBuffer[2];
		UInt16 mValue;
	};

	mUSARTBuffer[0] = mUSART.blockReadBuffer();
	mUSARTBuffer[1] = mUSART.blockReadBuffer();
	return mValue;
}
void CSimulatedHardware::setMotorTorque(UInt16 torque)
{
	mUSART.blockSendByte(static_cast<UInt8>(ETestCoding::SET_MOTOR_TORQUE));
	union
	{
		UInt8 mBuffer[2];
		UInt16 mValue;
	};
	mValue = torque;
	mUSART.blockSendByte(mBuffer[0]);
	mUSART.blockSendByte(mBuffer[1]);
}
UInt16 CSimulatedHardware::getPhiK_d()
{
	mUSART.blockSendByte(static_cast<UInt8>(ETestCoding::REQUEST_PHI_K_D));
	mUSART.blockSendByte(0U);
	mUSART.blockSendByte(0U);

	union
	{
		UInt8 mUSARTBuffer[2];
		UInt16 mValue;
	};
	mUSARTBuffer[0] = mUSART.blockReadBuffer();
	mUSARTBuffer[1] = mUSART.blockReadBuffer();
	return mValue;
}
UInt16 CSimulatedHardware::getPhiK_dd()
{
	mUSART.blockSendByte(static_cast<UInt8>(ETestCoding::REQUEST_PHI_K_DD));
	mUSART.blockSendByte(0U);
	mUSART.blockSendByte(0U);

	union
	{
		UInt8 mUSARTBuffer[2];
		UInt16 mValue;
	};
	mUSARTBuffer[0] = mUSART.blockReadBuffer();
	mUSARTBuffer[1] = mUSART.blockReadBuffer();
	return mValue;
}
UInt16 CSimulatedHardware::getPhiR_d()
{
	mUSART.blockSendByte(static_cast<UInt8>(ETestCoding::REQUEST_PHI_R_D));
	mUSART.blockSendByte(0U);
	mUSART.blockSendByte(0U);

	union
	{
		UInt8 mUSARTBuffer[2];
		UInt16 mValue;
	};
	mUSARTBuffer[0] = mUSART.blockReadBuffer();
	mUSARTBuffer[1] = mUSART.blockReadBuffer();
	return mValue;
}
void CSimulatedHardware::controlIteration()
{

}
void CSimulatedHardware::activateBrake()
{
	mUSART.blockSendByte(static_cast<UInt8>(ETestCoding::SET_BRAKE_STATE));
	mUSART.blockSendByte(1U);
	mUSART.blockSendByte(0U);

}
void CSimulatedHardware::deactivateBrake()
{
	mUSART.blockSendByte(static_cast<UInt8>(ETestCoding::SET_BRAKE_STATE));
	mUSART.blockSendByte(0U);
	mUSART.blockSendByte(0U);
}
