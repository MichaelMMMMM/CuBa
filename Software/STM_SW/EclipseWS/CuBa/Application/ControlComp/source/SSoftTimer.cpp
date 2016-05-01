/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#include "SSoftTimer.h"
#include "SProxy.h"
#include "FreeRTOS.h"
#include <new>

SSoftTimer* SSoftTimer::sInstance = nullptr;
SSoftTimer& SSoftTimer::getInstance()
{
	if(sInstance == nullptr)
	{
		sInstance = new(pvPortMalloc(sizeof(SSoftTimer)))SSoftTimer();
	}
	return *sInstance;
}
SSoftTimer::SSoftTimer() : mActive(false),
						   mTickLimit(1000U),
						   mTickCounter(0U) {}
void SSoftTimer::start()
{
	mActive = true;
}
void SSoftTimer::stop()
{
	mActive = false;
}
void SSoftTimer::setPeriod(UInt32 periodInMS)
{
	mTickLimit = periodInMS;
}
void SSoftTimer::onSysTick()
{
	if(mActive == true)
	{
		mTickCounter++;
		if(mTickCounter >= mTickLimit)
		{
			mTickCounter = 0U;
			SProxy::getInstance().timerCallback();
		}
	}
}
