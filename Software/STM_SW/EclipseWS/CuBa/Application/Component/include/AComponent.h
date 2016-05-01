/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#ifndef ACOMPONENT_H
#define ACOMPONENT_H
#include "Global.h"
#include "EComponentID.h"
#include "FreeRTOS.h"
#include "queue.h"

class CMessage;
class SProxy;

class AComponent
{
public:
	void run(void);
	virtual bool dispatch(const CMessage& msg) =0;
public:
	AComponent(EComponentID id);
	AComponent(const AComponent&) = delete;
	AComponent& operator=(const AComponent&) = delete;
	virtual ~AComponent(void);
protected:
	EComponentID mID;
	xQueueHandle mQueue;

	friend SProxy;	//Proxy must have access to the queue
};


#endif
