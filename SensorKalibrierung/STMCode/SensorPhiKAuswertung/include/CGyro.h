// Autor: Michael Meindl
// Datum: 3.5.2016
// Die Klasse CGyroinitialisiert ein Gyroskop
// über I2C und gibt dessen Rohwerte in X-, Y- und Z-Richtung aus
#ifndef CGYRO_H
#define CGYRO_H
#include "Global.h"
#include "stm32f4xx_hal.h"
#include "stm32f4xx_hal_rcc.h"
#include "stm32f4xx_hal_gpio.h"
#include "stm32f4xx_hal_i2c.h"

class CGyro
{
public:
	CGyro(I2C_HandleTypeDef& handle);
	bool init();
	bool getXRawValue(UInt16& rawValue);
	bool getYRawValue(UInt16& rawValue);
	bool getZRawValue(UInt16& rawValue);
private:
	bool readXRawValue();
	bool readYRawValue();
	bool readZRawValue();
public:
	CGyro() = delete;
	CGyro(const CGyro&) = delete;
	CGyro& operator=(const CGyro&) = delete;
	~CGyro() = default;
private:
	UInt16 mXRawValue;
	UInt16 mYRawValue;
	UInt16 mZRawValue;
	I2C_HandleTypeDef& mI2CHandle;

	static constexpr UInt8 sDeviceAddress 	= 0xD6U;
	static constexpr UInt8 sReadXLowValue	= 0x28U;
	static constexpr UInt8 sReadXHighValue	= 0x29U;
	static constexpr UInt8 sReadYLowValue	= 0x2AU;
	static constexpr UInt8 sReadYHighValue	= 0x2BU;
	static constexpr UInt8 sReadZLowValue	= 0x2CU;
	static constexpr UInt8 sReadZHighValue	= 0x2DU;

	static constexpr UInt8 sCTRL_REG1_G		= 0x20U;
	static constexpr UInt8 sCTRL_REG5_G		= 0x24U;
};


#endif
