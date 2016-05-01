/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#include "SProxy.h"
#include "FreeRTOS.h"
#include "queue.h"
#include <new>

SProxy* SProxy::sInstance = nullptr;
SProxy& SProxy::getInstance()
{
	if(sInstance == nullptr)
	{
		void* memLocation = pvPortMalloc(sizeof(SProxy));
		sInstance = new(memLocation) SProxy;
	}
	return *sInstance;
}

SProxy::SProxy() : mControlComp(SControlComponent::getInstance()),
				   mCommComp(SCommComponent::getInstance()) {}
void SProxy::startControl(EComponentID sender)
{
	CMessage msg(sender,
			 	 EComponentID::CONTROL_COMP,
				 EControlEvent::EV_START);
	if(errQUEUE_FULL == xQueueSendToBack(mControlComp.mQueue,
					 	 	 	  	  	 static_cast<void*>(&msg),
										 0U))
	{
		//Diagevent
	}
}
void SProxy::stopControl(EComponentID sender)
{
	CMessage msg(sender,
			     EComponentID::CONTROL_COMP,
				 EControlEvent::EV_STOP);
	if(errQUEUE_FULL == xQueueSendToBack(mControlComp.mQueue,
										 static_cast<void*>(&msg),
										 0U))
	{
		//Diagevent
	}
}
void SProxy::setJumpFlag(EComponentID sender, UInt8 jumpFlag)
{
	CMessage msg(sender,
			     EComponentID::CONTROL_COMP,
				 EControlEvent::EV_SET_JUMP_FLAG);
	msg.setByte(jumpFlag, 0U);
	if(errQUEUE_FULL == xQueueSendToBack(mControlComp.mQueue,
										 static_cast<void*>(&msg),
										 0U))
	{
		//Diagevent
	}
}
void SProxy::setBalanceFlag(EComponentID sender, UInt8 balanceFlag)
{
	CMessage msg(sender,
			     EComponentID::CONTROL_COMP,
				 EControlEvent::EV_SET_BALANCE_FLAG);
	msg.setByte(balanceFlag, 0U);
	if(errQUEUE_FULL == xQueueSendToBack(mControlComp.mQueue,
										 static_cast<void*>(&msg),
										 0U))
	{
		//Diagevent
	}
}
void SProxy::setTransmitFlag(EComponentID sender, UInt8 transmitFlag)
{
	CMessage msg(sender,
			     EComponentID::CONTROL_COMP,
				 EControlEvent::EV_SET_TRANSMIT_FLAG);
	msg.setByte(transmitFlag, 0U);
	if(errQUEUE_FULL == xQueueSendToBack(mControlComp.mQueue,
										 static_cast<void*>(&msg),
										 0U))
	{
		//Diagevent
	}
}
void SProxy::jump(EComponentID sender)
{
	CMessage msg(sender,
			     EComponentID::CONTROL_COMP,
				 EControlEvent::EV_JUMP);
	if(errQUEUE_FULL == xQueueSendToBack(mControlComp.mQueue,
										 static_cast<void*>(&msg),
										 0U))
	{
		//Diagevent
	}
}
void SProxy::timerCallback()
{
	CMessage msg(EComponentID::CONTROL_COMP,
				 EComponentID::CONTROL_COMP,
				 EControlEvent::EV_TIMER);
	if(errQUEUE_FULL == xQueueSendToBackFromISR(mControlComp.mQueue,
												static_cast<void*>(&msg),
												0U))
	{
		//Diagevent
	}
}
void SProxy::commMessageReceived(EComponentID sender)
{
	CMessage msg(sender,
			     EComponentID::COMM_COMP,
				 ECommEvent::EV_COMM_MSG_RECEIVED);
	if(errQUEUE_FULL == xQueueSendToBackFromISR(mCommComp.mQueue,
												static_cast<void*>(&msg),
												0U))
	{
		//Diagevent
	}
}
void SProxy::transmitPhiK(EComponentID sender, UInt16 phiK)
{
	CMessage msg(sender,
				 EComponentID::COMM_COMP,
				 ECommEvent::EV_TRANSMIT_PHI_K);
	msg.setData(static_cast<UInt32>(phiK));
	if(errQUEUE_FULL == xQueueSendToBack(mCommComp.mQueue,
										 static_cast<void*>(&msg),
										 0U))
	{
		//Diagevent
	}
}
void SProxy::transmitPhiK_d(EComponentID sender, UInt16 phiK_d)
{
	CMessage msg(sender,
				 EComponentID::COMM_COMP,
				 ECommEvent::EV_TRANSMIT_PHI_K_D);
	msg.setData(static_cast<UInt32>(phiK_d));
	if(errQUEUE_FULL == xQueueSendToBack(mCommComp.mQueue,
										 static_cast<void*>(&msg),
										 0U))
	{
		//Diagevent
	}
}
void SProxy::transmitPhiK_dd(EComponentID sender, UInt16 phiK_dd)
{
	CMessage msg(sender,
				 EComponentID::COMM_COMP,
				 ECommEvent::EV_TRANSMIT_PHI_K_DD);
	msg.setData(static_cast<UInt32>(phiK_dd));
	if(errQUEUE_FULL == xQueueSendToBack(mCommComp.mQueue,
										 static_cast<void*>(&msg),
										 0U))
	{
		//Diagevent
	}
}
void SProxy::transmitPhiR_d(EComponentID sender, UInt16 phiR_d)
{
	CMessage msg(sender,
				 EComponentID::COMM_COMP,
				 ECommEvent::EV_TRANSMIT_PHI_R_D);
	msg.setData(static_cast<UInt32>(phiR_d));
	if(errQUEUE_FULL == xQueueSendToBack(mCommComp.mQueue,
										 static_cast<void*>(&msg),
										 0U))
	{
		//Diagevent
	}
}
void SProxy::transmitBrakeState(EComponentID sender, UInt8 brakeState)
{
	CMessage msg(sender,
				 EComponentID::COMM_COMP,
				 ECommEvent::EV_TRANSMIT_PHI_K_D);
	msg.setData(static_cast<UInt32>(brakeState));
	if(errQUEUE_FULL == xQueueSendToBack(mCommComp.mQueue,
										 static_cast<void*>(&msg),
										 0U))
	{
		//Diagevent
	}
}
void SProxy::transmitStateEntry(EComponentID sender, EState state)
{
	CMessage msg(sender,
				 EComponentID::COMM_COMP,
				 ECommEvent::EV_TRANSMIT_STATE_ENTRY);
	msg.setData(static_cast<UInt32>(state));
	if(errQUEUE_FULL == xQueueSendToBack(mCommComp.mQueue,
										 static_cast<void*>(&msg),
										 0U))
	{
		//Diagevent
	}
}
void SProxy::transmitUnhandeldEvent(EComponentID sender, EControlEvent event)
{
	CMessage msg(sender,
			     EComponentID::COMM_COMP,
				 ECommEvent::EV_TRANSMIT_UNHANDELD_EV);
	msg.setData(static_cast<UInt32>(event));
	if(errQUEUE_FULL == xQueueSendToBack(mCommComp.mQueue,
										 static_cast<void*>(&msg),
										 0U))
	{
		//Diagevent
	}
}
