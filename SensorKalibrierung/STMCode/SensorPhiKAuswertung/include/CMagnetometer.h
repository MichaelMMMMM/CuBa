#ifndef CMAGNETOMETER_H
#define CMAGNETOMETER_H
#include "Global.h"
#include "stm32f4xx_hal.h"
#include "stm32f4xx_hal_rcc.h"
#include "stm32f4xx_hal_gpio.h"
#include "stm32f4xx_hal_i2c.h"

class CMagnetometer
{
public:
	CMagnetometer(I2C_HandleTypeDef& handle);
	bool init();
	bool getXRawValue(UInt16& rawValue);
	bool getYRawValue(UInt16& rawValue);
	bool getZRawValue(UInt16& rawValue);
private:
	bool readXRawValue();
	bool readYRawValue();
	bool readZRawValue();
public:
	CMagnetometer() = delete;
	CMagnetometer(const CMagnetometer&) = delete;
	CMagnetometer& operator=(const CMagnetometer&) = delete;
	~CMagnetometer() = default;
private:
	UInt16 mXRawValue;
	UInt16 mYRawValue;
	UInt16 mZRawValue;
	I2C_HandleTypeDef& mI2CHandle;

	static constexpr UInt8 sDeviceAddress 	= 0x3BU;
	static constexpr UInt8 sReadXLowValue	= 0x08U;
	static constexpr UInt8 sReadXHighValue	= 0x09U;
	static constexpr UInt8 sReadYLowValue	= 0x0AU;
	static constexpr UInt8 sReadYHighValue	= 0x0BU;
	static constexpr UInt8 sReadZLowValue	= 0x0CU;
	static constexpr UInt8 sReadZHighValue	= 0x0DU;
	static constexpr UInt8 sCTRL_REG0_XM	= 0x1FU;
	static constexpr UInt8 sCTRL_REG5_XM	= 0x24U;
	static constexpr UInt8 sCTRL_REG6_XM	= 0x25U;
	static constexpr UInt8 sCTRL_REG7_XM 	= 0x26U;
	static constexpr UInt8 sOFFSET_X_L_M	= 0x16U;
	static constexpr UInt8 sOFFSET_X_H_M	= 0x17U;
};

#endif
