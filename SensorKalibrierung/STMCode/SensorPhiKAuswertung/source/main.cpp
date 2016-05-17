//Autor : Michael Meindl
//Datum : 17.05.2016
//Anwendung fragt die aktuellen Sensorwerte aus, berechnet die Größen phiK, phiK_d, phiK_dd
//und gibt diese über die serielle Schnitstelle aus
#include "CSensor.h"
#include "Global.h"
#include "stm32f4xx_hal.h"
#include "stm32f4xx_hal_i2c.h"
#include "TUSART.h"

static volatile UInt32 counter = 0U;

extern "C"
{
void SysTick_Handler(void)
{
	HAL_IncTick();
	counter++;
}
}

int main()
{
	TUSART<ERegister::rUSART3> myUSART;
	CSensor mySensor;
	union
	{
		UInt8 phiK_Raw[4];
		UInt32 phiK32;
		float phiK = 0.0;
	};
	union
	{
		UInt8 phiK_d_Raw[4];
		UInt32 phiK_d_32;
		float phiK_d = 0.0;
	};
	union
	{
		UInt8 phiK_dd_Raw[4];
		UInt32 phiK_dd_32;
		float phiK_dd = 0.0;
	};
	while (1)
	{
		if(counter >= 5U)
		{
			counter = 0U;
			mySensor.getPhiKValues(phiK, phiK_d, phiK_dd);

			myUSART.sendByte(phiK_Raw[0]);
			myUSART.blockSendByte(phiK_Raw[1]);
			myUSART.blockSendByte(phiK_Raw[2]);
			myUSART.blockSendByte(phiK_Raw[3]);

			myUSART.blockSendByte(phiK_d_Raw[0]);
			myUSART.blockSendByte(phiK_d_Raw[1]);
			myUSART.blockSendByte(phiK_d_Raw[2]);
			myUSART.blockSendByte(phiK_d_Raw[3]);

			myUSART.blockSendByte(phiK_dd_Raw[0]);
			myUSART.blockSendByte(phiK_dd_Raw[1]);
			myUSART.blockSendByte(phiK_dd_Raw[2]);
			myUSART.blockSendByte(phiK_dd_Raw[3]);
		}
	}
}
