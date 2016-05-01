/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#ifndef CTXBUFFER_H
#define CTXBUFFER_H
#include "Config.h"
#include "Global.h"
#include "CMessage.h"

class CTxBuffer
{
public:
	bool writeBuffer(const UInt8 buffer[]);
	bool isFinished();
	bool getCurrentByte(UInt8& byte);
public:
	CTxBuffer();
	CTxBuffer(const CTxBuffer&) = delete;
	CTxBuffer& operator=(const CTxBuffer&) = delete;
	~CTxBuffer() = default;
private:
	static constexpr UInt32 sMaxSize = EConfig::COMM_PACKAGE_SIZE;
	UInt32 mCurrentSize;
	UInt8 mBuffer[sMaxSize];
};

#endif
