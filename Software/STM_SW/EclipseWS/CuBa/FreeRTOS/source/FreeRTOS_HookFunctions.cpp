#include "FreeRTOS.h"
#include "task.h"
#include "SSoftTimer.h"

extern "C"
{
void vApplicationStackOverflowHook(TaskHandle_t xTask, char *pcTaskName);
void vApplicationStackOverflowHook(TaskHandle_t xTask, char *pcTaskName)
{

}

void vApplicationTickHook(void);
void vApplicationTickHook( void )
{
	SSoftTimer::getInstance().onSysTick();
}
}
