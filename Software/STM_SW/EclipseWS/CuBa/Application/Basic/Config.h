/************************************************
 * Author: Michael Meindl
 * Datum : 17.04.2016
 ***********************************************/
#ifndef CONFIG_H
#define CONFIG_H
#include "Global.h"

namespace EConfig
{
constexpr UInt32 STATIC_MEM_SIZE	  = 1024U;
constexpr UInt32 COMPONENT_QUEUE_SIZE = 5U;
constexpr UInt32 COMM_PACKAGE_SIZE	  = 4U;
constexpr UInt32 COMM_RX_BUFFER_SIZE  = 5U;
constexpr UInt32 COMM_TX_BUFFER_SIZE  = 5U;
constexpr UInt32 TIMERPERIOD_IDLE  	  = 50U;
constexpr UInt32 TIMERPERIOD_BALANCE  = 50U;
constexpr UInt32 TIMERPERIOD_JUMP	  = 50U;
}



#endif
