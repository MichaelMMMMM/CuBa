#include <CSensor.h>
#include "Global.h"
#include "stm32f4xx_hal.h"
#include "stm32f4xx_hal_i2c.h"
#include "TUSART.h"

#define SENSOR_1
//#define SENSOR_2

volatile UInt32 counter = 0U;
volatile bool overrun = false;

extern "C"
{
	void SysTick_Handler(void)
	{
		HAL_IncTick();
		counter++;
	}
}


void main()
{
	TUSART<ERegister::rUSART3> myUSART;
	#ifdef SENSOR_1
	CSensor firstSensor(I2C1);
	union
	{
		UInt16 sensor1Data[9];
		UInt8  sensor1Raw[18];
	};
	#endif
	#ifdef SENSOR_2
	CSensor secondSensor(I2C2);
	union
	{
		UInt16 sensor2Data[9];
		UInt8  sensor2Raw[18] = {0U};
	};
	#endif


	while (1)
	{
	   if(counter > 4U)
	   {
		   counter = 0U;
		   #ifdef SENSOR_1
		   sensor1Data[0] = firstSensor.getAccelXRawValue();
		   sensor1Data[1] = firstSensor.getAccelYRawValue();
		   sensor1Data[2] = firstSensor.getAccelZRawValue();
		   sensor1Data[3] = firstSensor.getGyroXRawValue();
		   sensor1Data[4] = firstSensor.getGyroYRawValue();
		   sensor1Data[5] = firstSensor.getGyroZRawValue();
		   sensor1Data[6] = firstSensor.getMagXRawValue();
		   sensor1Data[7] = firstSensor.getMagYRawValue();
		   sensor1Data[8] = firstSensor.getMagZRawValue();
		   #endif

		   #ifdef SENSOR_2
		   sensor2Data[0] = secondSensor.getAccelXRawValue();
		   sensor2Data[1] = secondSensor.getAccelYRawValue();
		   sensor2Data[2] = secondSensor.getAccelZRawValue();
		   sensor2Data[3] = secondSensor.getGyroXRawValue();
		   sensor2Data[4] = secondSensor.getGyroYRawValue();
		   sensor2Data[5] = secondSensor.getGyroZRawValue();
		   sensor2Data[6] = secondSensor.getMagXRawValue();
		   sensor2Data[7] = secondSensor.getMagYRawValue();
		   sensor2Data[8] = secondSensor.getMagZRawValue();
		   #endif

		   #ifdef SENSOR_1
		   myUSART.sendByte(sensor1Raw[0U]);
		   for(UInt32 index = 1U; index < 18U; index++)
		   {
			   myUSART.blockSendByte(sensor1Raw[index]);
		   }
		   #endif
		   #ifdef SENSOR_2
		   for(UInt32 index = 0U; index < 18U; index++)
		   {
			   myUSART.blockSendByte(sensor2Raw[index]);
		   }
		   #endif
	   }
	}
}
