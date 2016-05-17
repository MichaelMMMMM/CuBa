#include "CGyro.h"
#include "EBit.h"

CGyro::CGyro(I2C_HandleTypeDef& handle) :
							mXRawValue(0U),
							mYRawValue(0U),
							mZRawValue(0U),
							mI2CHandle(handle) {}
void CGyro::init()
{
	UInt8 CTRL_REG1_Address = sCTRL_REG1_G;
	UInt8 CTRL_REG1_Value	= 0x0FU;
	UInt8 txBuffer[] = { CTRL_REG1_Address, CTRL_REG1_Value };

	HAL_I2C_Master_Transmit(&mI2CHandle, EBit::BIT0 | sDeviceAddress, txBuffer, 2U, 5U);
}
void CGyro::readXRawValue()
{
	UInt8 xLowByte		= 0U;
	UInt8 xHighByte		= 0U;
	UInt8 xLowAddress  	= sReadXLowValue;
	UInt8 xHighAddress 	= sReadXHighValue;

	HAL_I2C_Master_Transmit(&mI2CHandle, sDeviceAddress, &(xLowAddress), 1U, 5U);
	HAL_I2C_Master_Receive(&mI2CHandle, sDeviceAddress, &xLowByte, sizeof(xLowByte), 5U);
	HAL_I2C_Master_Transmit(&mI2CHandle, sDeviceAddress, &(xHighAddress), 1U, 5U);
	HAL_I2C_Master_Receive(&mI2CHandle, sDeviceAddress, &xHighByte, sizeof(xHighByte), 5U);
	mXRawValue = (static_cast<UInt16>(xLowByte) | (static_cast<UInt16>(xHighByte) << 8U));
}
void CGyro::readYRawValue()
{
	UInt8 yLowByte		= 0U;
	UInt8 yHighByte		= 0U;
	UInt8 yLowAddress  	= sReadYLowValue;
	UInt8 yHighAddress 	= sReadYHighValue;

	HAL_I2C_Master_Transmit(&mI2CHandle, sDeviceAddress, &(yLowAddress), 1U, 5U);
	HAL_I2C_Master_Receive(&mI2CHandle, sDeviceAddress, &yLowByte, sizeof(yLowByte), 5U);
	HAL_I2C_Master_Transmit(&mI2CHandle, sDeviceAddress, &(yHighAddress), 1U, 5U);
	HAL_I2C_Master_Receive(&mI2CHandle, sDeviceAddress, &yHighByte, sizeof(yHighByte), 5U);
	mYRawValue = (static_cast<UInt16>(yLowByte) | (static_cast<UInt16>(yHighByte) << 8U));
}
void CGyro::readZRawValue()
{
	UInt8 zLowByte		= 0U;
	UInt8 zHighByte		= 0U;
	UInt8 zLowAddress  	= sReadZLowValue;
	UInt8 zHighAddress 	= sReadZHighValue;

	HAL_I2C_Master_Transmit(&mI2CHandle, sDeviceAddress, &(zLowAddress), 1U, 5U);
	HAL_I2C_Master_Receive(&mI2CHandle, sDeviceAddress, &zLowByte, sizeof(zLowByte), 5U);
	HAL_I2C_Master_Transmit(&mI2CHandle, sDeviceAddress, &(zHighAddress), 1U, 5U);
	HAL_I2C_Master_Receive(&mI2CHandle, sDeviceAddress, &zHighByte, sizeof(zHighByte), 5U);
	mZRawValue = (static_cast<UInt16>(zLowByte) | (static_cast<UInt16>(zHighByte) << 8U));
}
UInt16 CGyro::getXRawValue()
{
	this->readXRawValue();
	return mXRawValue;
}
UInt16 CGyro::getYRawValue()
{
	this->readYRawValue();
	return mYRawValue;
}
UInt16 CGyro::getZRawValue()
{
	this->readZRawValue();
	return mZRawValue;
}
