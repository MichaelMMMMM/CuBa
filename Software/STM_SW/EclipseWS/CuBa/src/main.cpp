/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#include "Global.h"
#include "SCommComponent.h"
#include "SControlComponent.h"
#include "SProxy.h"
#include "FreeRTOS.h"
#include "task.h"
#include "timers.h"

void vControlTask(void *pvParameters)
{
	//Call component to run
	SControlComponent::getInstance().run();
}
void vCommTask(void *pvParameters)
{
	//Call component to run
	SCommComponent::getInstance().run();
}

int main()
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               {
	xTaskCreate(vControlTask, "ControlTask", 1000, NULL, 2, NULL);
	xTaskCreate(vCommTask, "CommTask", 1000, NULL, 1, NULL);

	SProxy::getInstance();
	SCommComponent::getInstance();
	SControlComponent::getInstance();
	vTaskStartScheduler();
}
