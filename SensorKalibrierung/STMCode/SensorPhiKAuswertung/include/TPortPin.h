#ifndef TPORTPIN_H
#define TPORTPIN_H
#include "Global.h"
#include "EBit.h"
#include "EPinMode.h"

template<const UInt32 portAddr, const UInt32 pinNr>
class TPortPin
{
public:
	TPortPin(EPinMode pinMode, EOutputType outputType,
			 ESpeed speed, EPullType pullType,
			 EAlternateFunction alternateFunction);
	void setPinMode(const EPinMode pinMode);
	void setOutputType(const EOutputType outputType);
	void setSpeed(const ESpeed speed);
	void setPullType(const EPullType pullType);
	void setAlternateFunction(const EAlternateFunction alternateFunction);
	void setOutputValue(const UInt32 pinValue);
public:
	TPortPin(const TPortPin<portAddr, pinNr>&) = delete;
	TPortPin<portAddr, pinNr>& operator=(const TPortPin<portAddr, pinNr>&) = delete;
	TPortPin() = delete;
private:
	volatile UInt32* sGPIOx_MODER  		= reinterpret_cast<UInt32*>(portAddr + 0x00U);
	volatile UInt32* sGPIOx_OTYPER 		= reinterpret_cast<UInt32*>(portAddr + 0x04U);
	volatile UInt32* sGPIOx_OSPEEDR 	= reinterpret_cast<UInt32*>(portAddr + 0x08U);
	volatile UInt32* sGPIOx_PUPDR 		= reinterpret_cast<UInt32*>(portAddr + 0x0CU);
	volatile UInt32* sGPIOx_IDR 		= reinterpret_cast<UInt32*>(portAddr + 0x10U);
	volatile UInt32* sGPIOx_ODR 		= reinterpret_cast<UInt32*>(portAddr + 0x14U);
	volatile UInt32* sGPIOx_BSRR 		= reinterpret_cast<UInt32*>(portAddr + 0x18U);
	volatile UInt32* sGPIOx_LCKR 		= reinterpret_cast<UInt32*>(portAddr + 0x1CU);
	volatile UInt32* sGPIOx_AFRL 		= reinterpret_cast<UInt32*>(portAddr + 0x20U);
	volatile UInt32* sGPIOx_AFRH 		= reinterpret_cast<UInt32*>(portAddr + 0x24U);
};

template<const UInt32 portAddr, const UInt32 pinNr>
TPortPin<portAddr, pinNr>::TPortPin(EPinMode pinMode, EOutputType outputType,
									ESpeed speed, EPullType pullType,
									EAlternateFunction alternateFunction)
{
	this->setPinMode(pinMode);
	this->setOutputType(outputType);
	this->setSpeed(speed);
	this->setPullType(pullType);
	this->setAlternateFunction(alternateFunction);
}
template<const UInt32 portAddr, const UInt32 pinNr>
void TPortPin<portAddr, pinNr>::setOutputValue(const UInt32 pinValue)
{
	if(pinValue == 1U)
	{
		*sGPIOx_BSRR |= 1U << pinNr;
	}
	else if(pinValue == 0U)
	{
		*sGPIOx_BSRR |= 1U << (pinNr + 16U);
	}
}
template<const UInt32 portAddr, const UInt32 pinNr>
void TPortPin<portAddr, pinNr>::setPinMode(const EPinMode pinMode)
{
	*sGPIOx_MODER &= ~(0x11U << (2U * pinNr));
	*sGPIOx_MODER |= static_cast<UInt32>(pinMode) << (2U * pinNr);
}
template<const UInt32 portAddr, const UInt32 pinNr>
void TPortPin<portAddr, pinNr>::setOutputType(const EOutputType outputType)
{
	*sGPIOx_OTYPER &= ~(0x1U << (pinNr));
	*sGPIOx_OTYPER |= static_cast<UInt32>(outputType) << pinNr;
}
template<const UInt32 portAddr, const UInt32 pinNr>
void TPortPin<portAddr, pinNr>::setSpeed(const ESpeed speed)
{
	*sGPIOx_OSPEEDR &= ~(0x11U << (2U * pinNr));
	*sGPIOx_OSPEEDR |= static_cast<UInt32>(speed) << (2U * pinNr);
}
template<const UInt32 portAddr, const UInt32 pinNr>
void TPortPin<portAddr, pinNr>::setPullType(const EPullType pullType)
{
	*sGPIOx_PUPDR &= ~(0x11U << (2U * pinNr));
	*sGPIOx_PUPDR |= static_cast<UInt32>(pullType) << (2U * pinNr);
}
template<const UInt32 portAddr, const UInt32 pinNr>
void TPortPin<portAddr, pinNr>::setAlternateFunction(const EAlternateFunction alternateFunction)
{
	if(pinNr <= 7U)
	{
		*sGPIOx_AFRL &= ~(0x1111U << (4U * pinNr));
		*sGPIOx_AFRL |= static_cast<UInt32>(alternateFunction) << (4U * pinNr);
	}
	else
	{
		*sGPIOx_AFRH &= ~(0x1111U << (4U * (pinNr - 8U)));
		*sGPIOx_AFRH |= static_cast<UInt32>(alternateFunction) << (4U * (pinNr - 8U));
	}
}
#endif
