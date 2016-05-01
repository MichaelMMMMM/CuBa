/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#ifndef CBASICFSM_H
#define CBASICFSM_H
#include "Global.h"

class CMessage;
class CControlActionHandler;


class CBasicFSM
{
public:
	typedef bool (CBasicFSM::*State)(const CMessage&);
	#define STATE(x) ((static_cast<CBasicFSM::State>(x)))
public:
	CBasicFSM(CControlActionHandler& actionHandler,
			  State initialState);

	void entry(const CMessage& msg);
	void exit(void);
	bool dispatch(const CMessage& msg);
public:
	CBasicFSM(const CBasicFSM&) = delete;
	CBasicFSM& operator=(const CBasicFSM&) = delete;
	~CBasicFSM() = default;
protected:
	CControlActionHandler& mAction;
	State mState;

	static CMessage sInternalQueue;
	static UInt32 sQueueLength;
};

#endif
