#include "CMagnetometer.h"
#include "EBit.h"

CMagnetometer::CMagnetometer(I2C_HandleTypeDef& handle) :
											mXRawValue(0U),
											mYRawValue(0U),
											mZRawValue(0U),
											mI2CHandle(handle) {}
void CMagnetometer::init()
{
	UInt8 CTRL_REG7_Address = sCTRL_REG7_XM;
	UInt8 CTRL_REG7_Value	= 0b10000000U;
	UInt8 txBuffer[] = { CTRL_REG7_Address, CTRL_REG7_Value };
	HAL_I2C_Master_Transmit(&mI2CHandle, EBit::BIT0 | sDeviceAddress, txBuffer, 2U, 5U);

	UInt8 CTRL_REG6_Address = sCTRL_REG6_XM;
	UInt8 CTRL_REG6_Value 	= EBit::BIT6 | EBit::BIT5;
	txBuffer[0] = CTRL_REG6_Address;
	txBuffer[1] = CTRL_REG6_Value;
	HAL_I2C_Master_Transmit(&mI2CHandle, EBit::BIT0 | sDeviceAddress, txBuffer, 2U, 5U);
}
UInt16 CMagnetometer::getXOffset()
{
	UInt8 xLowByte 		= 0x00U;
	UInt8 xHighByte 	= 0x00U;
	UInt8 xLowAddress  	= sOFFSET_X_L_M;
	UInt8 xHighAddress 	= sOFFSET_X_H_M;

	HAL_I2C_Master_Transmit(&mI2CHandle, sDeviceAddress, &(xLowAddress), 1U, 5U);
	HAL_I2C_Master_Receive(&mI2CHandle, sDeviceAddress, &xLowByte, sizeof(xLowByte), 5U);
	HAL_I2C_Master_Transmit(&mI2CHandle, sDeviceAddress, &(xHighAddress), 1U, 5U);
	HAL_I2C_Master_Receive(&mI2CHandle, sDeviceAddress, &xHighByte, sizeof(xHighByte), 5U);
	return (static_cast<UInt16>(xLowByte) | (static_cast<UInt16>(xHighByte) << 8U));
}
void CMagnetometer::readXRawValue()
{
	UInt8 xLowByte 		= 0x00U;
	UInt8 xHighByte 	= 0x00U;
	UInt8 xLowAddress  	= sReadXLowValue;
	UInt8 xHighAddress 	= sReadXHighValue;

	HAL_I2C_Master_Transmit(&mI2CHandle, sDeviceAddress, &(xLowAddress), 1U, 5U);
	HAL_I2C_Master_Receive(&mI2CHandle, sDeviceAddress, &xLowByte, sizeof(xLowByte), 5U);
	HAL_I2C_Master_Transmit(&mI2CHandle, sDeviceAddress, &(xHighAddress), 1U, 5U);
	HAL_I2C_Master_Receive(&mI2CHandle, sDeviceAddress, &xHighByte, sizeof(xHighByte), 5U);
	mXRawValue = (static_cast<UInt16>(xLowByte) | (static_cast<UInt16>(xHighByte) << 8U));
}
void CMagnetometer::readYRawValue()
{
	UInt8 yLowByte		= 0x00U;
	UInt8 yHighByte		= 0x00U;
	UInt8 yLowAddress  	= sReadYLowValue;
	UInt8 yHighAddress 	= sReadYHighValue;

	HAL_I2C_Master_Transmit(&mI2CHandle, sDeviceAddress, &(yLowAddress), 1U, 5U);
	HAL_I2C_Master_Receive(&mI2CHandle, sDeviceAddress, &yLowByte, sizeof(yLowByte),5U);
	HAL_I2C_Master_Transmit(&mI2CHandle, sDeviceAddress, &(yHighAddress), 1U, 5U);
	HAL_I2C_Master_Receive(&mI2CHandle, sDeviceAddress, &yHighByte, sizeof(yHighByte),5U);
	mYRawValue = (static_cast<UInt16>(yLowByte) | (static_cast<UInt16>(yHighByte) << 8U));
}
void CMagnetometer::readZRawValue()
{
	UInt8 zLowByte		= 0x00U;
	UInt8 zHighByte		= 0x00U;
	UInt8 zLowAddress  	= sReadZLowValue;
	UInt8 zHighAddress 	= sReadZHighValue;

	HAL_I2C_Master_Transmit(&mI2CHandle, sDeviceAddress, &(zLowAddress), 1U, 5U);
	HAL_I2C_Master_Receive(&mI2CHandle, sDeviceAddress, &zLowByte, sizeof(zLowByte), 5U);
	HAL_I2C_Master_Transmit(&mI2CHandle, sDeviceAddress, &(zHighAddress), 1U, 5U);
	HAL_I2C_Master_Receive(&mI2CHandle, sDeviceAddress, &zHighByte, sizeof(zHighByte), 5U);
	mZRawValue = (static_cast<UInt16>(zLowByte) | (static_cast<UInt16>(zHighByte) << 8U));
}
UInt16 CMagnetometer::getXRawValue()
{
	this->readXRawValue();
	return mXRawValue;
}
UInt16 CMagnetometer::getYRawValue()
{
	this->readYRawValue();
	return mYRawValue;
}
UInt16 CMagnetometer::getZRawValue()
{
	this->readZRawValue();
	return mZRawValue;
}
