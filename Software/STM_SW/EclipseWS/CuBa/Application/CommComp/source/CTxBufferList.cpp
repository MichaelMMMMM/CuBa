/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#include "CTxBufferList.h"
#include "CMessage.h"

CTxBufferList::CTxBufferList(TUSART<ERegister::rUSART1>& usart) : mCurrentSize(0U),
																  mFirstIndex(0U),
																  mLastIndex(0U),
																  mBuffer{},
																  mUSART(usart){}
void CTxBufferList::onTXIRQ()
{
	UInt8 byteToSend{0U};
	mBuffer[mFirstIndex].getCurrentByte(byteToSend);
	mUSART.sendByte(byteToSend);
	if(mBuffer[mFirstIndex].isFinished())
	{
		incrementFirstIndex();
		mCurrentSize--;
		if(mCurrentSize == 0U)
		{
			mUSART.disableTXIRQ();
		}
	}
}
bool CTxBufferList::writeMessage(const UInt8 buffer[])
{
	bool messageWritten = false;
	if(mCurrentSize == sMaxSize)
	{
		//Diagevent
	}
	else
	{
		mBuffer[mLastIndex].writeBuffer(buffer);
		incrementLastIndex();
		mCurrentSize++;
		mUSART.enableTXIRQ();
		messageWritten = true;
	}
	return messageWritten;
}
void CTxBufferList::incrementFirstIndex()
{
	if(mFirstIndex == (sMaxSize - 1U))
	{
		mFirstIndex = 0U;
	}
	else
	{
		mFirstIndex++;
	}
}
void CTxBufferList::incrementLastIndex()
{
	if(mLastIndex == (sMaxSize - 1U))
	{
		mLastIndex = 0U;
	}
	else
	{
		mLastIndex++;
	}
}
