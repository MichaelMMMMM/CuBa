/************************************************
 * Author: Michael Meindl
 * Datum : 18.04.2016 (Uebernommen aus alter Anwendung)
 ***********************************************/
#include "TUSART.h"
#include "TPortPin.h"
#include "ERegister.h"
#include "EPinMode.h"
#include "stm32f4xx_hal.h"
#include "stm32f4xx_hal_rcc.h"

template<>
void TUSART<ERegister::rUSART1>::init()
{
    __HAL_RCC_USART1_CLK_ENABLE();
    __HAL_RCC_GPIOB_CLK_ENABLE();

    TPortPin<ERegister::rGPIOB, 6U> txPin(EPinMode::ALTERNATE_FUNCTION,
										   EOutputType::PUSH_PULL,
										   ESpeed::VERY_HIGH,
										   EPullType::PULL_UP,
										   EAlternateFunction::AF7);
    TPortPin<ERegister::rGPIOB, 7U> rxPin {EPinMode::ALTERNATE_FUNCTION,
										   EOutputType::PUSH_PULL,
										   ESpeed::VERY_HIGH,
										   EPullType::PULL_UP,
										   EAlternateFunction::AF7};

    *sUSART_BRR  |= 0x2224U;
    *sUSART_CR1  |= 0b0010000000001100U;
    *sUSART_CR2  |= 0b000000000000000U;
    *sUSART_CR3  |= 0b000000000000U;
}
template<>
void TUSART<ERegister::rUSART3>::init()
{
	__HAL_RCC_USART3_CLK_ENABLE();
	__HAL_RCC_GPIOC_CLK_ENABLE();

    TPortPin<ERegister::rGPIOC, 10U> txPin(EPinMode::ALTERNATE_FUNCTION,
										   EOutputType::PUSH_PULL,
										   ESpeed::VERY_HIGH,
										   EPullType::PULL_UP,
										   EAlternateFunction::AF7);
    TPortPin<ERegister::rGPIOC, 11U> rxPin {EPinMode::ALTERNATE_FUNCTION,
										   EOutputType::PUSH_PULL,
										   ESpeed::VERY_HIGH,
										   EPullType::PULL_UP,
										   EAlternateFunction::AF7};

	*sUSART_BRR  |= 0x1114U;
	*sUSART_CR1  |= 0b0010000000001100U;
	*sUSART_CR2  |= 0b000000000000000U;
	*sUSART_CR3  |= 0b000000000000U;
}
template<>
UInt8 TUSART<ERegister::rUSART3>::blockReadBuffer()
{
	while(((*sUSART_SR) & EBit::BIT5) == 0U)
	{
		;	//Wait for the RXNE Bit to be set
	}
	return *sUSART_DR;
}
template<>
void TUSART<ERegister::rUSART3>::blockSendByte(UInt8 byte)
{
	while(((*sUSART_SR) & EBit::BIT6) == 0U)
	{
		//Wait for the TXE-Bit to be set
	}
	*sUSART_DR = byte;
}
