/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#include "SControlComponent.h"
#include "CControlActionHandler.h"
#include "CControlFSM.h"
#include "FreeRTOS.h"
#include <new>


static CControlActionHandler actionHandler;		//Very private ActionHandler for the FSM
SControlComponent* SControlComponent::sInstance = nullptr;
SControlComponent::SControlComponent() : AComponent(EComponentID::CONTROL_COMP),
										 mFSM(actionHandler) {}

SControlComponent& SControlComponent::getInstance()
{
	if(sInstance == nullptr)
	{
		sInstance = new(pvPortMalloc(sizeof(SControlComponent)))SControlComponent();
	}
	return *sInstance;
}

bool SControlComponent::dispatch(const CMessage& msg)
{
	return mFSM.dispatch(msg);
}
