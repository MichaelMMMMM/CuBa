/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#include "CRxBufferList.h"
#include "SProxy.h"

CRxBufferList::CRxBufferList(TUSART<ERegister::rUSART1>& usart) : mCurrentSize(0U),
																  mFirstIndex(0U),
																  mLastIndex(0U),
																  mBuffer{},
																  mUSART(usart)
{
	  NVIC_EnableIRQ(USART1_IRQn);
	  mUSART.enableRXIRQ();
}
void CRxBufferList::onRXIRQ()
{
	if(mCurrentSize == sMaxSize)
	{
		//Diagevent
	}
	else
	{

		mBuffer[mLastIndex].writeByte(mUSART.readBuffer());
		if(mBuffer[mLastIndex].isFinished())
		{
			SProxy::getInstance().commMessageReceived(EComponentID::COMM_COMP);
			incrementLastIndex();
			mCurrentSize++;
		}
	}
}
void CRxBufferList::proccessReceivedBuffer(void)
{
	if(mCurrentSize == 0U)
	{
		//Diagevent
	}
	else
	{
		UInt8 buffer[EConfig::COMM_PACKAGE_SIZE];
		mBuffer[mFirstIndex].getBuffer(buffer);
		//Evaluate the message content and call the Proxy accordingly
		EComponentID receiver = static_cast<EComponentID>(buffer[0U]);
		EControlEvent event   = static_cast<EControlEvent>(buffer[1U]);
		switch(event)
		{
		case EControlEvent::EV_START:
			SProxy::getInstance().startControl(EComponentID::COMM_COMP);
			break;
		case EControlEvent::EV_STOP:
			SProxy::getInstance().stopControl(EComponentID::COMM_COMP);
			break;
		case EControlEvent::EV_SET_JUMP_FLAG:
			SProxy::getInstance().setJumpFlag(EComponentID::COMM_COMP,
											  buffer[2U]);
			break;
		case EControlEvent::EV_SET_BALANCE_FLAG:
			SProxy::getInstance().setBalanceFlag(EComponentID::COMM_COMP,
												 buffer[2U]);
			break;
		case EControlEvent::EV_SET_TRANSMIT_FLAG:
			SProxy::getInstance().setTransmitFlag(EComponentID::COMM_COMP,
												  buffer[2U]);
			break;
		case EControlEvent::EV_JUMP:
			SProxy::getInstance().jump(EComponentID::COMM_COMP);
			break;
		default:
			//Diagevent
			break;
		}
		this->incrementFirstIndex();
		mCurrentSize--;
	}
}
void CRxBufferList::incrementFirstIndex(void)
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
void CRxBufferList::incrementLastIndex(void)
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
