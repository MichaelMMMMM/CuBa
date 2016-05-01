/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#include "CBasicFSM.h"
#include "CMessage.h"
#include "CControlActionHandler.h"

//Dummy Message, message will not be used and there is no need for a default Ctor in CMessage
CMessage CBasicFSM::sInternalQueue{EComponentID::CONTROL_COMP,
								   EComponentID::CONTROL_COMP,
								   EControlEvent::EV_DEFAULT_INITIAL};
UInt32 CBasicFSM::sQueueLength = 0U;

CBasicFSM::CBasicFSM(CControlActionHandler& actionHandler,
				     State initialState) :
					 	 mAction(actionHandler),
						 mState(initialState) {}
void CBasicFSM::entry(const CMessage& msg)
{
	dispatch(msg);
}
void CBasicFSM::exit(void)
{
	dispatch(CMessage(EComponentID::CONTROL_COMP,
					  EComponentID::CONTROL_COMP,
					  EControlEvent::EV_EXIT));
}
bool CBasicFSM::dispatch(const CMessage& msg)
{
	return (this->*mState)(msg);
}
