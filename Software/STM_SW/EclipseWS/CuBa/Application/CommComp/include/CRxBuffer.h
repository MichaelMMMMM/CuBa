/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#ifndef CRXBUFFER_H
#define CRXBUFFER_H
#include "Global.h"
#include "Config.h"

class CRxBuffer
{
public:
	bool writeByte(UInt8 byte);
	bool isFinished();
	bool getBuffer(UInt8 buffer[]);
public:
	CRxBuffer();
	CRxBuffer(const CRxBuffer&) = delete;
	CRxBuffer& operator=(const CRxBuffer&) = delete;
	~CRxBuffer() = default;
private:
	UInt32 mCurrentSize;
	UInt8 mBuffer[EConfig::COMM_PACKAGE_SIZE];
};

#endif
