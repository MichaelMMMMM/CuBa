/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#ifndef CRXBUFFERLIST_H
#define CRXBUFFERLIST_H
#include "Config.h"
#include "Global.h"
#include "CRxBuffer.h"
#include "TUSART.h"
#include "ERegister.h"

class CRxBuffer;

class CRxBufferList
{
public:
	void onRXIRQ();
	void proccessReceivedBuffer(void);
public:
	CRxBufferList(TUSART<ERegister::rUSART1>& usart);
	CRxBufferList(const CRxBufferList&) = delete;
	CRxBufferList& operator=(const CRxBufferList&) = delete;
	~CRxBufferList(void) = default;
private:
	void incrementFirstIndex(void);
	void incrementLastIndex(void);
private:
	static constexpr UInt32 sMaxSize = EConfig::COMM_RX_BUFFER_SIZE;
	UInt16 mCurrentSize;
	UInt8  mFirstIndex;
	UInt8  mLastIndex;
	CRxBuffer mBuffer[sMaxSize];
	TUSART<ERegister::rUSART1>& mUSART;
};

#endif
