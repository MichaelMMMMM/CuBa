#ifndef CSENSOR_H
#define CSENSOR_H
#include "Global.h"
#include "CAccelerometer.h"
#include "CGyro.h"
#include "CMagnetometer.h"
#include "stm32f4xx_hal.h"
#include "stm32f4xx_hal_rcc.h"
#include "stm32f4xx_hal_gpio.h"
#include "stm32f4xx_hal_i2c.h"

class CSensor
{
public:
	CSensor(I2C_TypeDef* i2cInstance);
	float getPhiK();
	float getPhiK_d();
	float getPhiK_dd();
public:
	UInt16 getAccelXRawValue();
	UInt16 getAccelYRawValue();
	UInt16 getAccelZRawValue();
	UInt16 getGyroXRawValue();
	UInt16 getGyroYRawValue();
	UInt16 getGyroZRawValue();
	UInt16 getMagXRawValue();
	UInt16 getMagYRawValue();
	UInt16 getMagZRawValue();
public:
	CSensor(const CSensor&) = delete;
	CSensor& operator=(const CSensor&) = delete;
	~CSensor() = default;
private:
	I2C_HandleTypeDef mI2CHandle;
	CAccelerometer mAccelerometer;
	CGyro mGyro;
	CMagnetometer mMagnetometer;
};

#endif
