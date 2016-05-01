/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#include "CControlFSM.h"
#include "CMessage.h"
#include "CControlActionHandler.h"

CControlFSM::CControlFSM(CControlActionHandler& actionHandler) :
								CBasicFSM(actionHandler,
										  ON_DEFAULT_INITIAL_FSM),
								mStateRunning(actionHandler)
{
	//Selfdispatch EV_INIT to enter actual Init-State
	CBasicFSM::dispatch(CMessage(EComponentID::CONTROL_COMP,
								 EComponentID::CONTROL_COMP,
								 EControlEvent::EV_INIT));
}
bool CControlFSM::dispatch(const CMessage& msg)
{
	bool eventConsumed = CBasicFSM::dispatch(msg);

	while(sQueueLength != 0U)
	{
		CMessage internalEvent = sInternalQueue;
		sQueueLength = 0U;
		CBasicFSM::dispatch(internalEvent);
	}
	return eventConsumed;
}
bool CControlFSM::onInitial(const CMessage& msg)
{
	bool eventConsumed = false;
	EControlEvent event = msg.getControlEvent();
	if(EControlEvent::EV_INIT == event)
	{
		mAction.onEntryConfiguration();
		mState = ON_CONFIGURATION;
		eventConsumed = true;
	}
	return eventConsumed;
}
bool CControlFSM::onConfiguration(const CMessage& msg)
{
	bool eventConsumed = false;
	EControlEvent event = msg.getControlEvent();
	if(EControlEvent::EV_START == event)
	{
		mAction.onExitConfiguration();
		mState = ON_RUNNING;
		mStateRunning.entry(CMessage(EComponentID::CONTROL_COMP,
									 EComponentID::CONTROL_COMP,
									 EControlEvent::EV_INIT));
		eventConsumed = true;
	}
	else if(EControlEvent::EV_SET_BALANCE_FLAG == event)
	{
		mAction.setBalanceFlag(static_cast<UInt8>(msg.getData()));
		eventConsumed = true;
	}
	else if(EControlEvent::EV_SET_JUMP_FLAG == event)
	{
		mAction.setJumpFlag(static_cast<UInt8>(msg.getData()));
		eventConsumed = true;
	}
	else if(EControlEvent::EV_SET_TRANSMIT_FLAG == event)
	{
		mAction.setTransmitFlag(static_cast<UInt8>(msg.getData()));
		eventConsumed = true;
	}
	return eventConsumed;
}
bool CControlFSM::onRunning(const CMessage& msg)
{
	bool eventConsumed = false;
	EControlEvent event = msg.getControlEvent();
	if(EControlEvent::EV_STOP == event)
	{
		mStateRunning.exit();
		mState = ON_CONFIGURATION;
		mAction.onEntryConfiguration();
		eventConsumed = true;
	}

	if(eventConsumed == false)
	{
		eventConsumed = mStateRunning.dispatch(msg);
	}
	return eventConsumed;
}
