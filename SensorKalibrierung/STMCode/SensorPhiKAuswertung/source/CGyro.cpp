#include <EBit.h>
#include "CGyro.h"

CGyro::CGyro(I2C_HandleTypeDef& handle) :
							mXRawValue(0U),
							mYRawValue(0U),
							mZRawValue(0U),
							mI2CHandle(handle) {}
bool CGyro::init()
{
	UInt8 CTRL_REG1_Address = sCTRL_REG1_G;
	UInt8 CTRL_REG1_Value	= 0x0FU;
	UInt8 txBuffer[] = { CTRL_REG1_Address, CTRL_REG1_Value };

	HAL_StatusTypeDef status = HAL_I2C_Master_Transmit(&mI2CHandle, EBit::BIT0 | sDeviceAddress, txBuffer, 2U, 5U);
	return status == HAL_OK;
}
bool CGyro::readXRawValue()
{
	UInt8 xLowByte		= 0U;
	UInt8 xHighByte		= 0U;
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
bool CGyro::readYRawValue()
{
	UInt8 yLowByte		= 0U;
	UInt8 yHighByte		= 0U;
	UInt8 yLowAddress  	= sReadYLowValue;
	UInt8 yHighAddress 	= sReadYHighValue;

	HAL_StatusTypeDef status = HAL_OK;
	status = HAL_I2C_Master_Transmit(&mI2CHandle, sDeviceAddress, &(yLowAddress), 1U, 5U);
	if(status == HAL_OK)
	{
		status = HAL_I2C_Master_Receive(&mI2CHandle, sDeviceAddress, &yLowByte, sizeof(yLowByte), 5U);
		if(status == HAL_OK)
		{
			status = HAL_I2C_Master_Transmit(&mI2CHandle, sDeviceAddress, &(yHighAddress), 1U, 5U);
			if(status == HAL_OK)
			{
				status = HAL_I2C_Master_Receive(&mI2CHandle, sDeviceAddress, &yHighByte, sizeof(yHighByte), 5U);
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
bool CGyro::readZRawValue()
{
	UInt8 zLowByte		= 0U;
	UInt8 zHighByte		= 0U;
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
bool CGyro::getXRawValue(UInt16& rawValue)
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
bool CGyro::getYRawValue(UInt16& rawValue)
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
bool CGyro::getZRawValue(UInt16& rawValue)
{
	if(this->readZRawValue())
	{
		rawValue = mZRawValue;
		return true;
	}
	else
	{
		return false;
	}
}
