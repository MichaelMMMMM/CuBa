/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#ifndef ECOMMEVENT_H
#define ECOMMEVENT_H

enum class ECommEvent
{
	EV_DEFAULT_INITIAL,
	EV_COMM_MSG_RECEIVED,
	EV_TRANSMIT_TORQUE,
	EV_TRANSMIT_PHI_K,
	EV_TRANSMIT_PHI_K_D,
	EV_TRANSMIT_PHI_K_DD,
	EV_TRANSMIT_PHI_R_D,
	EV_TRANSMIT_BRAKE_STATE,
	EV_TRANSMIT_STATE_ENTRY,
	EV_TRANSMIT_UNHANDELD_EV
};

#endif
