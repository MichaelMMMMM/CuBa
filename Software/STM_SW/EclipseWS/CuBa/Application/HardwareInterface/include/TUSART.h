#ifndef TUSART_H
#define TUSART_H
#include "stm32f4xx_hal.h"
#include "stm32f4xx_hal_rcc.h"
#include "Global.h"
#include "EBit.h"
#include "ERegister.h"
#include "TPortPin.h"

template<const UInt32 baseAddr>
class TUSART
{
public:
	TUSART();
	void init();
	void sendByte(const UInt8 byte);
	void enableRXIRQ();
	void disableRXIRQ();
	void enableTXIRQ();
	void disableTXIRQ();
	bool checkTXIRQ();
	bool checkRXIRQ();
	UInt8 readBuffer();
	UInt8 blockReadBuffer(); //This method polls the RX-Buffer blocking execution
	void blockSendByte(UInt8 byte); //This methods blocks until TX-Buffer is empty
public:
	TUSART(const TUSART<baseAddr>&) = delete;
	TUSART<baseAddr>& operator=(const TUSART<baseAddr>&) = delete;
private:
	static constexpr volatile UInt32* sUSART_SR 		= reinterpret_cast<UInt32*>(baseAddr + 0x00U);
	static constexpr volatile UInt32* sUSART_DR 		= reinterpret_cast<UInt32*>(baseAddr + 0x04U);
	static constexpr volatile UInt32* sUSART_BRR 	= reinterpret_cast<UInt32*>(baseAddr + 0x08U);
	static constexpr volatile UInt32* sUSART_CR1 	= reinterpret_cast<UInt32*>(baseAddr + 0x0CU);
	static constexpr volatile UInt32* sUSART_CR2 	= reinterpret_cast<UInt32*>(baseAddr + 0x10U);
	static constexpr volatile UInt32* sUSART_CR3 	= reinterpret_cast<UInt32*>(baseAddr + 0x14U);
	static constexpr volatile UInt32* sUSART_GTPR 	= reinterpret_cast<UInt32*>(baseAddr + 0x18U);
};

template<const UInt32 baseAddr>
bool TUSART<baseAddr>::checkRXIRQ()
{
	return ((*sUSART_SR & EBit::BIT5) > 0U) && ((*sUSART_CR1 & EBit::BIT5) > 0U);
}
template<const UInt32 baseAddr>
bool TUSART<baseAddr>::checkTXIRQ()
{
	return ((*sUSART_SR & EBit::BIT6) > 0U) && ((*sUSART_CR1 & EBit::BIT6) > 0U);
}
template<const UInt32 baseAddr>
TUSART<baseAddr>::TUSART()
{
	this->init();
}
template<const UInt32 baseAddr>
void TUSART<baseAddr>::sendByte(const UInt8 byte)
{
	*sUSART_DR = byte;
}
template<const UInt32 registerAddr>
void TUSART<registerAddr>::enableRXIRQ()
{
	*sUSART_CR1 |= 0b0100000U;
}
template<const UInt32 registerAddr>
void TUSART<registerAddr>::disableRXIRQ()
{
	*sUSART_CR1 &= ~(0b0100000U);
}
template<const UInt32 registerAddr>
void TUSART<registerAddr>::enableTXIRQ()
{
	*sUSART_CR1 |= EBit::BIT6;
}
template<const UInt32 registerAddr>
void TUSART<registerAddr>::disableTXIRQ()
{
	*sUSART_CR1 &= ~(EBit::BIT6);
}
template<const UInt32 registerAddr>
UInt8 TUSART<registerAddr>::readBuffer()
{
	return static_cast<UInt8>(*sUSART_DR);
}

#endif
