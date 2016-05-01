/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#ifndef CSTATEJUMP_H
#define CSTATEJUMP_H
#include "CBasicFSM.h"

class CStateJump : public CBasicFSM
{
public:
	CStateJump(CControlActionHandler& actionHandler);
	CStateJump(const CStateJump&) = delete;
	CStateJump& operator=(const CStateJump&) = delete;
private:
	bool onInitial(const CMessage& msg);
	bool onWaiting(const CMessage& msg);
	bool onAccelerate(const CMessage& msg);
	bool onBrake(const CMessage& msg);
	#define ON_DEFAULT_INITIAL_JUMP STATE(&CStateJump::onInitial)
	#define ON_WAITING STATE(&CStateJump::onWaiting)
	#define ON_ACCELERATE STATE(&CStateJump::onAccelerate)
	#define ON_BRAKE STATE(&CStateJump::onBrake)
};

#endif
