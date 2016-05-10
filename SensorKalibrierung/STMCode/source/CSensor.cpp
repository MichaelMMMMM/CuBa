#include "CSensor.h"

CSensor::CSensor(I2C_TypeDef* i2cInstance) : mAccelerometer(mI2CHandle),
											 mGyro(mI2CHandle),
											 mMagnetometer(mI2CHandle)
{
	if(i2cInstance == I2C1)
	{
		mI2CHandle.Instance = I2C1;

		__HAL_RCC_GPIOB_CLK_ENABLE();
		__HAL_RCC_I2C1_CLK_ENABLE();

		GPIO_InitTypeDef initPort;
		initPort.Pin 		= GPIO_PIN_6 | GPIO_PIN_7;
		initPort.Mode 		= GPIO_MODE_AF_OD;
		initPort.Pull 		= GPIO_PULLUP;
		initPort.Speed 		= GPIO_SPEED_FREQ_VERY_HIGH;
		initPort.Alternate 	= GPIO_AF4_I2C1;
		HAL_GPIO_Init(GPIOB, &initPort);

		mI2CHandle.Init.ClockSpeed 		= 400000U;
		mI2CHandle.Init.DutyCycle 		= I2C_DUTYCYCLE_2;
		mI2CHandle.Init.OwnAddress2 	= 0x00U;
		mI2CHandle.Init.OwnAddress1 	= 0x00U;
		mI2CHandle.Init.AddressingMode 	= I2C_ADDRESSINGMODE_7BIT;
		mI2CHandle.Init.DualAddressMode = I2C_DUALADDRESS_DISABLE;
		mI2CHandle.Init.GeneralCallMode = I2C_GENERALCALL_DISABLE;
		mI2CHandle.Init.NoStretchMode 	= I2C_NOSTRETCH_DISABLE;
		HAL_I2C_Init(&mI2CHandle);
	}
	else if(i2cInstance == I2C2)
	{
		mI2CHandle.Instance = I2C2;

		__HAL_RCC_GPIOB_CLK_ENABLE();
		__HAL_RCC_I2C2_CLK_ENABLE();

		GPIO_InitTypeDef initPort;
		initPort.Pin 		= GPIO_PIN_10 | GPIO_PIN_11;
		initPort.Mode		= GPIO_MODE_AF_OD;
		initPort.Pull		= GPIO_PULLUP;
		initPort.Speed		= GPIO_SPEED_FREQ_VERY_HIGH;
		initPort.Alternate	= GPIO_AF4_I2C2;
		HAL_GPIO_Init(GPIOB, &initPort);

		mI2CHandle.Init.ClockSpeed		= 400000U;
		mI2CHandle.Init.DutyCycle		= I2C_DUTYCYCLE_2;
		mI2CHandle.Init.OwnAddress2		= 0x00U;
		mI2CHandle.Init.OwnAddress1		= 0x00U;
		mI2CHandle.Init.AddressingMode	= I2C_ADDRESSINGMODE_7BIT;
		mI2CHandle.Init.DualAddressMode = I2C_DUALADDRESS_DISABLE;
		mI2CHandle.Init.GeneralCallMode = I2C_GENERALCALL_DISABLE;
		mI2CHandle.Init.NoStretchMode   = I2C_NOSTRETCH_DISABLE;
		HAL_I2C_Init(&mI2CHandle);
	}
	mAccelerometer.init();
	mMagnetometer.init();
	mGyro.init();
}
UInt16 CSensor::getAccelXRawValue()
{
	return mAccelerometer.getXRawValue();
}
UInt16 CSensor::getAccelYRawValue()
{
	return mAccelerometer.getYRawValue();
}
UInt16 CSensor::getAccelZRawValue()
{
	return mAccelerometer.getZRawValue();
}
UInt16 CSensor::getGyroXRawValue()
{
	return mGyro.getXRawValue();
}
UInt16 CSensor::getGyroYRawValue()
{
	return mGyro.getYRawValue();
}
UInt16 CSensor::getGyroZRawValue()
{
	return mGyro.getZRawValue();
}
UInt16 CSensor::getMagXRawValue()
{
	return mMagnetometer.getXRawValue();
}
UInt16 CSensor::getMagYRawValue()
{
	return mMagnetometer.getYRawValue();
}
UInt16 CSensor::getMagZRawValue()
{
	return mMagnetometer.getZRawValue();
}
