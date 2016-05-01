/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#ifndef CCONTROLACTIONHANDLER_H
#define CCONTROLACTIONHANDLER_H
#include "Global.h"
#include "SSoftTimer.h"
#include "CSimulatedHardware.h"

class CControlActionHandler
{
public:
	void onEntryConfiguration();
	void onExitConfiguration();
	void onEntryRunning();
	void onExitRunning();
	void onEntryIdle();
	void onExitIdle();
	void onEntryBalance();
	void onExitBalance();
	void onEntryJump();
	void onExitJump();
	void onEntryWaiting();
	void onExitWaiting();
	void onEntryAccelerate();
	void onExitAccelerate();
	void onEntryBrake();
	void onExitBrake();
	//Helper methods
	bool phiK_inBalanceArea();
	bool cubeIsResting();
	bool jumpVelocityReached();
	bool breakingFinished();
	void controlIteration();
	bool getJumpFlag();
	bool getBalanceFlag();
	bool getTransmitFlag();
	void setJumpFlag(UInt8 jumpFlag);
	void setBalanceFlag(UInt8 balanceFlag);
	void setTransmitFlag(UInt8 transmitFlag);
public:
	CControlActionHandler();
	CControlActionHandler(const CControlActionHandler&) = delete;
	CControlActionHandler& operator=(const CControlActionHandler&) = delete;
	~CControlActionHandler() = default;
private:
	bool mJumpFlag;
	bool mBalanceFlag;
	bool mTransmitFlag;
	UInt16 mPhiK;
	UInt16 mPhiK_d;
	UInt16 mPhiK_dd;
	UInt16 mPhiR_d;
	SSoftTimer& mSoftTimer;
	CSimulatedHardware mHardware;
};

#endif
