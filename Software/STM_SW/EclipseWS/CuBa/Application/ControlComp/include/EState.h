/************************************************
 * Author: Michael Meindl
 * Datum : 21.04.2016
 ***********************************************/
#ifndef ESTATE_H
#define ESTATE_H

enum class EState
{
	STATE_CONFIFURATION,
	STATE_RUNNING,
	STATE_IDLE,
	STATE_BALANCE,
	STATE_JUMP,
	STATE_WAITING,
	STATE_ACCELERATE,
	STATE_BRAKE
};

#endif
