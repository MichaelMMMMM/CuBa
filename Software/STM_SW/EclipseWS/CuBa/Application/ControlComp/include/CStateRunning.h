/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#ifndef CSTATERUNNING_H
#define CSTATERUNNING_H
#include "CBasicFSM.h"
#include "CStateJump.h"

class CStateRunning : public CBasicFSM
{
public:
	CStateRunning(CControlActionHandler& actionHandler);
	CStateRunning(const CStateRunning&) = delete;
	CStateRunning& operator=(const CStateRunning&) = delete;
private:
	bool onInitial(const CMessage& msg);
	bool onIdle(const CMessage& msg);
	bool onJump(const CMessage& msg);
	bool onBalance(const CMessage& msg);

	#define ON_DEFAULT_INITIAL_RUNNING 	STATE(&CStateRunning::onInitial)
	#define ON_IDLE 					STATE(&CStateRunning::onIdle)
	#define ON_JUMP 					STATE(&CStateRunning::onJump)
	#define ON_BALANCE 					STATE(&CStateRunning::onBalance)
private:
	CStateJump mStateJump;
};

#endif
