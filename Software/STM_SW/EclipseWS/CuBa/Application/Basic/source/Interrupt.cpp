/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#include "SCommComponent.h"

extern "C"
{

void USART1_IRQHandler(void)
{
	SCommComponent::getInstance().onUSARTIRQ();
}

}
