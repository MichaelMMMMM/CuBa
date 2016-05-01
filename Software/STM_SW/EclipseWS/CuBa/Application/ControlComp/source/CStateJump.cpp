/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#include "CStateJump.h"
#include "CMessage.h"
#include "CControlActionHandler.h"

CStateJump::CStateJump(CControlActionHandler& actionHandler) :
							CBasicFSM(actionHandler, ON_DEFAULT_INITIAL_JUMP) {}
bool CStateJump::onInitial(const CMessage& msg)
{
	bool eventConsumed = false;
	EControlEvent event = msg.getControlEvent();
	if(EControlEvent::EV_INIT == event)
	{
		mAction.onEntryJump();
		mAction.onEntryWaiting();
		mState = ON_WAITING;
		eventConsumed = true;
	}

	return eventConsumed;
}
bool CStateJump::onWaiting(const CMessage& msg)
{
	bool eventConsumed = false;
	EControlEvent event = msg.getControlEvent();
	if(EControlEvent::EV_EXIT == event)
	{
		mAction.onExitWaiting();
		mAction.onExitJump();
		mState = ON_DEFAULT_INITIAL_JUMP;
		eventConsumed = true;
	}
	else if(EControlEvent::EV_RESTING == event)
	{
		mAction.onExitJump();
		mState = ON_ACCELERATE;
		mAction.onEntryAccelerate();
		eventConsumed = true;
	}
	else if(EControlEvent::EV_TIMER == event)
	{
		if(mAction.cubeIsResting())
		{
			sInternalQueue = CMessage(EComponentID::CONTROL_COMP,
									  EComponentID::CONTROL_COMP,
									  EControlEvent::EV_RESTING);
			sQueueLength++;
		}
	}
	return eventConsumed;
}
bool CStateJump::onAccelerate(const CMessage& msg)
{
	bool eventConsumed = false;
	EControlEvent event = msg.getControlEvent();
	if(EControlEvent::EV_EXIT == event)
	{
		mAction.onExitAccelerate();
		mAction.onExitJump();
		mState = ON_DEFAULT_INITIAL_JUMP;
		eventConsumed = true;
	}
	else if(EControlEvent::EV_NOT_RESTING == event)
	{
		mAction.onExitJump();
		mState = ON_WAITING;
		mAction.onEntryWaiting();
		eventConsumed = true;
	}
	else if(EControlEvent::EV_JUMP_VELOCITY_REACHED == event)
	{
		mAction.onExitJump();
		mState = ON_BRAKE;
		mAction.onEntryBrake();
		eventConsumed = true;
	}
	else if(EControlEvent::EV_TIMER == event)
	{
		if(mAction.cubeIsResting())
		{
			if(mAction.jumpVelocityReached())
			{
				sInternalQueue = CMessage(EComponentID::CONTROL_COMP,
										  EComponentID::CONTROL_COMP,
										  EControlEvent::EV_JUMP_VELOCITY_REACHED);
				sQueueLength++;
			}
		}
		else
		{
			sInternalQueue = CMessage(EComponentID::CONTROL_COMP,
									  EComponentID::CONTROL_COMP,
									  EControlEvent::EV_NOT_RESTING);
			sQueueLength++;
		}
		eventConsumed = true;
	}
	return eventConsumed;
}
bool CStateJump::onBrake(const CMessage& msg)
{
	bool eventConsumed = false;
	EControlEvent event = msg.getControlEvent();
	if(EControlEvent::EV_EXIT == event)
	{
		mAction.onExitBrake();
		mAction.onExitJump();
		mState = ON_DEFAULT_INITIAL_JUMP;
		eventConsumed = true;
	}
	else if(EControlEvent::EV_TIMER == event)
	{
		if(mAction.breakingFinished())
		{
			sInternalQueue = CMessage(EComponentID::CONTROL_COMP,
									  EComponentID::CONTROL_COMP,
									  EControlEvent::EV_BRAKE);
			sQueueLength++;
		}
		eventConsumed = true;
	}
	return eventConsumed;
}
