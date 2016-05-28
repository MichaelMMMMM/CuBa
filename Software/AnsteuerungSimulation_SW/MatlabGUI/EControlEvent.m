classdef EControlEvent < uint8
    enumeration
       EV_DEFAULT_INITIAL (0)
       EV_START (1)
       EV_STOP (2)
       EV_SET_JUMP_FLAG (3)
       EV_SET_BALANCE_FLAG (4)
       EV_SET_TRANSMIT_FLAG (5)
       EV_SET_JUMP_VELOCITY (6)
       EV_SET_PID_P_VALUE (7)
       EV_SET_PID_I_VALUE (8)
       EV_SET_PID_D_VALUE (9)
       EV_JUMP (10)
       EV_BRAKE (11)
       EV_PHIK_IN_BALANCEAREA (12)
       EV_PHIK_NOT_IN_BALANCEAREA (13)
       EV_TIMER (14)
       EV_INIT (15)
       EV_EXIT (16)
       EV_RESTING (17)
       EV_NOT_RESTING (18)
       EV_JUMP_VELOCITY_REACHED (19)
    end
end

