/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#ifndef CTXBUFFERLIST_H
#define CTXBUFFERLIST_H
#include "CTxBuffer.h"
#include "Config.h"
#include "TUSART.h"
#include "ERegister.h"

class CMessage;

class CTxBufferList
{
public:
	void onTXIRQ();
	bool writeMessage(const UInt8 buffer[]);
public:
	CTxBufferList(TUSART<ERegister::rUSART1>& mUSART);
	CTxBufferList(const CTxBufferList&) = delete;
	CTxBufferList& operator=(const CTxBufferList&) = delete;
	~CTxBufferList() = default;
private:
	void incrementFirstIndex();
	void incrementLastIndex();
private:
	static constexpr UInt32 sMaxSize = EConfig::COMM_TX_BUFFER_SIZE;
	UInt16 mCurrentSize;
	UInt8 mFirstIndex;
	UInt8 mLastIndex;
	CTxBuffer mBuffer[sMaxSize];
	TUSART<ERegister::rUSART1>& mUSART;
};

#endif
