/************************************************
 * Author: Michael Meindl
 * Datum : 18.04.2016
 ***********************************************/
#ifndef SSOFTTIMER_H
#define SSOFTTIMER_H
#include "Global.h"

class SSoftTimer
{
public:
	void start();
	void stop();
	void onSysTick();
	void setPeriod(UInt32 periodInMS);
	static SSoftTimer& getInstance();
private:
	SSoftTimer();
	SSoftTimer(const SSoftTimer&) = delete;
	SSoftTimer& operator=(const SSoftTimer&) = delete;
	~SSoftTimer() = default;
private:
	bool mActive;
	UInt32 mTickLimit;
	UInt32 mTickCounter;
	static SSoftTimer* sInstance;
};

#endif
