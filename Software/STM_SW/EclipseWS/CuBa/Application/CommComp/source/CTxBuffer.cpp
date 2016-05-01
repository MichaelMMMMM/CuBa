/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#include "CTxBuffer.h"
#include "CMessage.h"

CTxBuffer::CTxBuffer() : mCurrentSize(0U),
						 mBuffer{0U} {}
bool CTxBuffer::writeBuffer(const UInt8 buffer[])
{
	bool bufferWritten = false;
	if(mCurrentSize == 0U)
	{
		for(UInt8 index = 0U; index < sMaxSize; index++)
		{
			mBuffer[index] = buffer[index];
		}
		mCurrentSize = sMaxSize;
		bufferWritten = true;
	}
	return bufferWritten;
}
bool CTxBuffer::getCurrentByte(UInt8& byte)
{
	bool byteRead = false;
	if(mCurrentSize > 0U)
	{
		byte = mBuffer[sMaxSize - mCurrentSize];
		mCurrentSize--;
		byteRead = true;
	}
	return byteRead;
}
bool CTxBuffer::isFinished()
{
	return mCurrentSize == 0U;
}
