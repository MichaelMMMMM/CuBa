#include <SensorConfiguration.h>
#include "CSensor.h"
#include "math.h"

CSensor::CSensor() : mAcc1(mI2C1_Handle),
					 mAcc2(mI2C2_Handle),
					 mGyro1(mI2C1_Handle)
{
	mI2C1_Handle.Instance = I2C1;
	__HAL_RCC_GPIOB_CLK_ENABLE();
	__HAL_RCC_I2C1_CLK_ENABLE();

	GPIO_InitTypeDef initPort1;
	initPort1.Pin 			= GPIO_PIN_6 | GPIO_PIN_7;
	initPort1.Mode 			= GPIO_MODE_AF_OD;
	initPort1.Pull 			= GPIO_PULLUP;
	initPort1.Speed 		= GPIO_SPEED_FREQ_VERY_HIGH;
	initPort1.Alternate 	= GPIO_AF4_I2C1;
	HAL_GPIO_Init(GPIOB, &initPort1);

	mI2C1_Handle.Init.ClockSpeed 		= 400000U;
	mI2C1_Handle.Init.DutyCycle 		= I2C_DUTYCYCLE_2;
	mI2C1_Handle.Init.OwnAddress2 		= 0x00U;
	mI2C1_Handle.Init.OwnAddress1 		= 0x00U;
	mI2C1_Handle.Init.AddressingMode 	= I2C_ADDRESSINGMODE_7BIT;
	mI2C1_Handle.Init.DualAddressMode 	= I2C_DUALADDRESS_DISABLE;
	mI2C1_Handle.Init.GeneralCallMode 	= I2C_GENERALCALL_DISABLE;
	mI2C1_Handle.Init.NoStretchMode 	= I2C_NOSTRETCH_DISABLE;
	HAL_I2C_Init(&mI2C1_Handle);

	mI2C2_Handle.Instance = I2C2;
	__HAL_RCC_GPIOB_CLK_ENABLE();
	__HAL_RCC_I2C2_CLK_ENABLE();

	GPIO_InitTypeDef initPort2;
	initPort2.Pin 		= GPIO_PIN_10 | GPIO_PIN_11;
	initPort2.Mode		= GPIO_MODE_AF_OD;
	initPort2.Pull		= GPIO_PULLUP;
	initPort2.Speed		= GPIO_SPEED_FREQ_VERY_HIGH;
	initPort2.Alternate	= GPIO_AF4_I2C2;
	HAL_GPIO_Init(GPIOB, &initPort2);

	mI2C2_Handle.Init.ClockSpeed		= 400000U;
	mI2C2_Handle.Init.DutyCycle			= I2C_DUTYCYCLE_2;
	mI2C2_Handle.Init.OwnAddress2		= 0x00U;
	mI2C2_Handle.Init.OwnAddress1		= 0x00U;
	mI2C2_Handle.Init.AddressingMode	= I2C_ADDRESSINGMODE_7BIT;
	mI2C2_Handle.Init.DualAddressMode 	= I2C_DUALADDRESS_DISABLE;
	mI2C2_Handle.Init.GeneralCallMode 	= I2C_GENERALCALL_DISABLE;
	mI2C2_Handle.Init.NoStretchMode   	= I2C_NOSTRETCH_DISABLE;
	HAL_I2C_Init(&mI2C2_Handle);

	mAcc1.init();
	mAcc2.init();
	mGyro1.init();
}
bool CSensor::getPhiKValues(float& phiK, float& phiK_d, float& phiK_dd)
{
	bool readoutSuccess = false;
	UInt16 accX1Raw  = 0U;
	UInt16 accY1Raw  = 0U;
	UInt16 accZ1Raw  = 0U;
	UInt16 accX2Raw  = 0U;
	UInt16 accY2Raw  = 0U;
	UInt16 accZ2Raw  = 0U;
	UInt16 gyroZ1Raw = 0U;

	if(mAcc1.getXRawValue(accX1Raw) &&
	   mAcc1.getYRawValue(accY1Raw) &&
	   mAcc1.getZRawValue(accZ1Raw) &&
	   mAcc2.getXRawValue(accX2Raw) &&
	   mAcc2.getYRawValue(accY2Raw) &&
	   mAcc2.getZRawValue(accZ2Raw) &&
	   mGyro1.getZRawValue(gyroZ1Raw))
	{
		readoutSuccess = true;

		float accX1 = static_cast<float>(-static_cast<Int16>(accX1Raw) + SensorConfig::accX1Offset);
		float accY1 = static_cast<float>(-static_cast<Int16>(accY1Raw) + SensorConfig::accY1Offset);
		float accZ1 = static_cast<float>(-static_cast<Int16>(accZ1Raw) + SensorConfig::accZ1Offset);
		float accX2 = static_cast<float>(-static_cast<Int16>(accX2Raw) + SensorConfig::accX2Offset);
		float accY2 = static_cast<float>(-static_cast<Int16>(accY2Raw) + SensorConfig::accY2Offset);
		float accZ2 = static_cast<float>(-static_cast<Int16>(accZ2Raw) + SensorConfig::accZ2Offset);
		float gyrZ1 = static_cast<float>(static_cast<Int16>(gyroZ1Raw) + SensorConfig::gyroZ1Offset);

		phiK = -atan2(accX1 - SensorConfig::mu * accX2, accY1 - SensorConfig::mu * accY2);
		float thetaK = asin((accZ1 - SensorConfig::mu * accZ2) / (SensorConfig::g * (1 - SensorConfig::mu)));

		phiK_d = gyrZ1 * SensorConfig::degToRadFactor * SensorConfig::degToRadFactor;

		float x1G = accX1 * SensorConfig::accIntToGFactor;
		constexpr float denominator = SensorConfig::r_1 / SensorConfig::g;
		phiK_dd = (x1G - sin(phiK)) / (denominator);
	}

	return readoutSuccess;
}
