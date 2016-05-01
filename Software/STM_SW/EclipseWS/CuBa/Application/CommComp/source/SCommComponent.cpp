/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#include "SCommComponent.h"
#include "TUSART.h"
#include "ERegister.h"
#include "ECommEvent.h"
#include "FreeRTOS.h"
#include <new>

SCommComponent* SCommComponent::sInstance = nullptr;

SCommComponent::SCommComponent() : AComponent(EComponentID::COMM_COMP),
								   mUSART(),
								   mRxBuffer(mUSART),
								   mTxBuffer(mUSART) {}
SCommComponent& SCommComponent::getInstance()
{
	if(sInstance == nullptr)
	{
		sInstance = new(pvPortMalloc(sizeof(SCommComponent)))SCommComponent();
	}
	return *sInstance;
}
bool SCommComponent::dispatch(const CMessage& msg)
{
	bool eventConsumed = false;
	ECommEvent event = msg.getCommEvent();
	if(ECommEvent::EV_COMM_MSG_RECEIVED == event)
	{
		mRxBuffer.proccessReceivedBuffer();
		eventConsumed = true;
	}
	else if(ECommEvent::EV_TRANSMIT_STATE_ENTRY == event)
	{
		UInt8 buffer[] = { static_cast<UInt8>(msg.getReceiver()),
						   static_cast<UInt8>(msg.getCommEvent()),
						   static_cast<UInt8>(msg.getData()),
						   0U };
		mTxBuffer.writeMessage(buffer);
		eventConsumed = true;
	}
	return eventConsumed;
}
void SCommComponent::onUSARTIRQ()
{
	if(mUSART.checkRXIRQ())
	{
		mRxBuffer.onRXIRQ();
	}
	if(mUSART.checkTXIRQ())
	{
		mTxBuffer.onTXIRQ();
	}
}
