classdef EState < uint8
    enumeration
       STATE_CONFIGURATION (0)
       STATE_RUNNING (1)
       STATE_IDLE (2)
       STATE_BALANCE (3)
       STATE_JUMP (4)
       STATE_WAITING (5)
       STATE_ACCELERATE (6)
       STATE_BRAKE (7)
       NONE(99)
    end
end

