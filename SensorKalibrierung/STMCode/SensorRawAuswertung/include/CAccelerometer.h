#ifndef CACCELEROMETER_H
#define CACCELEROMETER_H
#include "Global.h"
#include "stm32f4xx_hal.h"
#include "stm32f4xx_hal_rcc.h"
#include "stm32f4xx_hal_gpio.h"
#include "stm32f4xx_hal_i2c.h"

class CAccelerometer
{
public:
	CAccelerometer(I2C_HandleTypeDef& handle);
	void init();
	UInt16 getXRawValue();
	UInt16 getYRawValue();
	UInt16 getZRawValue();
private:
	void readXRawValue();
	void readYRawValue();
	void readZRawValue();
public:
	CAccelerometer() = delete;
	CAccelerometer(const CAccelerometer&) = delete;
	CAccelerometer& operator=(const CAccelerometer&) = delete;
	~CAccelerometer() = default;
private:
	UInt16 mXRawValue;
	UInt16 mYRawValue;
	UInt16 mZRawValue;
	I2C_HandleTypeDef& mI2CHandle;

	static constexpr UInt8 sDeviceAddress 	= 0x3BU;
	static constexpr UInt8 sReadXLowValue	= 0x28U;
	static constexpr UInt8 sReadXHighValue	= 0x29U;
	static constexpr UInt8 sReadYLowValue	= 0x2AU;
	static constexpr UInt8 sReadYHighValue	= 0x2BU;
	static constexpr UInt8 sReadZLowValue	= 0x2CU;
	static constexpr UInt8 sReadZHighValue	= 0x2DU;

	static constexpr UInt8 sCTRL_REG1_XM	= 0x20U;
	static constexpr UInt8 sCTRL_REG5_XM	= 0x24U;
};

#endif
