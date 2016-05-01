/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#ifndef CMESSAGE_H
#define CMESSAGE_H
#include "EComponentID.h"
#include "EMessageType.h"
#include "EControlEvent.h"
#include "EDiagEvent.h"
#include "ECommEvent.h"
#include "Global.h"

class CMessage
{
public:
	EComponentID getSender() const;
	EComponentID getReceiver() const;
	EMessageType getMessageType() const;
	EControlEvent getControlEvent() const;
	EDiagEvent getDiagEvent() const;
	ECommEvent getCommEvent() const;
	UInt32 getData() const;
	void setData(UInt32 data);
	void setByte(UInt8 byte, UInt8 index);
public:
	CMessage(EComponentID sender,
			 EComponentID receiver,
			 EControlEvent controlEvent);
	CMessage(EComponentID sender,
			 EComponentID receiver,
			 EDiagEvent diagEvent);
	CMessage(EComponentID sender,
			 EComponentID receiver,
			 ECommEvent commEvent);
	CMessage(const CMessage&) = default;
	CMessage& operator=(const CMessage&) = default;
	~CMessage() = default;
private:
	EComponentID mSender;
	EComponentID mReceiver;
	EMessageType mType;
	union
	{
		EControlEvent mControlEvent;
		EDiagEvent mDiagEvent;
		ECommEvent mCommEvent;
	};
	union
	{
		UInt8 mByteArray[4];
		UInt32 mData;
	};
};

#endif
