/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#include "CStateRunning.h"
#include "CMessage.h"
#include "CControlActionHandler.h"

CStateRunning::CStateRunning(CControlActionHandler& actionHandler) :
									CBasicFSM(actionHandler, ON_DEFAULT_INITIAL_RUNNING),
									mStateJump(actionHandler) {}
bool CStateRunning::onInitial(const CMessage& msg)
{
	bool eventConsumed = false;
	EControlEvent event = msg.getControlEvent();
	if(EControlEvent::EV_INIT == event)
	{
		mAction.onEntryRunning();
		mAction.onEntryIdle();
		mState = ON_IDLE;
		eventConsumed = true;
	}
	return eventConsumed;
}
bool CStateRunning::onIdle(const CMessage& msg)
{
	bool eventConsumed = false;
	EControlEvent event = msg.getControlEvent();
	if(EControlEvent::EV_EXIT == event)
	{
		mAction.onExitIdle();
		mAction.onExitRunning();
		mState = ON_DEFAULT_INITIAL_RUNNING;
		eventConsumed = true;
	}
	else if((EControlEvent::EV_PHIK_IN_BALANCEAREA == event) &&
			 mAction.getBalanceFlag())
	{
		mAction.onExitIdle();
		mState = ON_BALANCE;
		mAction.onEntryBalance();
		eventConsumed = true;
	}
	else if((EControlEvent::EV_JUMP == event) &&
			mAction.getJumpFlag())
	{
		mAction.onExitIdle();
		mState = ON_JUMP;
		mStateJump.entry(CMessage(EComponentID::CONTROL_COMP,
								  EComponentID::CONTROL_COMP,
								  EControlEvent::EV_INIT));
		eventConsumed = true;
	}
	else if(EControlEvent::EV_TIMER == event)
	{
		if(mAction.phiK_inBalanceArea())
		{
			sInternalQueue = CMessage(EComponentID::CONTROL_COMP,
									  EComponentID::CONTROL_COMP,
									  EControlEvent::EV_PHIK_IN_BALANCEAREA);

			sQueueLength++;
		}
		eventConsumed = true;
	}
	return eventConsumed;
}
bool CStateRunning::onBalance(const CMessage& msg)
{
	bool eventConsumed = false;
	EControlEvent event = msg.getControlEvent();
	if(EControlEvent::EV_EXIT == event)
	{
		mAction.onExitBalance();
		mAction.onExitRunning();
		mState = ON_DEFAULT_INITIAL_RUNNING;
		eventConsumed = true;
	}
	else if(EControlEvent::EV_PHIK_NOT_IN_BALANCEAREA == event)
	{
		mAction.onExitBalance();
		mState = ON_IDLE;
		mAction.onEntryIdle();
		eventConsumed = true;
	}
	else if(EControlEvent::EV_TIMER == event)
	{
		if(mAction.phiK_inBalanceArea())
		{
			mAction.controlIteration();
		}
		else
		{
			sInternalQueue = CMessage(EComponentID::CONTROL_COMP,
									  EComponentID::CONTROL_COMP,
									  EControlEvent::EV_PHIK_NOT_IN_BALANCEAREA);
			sQueueLength++;
		}
		eventConsumed = true;
	}
	return eventConsumed;
}
bool CStateRunning::onJump(const CMessage& msg)
{
	bool eventConsumed = false;
	EControlEvent event = msg.getControlEvent();
	if(EControlEvent::EV_EXIT == event)
	{
		mStateJump.exit();
		mAction.onExitRunning();
		mState = ON_DEFAULT_INITIAL_RUNNING;
		eventConsumed = true;
	}
	else if(EControlEvent::EV_BRAKE == event)
	{
		mStateJump.exit();
		mState = ON_IDLE;
		mAction.onEntryIdle();
		eventConsumed = true;
	}

	if(eventConsumed == false)
	{
		eventConsumed = mStateJump.dispatch(msg);
	}

	return eventConsumed;
}
