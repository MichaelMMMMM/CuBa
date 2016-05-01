/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#include "CControlActionHandler.h"
#include "Config.h"
#include "SProxy.h"

CControlActionHandler::CControlActionHandler() : mJumpFlag(false),
												 mBalanceFlag(false),
												 mTransmitFlag(false),
												 mPhiK(0U),
												 mPhiK_d(0U),
												 mPhiK_dd(0U),
												 mPhiR_d(0U),
												 mSoftTimer(SSoftTimer::getInstance()) {}
void CControlActionHandler::onEntryConfiguration()
{
	if(mTransmitFlag == true)
	{
		SProxy::getInstance().transmitStateEntry(EComponentID::CONTROL_COMP,
												 EState::STATE_CONFIFURATION);
	}
}
void CControlActionHandler::onExitConfiguration()
{
	;
}
void CControlActionHandler::onEntryRunning()
{
	mSoftTimer.setPeriod(EConfig::TIMERPERIOD_IDLE);
	mSoftTimer.start();
	if(mTransmitFlag == true)
	{
		SProxy::getInstance().transmitStateEntry(EComponentID::CONTROL_COMP,
												 EState::STATE_RUNNING);
	}
}
void CControlActionHandler::onExitRunning()
{
	mSoftTimer.stop();
}
void CControlActionHandler::onEntryIdle()
{
	if(mTransmitFlag == true)
	{
		SProxy::getInstance().transmitStateEntry(EComponentID::CONTROL_COMP,
												 EState::STATE_IDLE);
	}
}
void CControlActionHandler::onEntryBalance()
{
	mSoftTimer.setPeriod(EConfig::TIMERPERIOD_BALANCE);
	if(mTransmitFlag == true)
	{
		SProxy::getInstance().transmitStateEntry(EComponentID::CONTROL_COMP,
												 EState::STATE_BALANCE);
	}
}
void CControlActionHandler::onExitBalance()
{
	;
}
void CControlActionHandler::onEntryJump()
{
	mSoftTimer.setPeriod(EConfig::TIMERPERIOD_JUMP);
	if(mTransmitFlag == true)
	{
		SProxy::getInstance().transmitStateEntry(EComponentID::CONTROL_COMP,
												 EState::STATE_JUMP);
	}
}
void CControlActionHandler::onExitJump()
{
	;
}
void CControlActionHandler::onEntryWaiting()
{
	if(mTransmitFlag == true)
	{
		SProxy::getInstance().transmitStateEntry(EComponentID::CONTROL_COMP,
												 EState::STATE_WAITING);
	}
}
void CControlActionHandler::onExitWaiting()
{
	;
}
void CControlActionHandler::onEntryAccelerate()
{
	mHardware.setMotorTorque(1U);
	if(mTransmitFlag == true)
	{
		SProxy::getInstance().transmitStateEntry(EComponentID::CONTROL_COMP,
												 EState::STATE_ACCELERATE);
	}
}
void CControlActionHandler::onExitIdle()
{
	;
}
bool CControlActionHandler::getJumpFlag()
{
	return mJumpFlag;
}
bool CControlActionHandler::getBalanceFlag()
{
	return mBalanceFlag;
}
bool CControlActionHandler::getTransmitFlag()
{
	return mTransmitFlag;
}
void CControlActionHandler::setBalanceFlag(UInt8 balanceFlag)
{
	mBalanceFlag = balanceFlag > 0U;
}
void CControlActionHandler::setJumpFlag(UInt8 jumpFlag)
{
	mJumpFlag = jumpFlag > 0U;
}
void CControlActionHandler::setTransmitFlag(UInt8 transmitFlag)
{
	mTransmitFlag = transmitFlag > 0U;
}
void CControlActionHandler::onEntryBrake()
{
	mHardware.activateBrake();
	if(mTransmitFlag == true)
	{
		SProxy::getInstance().transmitStateEntry(EComponentID::CONTROL_COMP,
												 EState::STATE_BRAKE);
	}
}
void CControlActionHandler::onExitBrake()
{
	mHardware.deactivateBrake();
}
void CControlActionHandler::onExitAccelerate()
{
	mHardware.setMotorTorque(0U);
}
bool CControlActionHandler::breakingFinished()
{
	mPhiR_d = mHardware.getPhiR_d();
	return mPhiR_d == 0U;				//Realdata needs to be evaluated with more care/should be done in the Hardware-Class
}
bool CControlActionHandler::cubeIsResting()
{
	mPhiK = mHardware.getPhiK();
	return mPhiK == 0U;					//Realdata needs to be evaluated with more care/should be done in the Hardware-Class
}
bool CControlActionHandler::jumpVelocityReached()
{
	mPhiR_d = mHardware.getPhiR_d();
	return mPhiR_d >= 1U;				//Realdata needs to be evaluated/should be done in the Control/Hardware-Class
}
bool CControlActionHandler::phiK_inBalanceArea()
{
	mPhiK = mHardware.getPhiK();
	return mPhiK >= 1U;					//Realdata needs to be actually evaluted
}
void CControlActionHandler::controlIteration()
{
	;
}
