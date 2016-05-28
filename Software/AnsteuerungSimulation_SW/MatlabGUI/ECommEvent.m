classdef ECommEvent < uint8
    enumeration
        EV_DEFAULT_INITIAL (0)
        EV_COMM_MSG_RECEIVED (1)
        EV_TRANSMIT_TORQUE (2)
        EV_TRANSMIT_PHI_K (3)
        EV_TRANSMIT_PHI_K_D (4)
        EV_TRANSMIT_PHI_K_DD (5)
        EV_TRANSMIT_PHI_R_D (6)
        EV_TRANSMIT_BRAKE_STATE (7)
        EV_TRANSMIT_FSM_STATE_ENTRY (8)
        EV_TRANSMIT_UNHANDELED_EVENT (9)
    end
end

