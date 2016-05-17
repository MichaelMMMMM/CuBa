#ifndef EPINMODE_H
#define EPINMODE_H
#include "EBit.h"

enum class EPinMode
{
	INPUT 				= 0b00U,
	OUTPUT 				= 0b01U,
	ALTERNATE_FUNCTION 	= 0b10U,
	ANALOG 				= 0b11U
};

enum class EOutputType
{
	PUSH_PULL  = 0b00U,
	OPEN_DRAIN = 0b01U
};

enum class ESpeed
{
	LOW 		= 0b00U,
	MEDIUM 		= 0b01U,
	HIGH 		= 0b10U,
	VERY_HIGH 	= 0b11U
};

enum class EPullType
{
	NO_PULL 	= 0b00U,
	PULL_UP		= 0b01U,
	PULL_DOWN	= 0b10U
};

enum class EAlternateFunction
{
	AF0			= 0b0000U,
	AF1			= 0b0001U,
	AF2			= 0b0010U,
	AF3			= 0b0011U,
	AF4			= 0b0100U,
	AF5			= 0b0101U,
	AF6			= 0b0110U,
	AF7			= 0b0111U,
	AF8 		= 0b1000U,
	AF9			= 0b1001U,
	AF10		= 0b1010U,
	AF11		= 0b1011U,
	AF12		= 0b1100U,
	AF13		= 0b1101U,
	AF14		= 0b1110U,
	AF15		= 0b1111U
};
#endif
