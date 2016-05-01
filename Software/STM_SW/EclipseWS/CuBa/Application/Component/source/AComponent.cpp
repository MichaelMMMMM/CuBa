/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#include "AComponent.h"
#include "Config.h"
#include "CMessage.h"

AComponent::AComponent(EComponentID id) : mID(id)
{
	mQueue = xQueueCreate(EConfig::COMPONENT_QUEUE_SIZE,
						  sizeof(CMessage));
}
void AComponent::run(void)
{
	UInt8 receiveBuffer[sizeof(CMessage)] {0U};
	CMessage* receivedMessage = reinterpret_cast<CMessage*>(receiveBuffer);

	while(true)
	{
		//This should always be evaluated as true
		//The Task only wakes up once there is data to receive
		if(pdPASS == xQueueReceive(mQueue,
								   static_cast<void*>(receivedMessage),
								   portMAX_DELAY))
		{
			this->dispatch(*receivedMessage);
		}
	}
}
AComponent::~AComponent(void)
{
	;
}
