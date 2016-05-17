#include <EBit.h>
#include "CMagnetometer.h"

CMagnetometer::CMagnetometer(I2C_HandleTypeDef& handle) :
											mXRawValue(0U),
											mYRawValue(0U),
											mZRawValue(0U),
											mI2CHandle(handle) {}
bool CMagnetometer::init()
{
	UInt8 CTRL_REG7_Address = sCTRL_REG7_XM;
	UInt8 CTRL_REG7_Value	= 0b10000000U;
	UInt8 txBuffer[] = { CTRL_REG7_Address, CTRL_REG7_Value };
	HAL_I2C_Master_Transmit(&mI2CHandle, EBit::BIT0 | sDeviceAddress, txBuffer, 2U, 5U);

	UInt8 CTRL_REG6_Address = sCTRL_REG6_XM;
	UInt8 CTRL_REG6_Value 	= EBit::BIT6 | EBit::BIT5;
	txBuffer[0] = CTRL_REG6_Address;
	txBuffer[1] = CTRL_REG6_Value;
	HAL_StatusTypeDef status = HAL_I2C_Master_Transmit(&mI2CHandle, EBit::BIT0 | sDeviceAddress, txBuffer, 2U, 5U);
	return status == HAL_OK;
}
bool CMagnetometer::readXRawValue()
{
	UInt8 xLowByte 		= 0x00U;
	UInt8 xHighByte 	= 0x00U;
	UInt8 xLowAddress  	= sReadXLowValue;
	UInt8 xHighAddress 	= sReadXHighValue;

	HAL_StatusTypeDef status = HAL_OK;
	status = HAL_I2C_Master_Transmit(&mI2CHandle, sDeviceAddress, &(xLowAddress), 1U, 5U);
	if(status == HAL_OK)
	{
		status = HAL_I2C_Master_Receive(&mI2CHandle, sDeviceAddress, &xLowByte, sizeof(xLowByte), 5U);
		if(status == HAL_OK)
		{
			status = HAL_I2C_Master_Transmit(&mI2CHandle, sDeviceAddress, &(xHighAddress), 1U, 5U);
			if(status == HAL_OK)
			{
				status = HAL_I2C_Master_Receive(&mI2CHandle, sDeviceAddress, &xHighByte, sizeof(xHighByte), 5U);
			}
		}
	}
	if(status == HAL_OK)
	{
		mXRawValue = (static_cast<UInt16>(xLowByte) | (static_cast<UInt16>(xHighByte) << 8U));
		return true;
	}
	else
	{
		return false;
	}
}
bool CMagnetometer::readYRawValue()
{
	UInt8 yLowByte		= 0x00U;
	UInt8 yHighByte		= 0x00U;
	UInt8 yLowAddress  	= sReadYLowValue;
	UInt8 yHighAddress 	= sReadYHighValue;

	HAL_StatusTypeDef status = HAL_OK;
	status = HAL_I2C_Master_Transmit(&mI2CHandle, sDeviceAddress, &(yLowAddress), 1U, 5U);
	if(status == HAL_OK)
	{
		status = HAL_I2C_Master_Receive(&mI2CHandle, sDeviceAddress, &yLowByte, sizeof(yLowByte),5U);
		if(status == HAL_OK)
		{
			status = HAL_I2C_Master_Transmit(&mI2CHandle, sDeviceAddress, &(yHighAddress), 1U, 5U);
			if(status == HAL_OK)
			{
				status = HAL_I2C_Master_Receive(&mI2CHandle, sDeviceAddress, &yHighByte, sizeof(yHighByte),5U);
			}
		}
	}
	if(status == HAL_OK)
	{
		mYRawValue = (static_cast<UInt16>(yLowByte) | (static_cast<UInt16>(yHighByte) << 8U));
		return true;
	}
	else
	{
		return false;
	}
}
bool CMagnetometer::readZRawValue()
{
	UInt8 zLowByte		= 0x00U;
	UInt8 zHighByte		= 0x00U;
	UInt8 zLowAddress  	= sReadZLowValue;
	UInt8 zHighAddress 	= sReadZHighValue;

	HAL_StatusTypeDef status = HAL_OK;
	status = HAL_I2C_Master_Transmit(&mI2CHandle, sDeviceAddress, &(zLowAddress), 1U, 5U);
	if(status == HAL_OK)
	{
		status = HAL_I2C_Master_Receive(&mI2CHandle, sDeviceAddress, &zLowByte, sizeof(zLowByte), 5U);
		if(status == HAL_OK)
		{
			status = HAL_I2C_Master_Transmit(&mI2CHandle, sDeviceAddress, &(zHighAddress), 1U, 5U);
			if(status == HAL_OK)
			{
				status = HAL_I2C_Master_Receive(&mI2CHandle, sDeviceAddress, &zHighByte, sizeof(zHighByte), 5U);
			}
		}
	}
	if(status == HAL_OK)
	{
		mZRawValue = (static_cast<UInt16>(zLowByte) | (static_cast<UInt16>(zHighByte) << 8U));
		return true;
	}
	else
	{
		return false;
	}
}
bool CMagnetometer::getXRawValue(UInt16& rawValue)
{
	if(this->readXRawValue())
	{
		rawValue = mXRawValue;
		return true;
	}
	else
	{
		return false;
	}
}
bool CMagnetometer::getYRawValue(UInt16& rawValue)
{
	if(this->readYRawValue())
	{
		rawValue = mYRawValue;
		return true;
	}
	else
	{
		return false;
	}
}
bool CMagnetometer::getZRawValue(UInt16& rawValue)
{
	if(this->readZRawValue())
	{
		rawValue = mYRawValue;
		return true;
	}
	else
	{
		return false;
	}
}
