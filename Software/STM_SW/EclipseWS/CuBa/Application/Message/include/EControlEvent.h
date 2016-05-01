/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#ifndef ECONTROLEVENT_H
#define ECONTROLEVENT_H

enum class EControlEvent
{
	EV_DEFAULT_INITIAL,
	EV_START,
	EV_STOP,
	EV_SET_JUMP_FLAG,
	EV_SET_BALANCE_FLAG,
	EV_SET_TRANSMIT_FLAG,
	EV_SET_JUMP_VELOCITY,
	EV_SET_PID_VALUES,
	EV_JUMP,
	EV_BRAKE,
	EV_PHIK_IN_BALANCEAREA,
	EV_PHIK_NOT_IN_BALANCEAREA,
	EV_TIMER,
	EV_INIT,
	EV_EXIT,
	EV_RESTING,
	EV_NOT_RESTING,
	EV_JUMP_VELOCITY_REACHED
};

#endif
