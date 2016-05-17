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
	CSensor();
	bool getPhiKValues(float& phiK, float& phiK_d, float& phiK_dd);
public:
	CSensor(const CSensor&) = delete;
	CSensor& operator=(const CSensor&) = delete;
	~CSensor() = default;
private:
	I2C_HandleTypeDef mI2C1_Handle;
	I2C_HandleTypeDef mI2C2_Handle;
	CAccelerometer mAcc1;
	CAccelerometer mAcc2;
	CGyro mGyro1;
};

#endif
