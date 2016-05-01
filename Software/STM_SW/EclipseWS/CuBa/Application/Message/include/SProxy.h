/************************************************
 * Author: Michael Meindl
 * Datum : 18.04.2016
 ***********************************************/
#ifndef SPROXY_H
#define SPROXY_H
#include "CMessage.h"
#include "SControlComponent.h"
#include "SCommComponent.h"
#include "Global.h"
#include "EState.h"

class SProxy
{
public:
	static SProxy& getInstance();
	void startControl(EComponentID sender);
	void stopControl(EComponentID sender);
	void setJumpFlag(EComponentID sender, UInt8 jumpFlag);
	void setBalanceFlag(EComponentID sender, UInt8 balanceFlag);
	void setTransmitFlag(EComponentID sender, UInt8 transmitFlag);
	void setJumpVelocity(EComponentID sender);
	void jump(EComponentID sender);
	void commMessageReceived(EComponentID sender);
	void timerCallback();
	void transmitPhiK(EComponentID sender, UInt16 phiK);
	void transmitPhiK_d(EComponentID sender, UInt16 phiK_d);
	void transmitPhiK_dd(EComponentID sender, UInt16 phiK_dd);
	void transmitPhiR_d(EComponentID sender, UInt16 phiR_d);
	void transmitBrakeState(EComponentID sender, UInt8 brakeState);
	void transmitStateEntry(EComponentID sender, EState state);
	void transmitUnhandeldEvent(EComponentID sender, EControlEvent event);
public:
	SProxy(const SProxy&) = delete;
	SProxy& operator=(const SProxy&) = delete;
	~SProxy() = default;
private:
	SProxy();
private:
	static SProxy* sInstance;
	static bool sCreated;
	SControlComponent& mControlComp;
	SCommComponent& mCommComp;
};

#endif
