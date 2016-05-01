/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#include "CRxBuffer.h"

CRxBuffer::CRxBuffer() : mCurrentSize(0U),
						 mBuffer{0U} {}
bool CRxBuffer::writeByte(UInt8 byte)
{
	bool byteWritten = false;
	if(mCurrentSize < EConfig::COMM_PACKAGE_SIZE)
	{
		mBuffer[mCurrentSize] = byte;
		mCurrentSize++;
		byteWritten = true;
	}
	return byteWritten;
}
bool CRxBuffer::isFinished()
{
	return mCurrentSize == EConfig::COMM_PACKAGE_SIZE;
}
bool CRxBuffer::getBuffer(UInt8 buffer[])
{
	bool bufferWritten = false;
	if(this->isFinished())
	{
		for(UInt32 bufferIndex = 0U; bufferIndex < EConfig::COMM_PACKAGE_SIZE; bufferIndex++)
		{
			buffer[bufferIndex] = mBuffer[bufferIndex];
		}
		mCurrentSize = 0U;
		bufferWritten = true;
	}
	return bufferWritten;
}
