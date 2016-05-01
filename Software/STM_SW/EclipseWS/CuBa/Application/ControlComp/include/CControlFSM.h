/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#ifndef CCONTROLFSM_H
#define CCONTROLFSM_H
#include "CBasicFSM.h"
#include "CStateRunning.h"

class CControlFSM : public CBasicFSM
{
public:
	CControlFSM(CControlActionHandler& actionHandler);
	bool dispatch(const CMessage& msg);
private:
	bool onInitial(const CMessage& msg);
	bool onConfiguration(const CMessage& msg);
	bool onRunning(const CMessage& msg);

	#define ON_DEFAULT_INITIAL_FSM  STATE(&CControlFSM::onInitial)
	#define ON_CONFIGURATION STATE(&CControlFSM::onConfiguration)
	#define ON_RUNNING		STATE(&CControlFSM::onRunning)
private:
	CStateRunning mStateRunning;
};

#endif
