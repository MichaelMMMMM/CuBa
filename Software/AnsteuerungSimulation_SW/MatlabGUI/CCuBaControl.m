%Autor : Michael Meindl, 25.05.2016
%Klasse übernimmt die Versendung und Empfangen der Datenpakete

classdef CCuBaControl < handle
    properties
        mSerial
        mPhiKValues
        mPhiKTime
        mPhiKDValues
        mPhiKDTime
        mTMValues
        mState
        mSubstate
    end
    
    methods
        function ctor = CCuBaControl(serialInterface)
            ctor.mSerial = serialInterface;
            fopen(ctor.mSerial);
            ctor.mPhiKValues  = 0;
            ctor.mPhiKTime    = 0;
            ctor.mPhiKDValues = 0;
            ctor.mPhiKDTime   = 0;
            ctor.mTMValues    = [];
            ctor.mState       = EState.STATE_CONFIGURATION;
            ctor.mSubstate    = [];
            
        end
        function delete(this)
            fclose(this.mSerial);
        end
        function start(this)
            txData    = zeros(1,6, 'uint8');
            txData(1) = EComponentID.CONTROL_COMP;
            txData(2) = EControlEvent.EV_START;
            fwrite(this.mSerial, txData);
        end
        function pollCOM(this)
           while(this.mSerial.BytesAvailable >= 6)
               data = fread(this.mSerial, 6);
               event = data(2);
               switch event
                   case ECommEvent.EV_TRANSMIT_TORQUE
                       torque = uint32(data(3)) + ...
                                bitshift(uint32(data(4)), 8) + ...
                                bitshift(uint32(data(5)), 16) + ...
                                bitshift(uint32(data(6)), 24);
                       torque = double(typecast(torque, 'single'));
                       this.mTMValues = [this.mTMValues, torque];
                   case ECommEvent.EV_TRANSMIT_FSM_STATE_ENTRY
                       state = data(3);
                       if(state == EState.STATE_IDLE || ...
                          state == EState.STATE_BALANCE)
                            this.mState = state;
                            this.mSubstate = EState.NONE;
                       else if(state == EState.STATE_JUMP)
                               this.mState = state;
                       else
                           this.mSubstate = state;
                           end
                       end
                   case ECommEvent.EV_TRANSMIT_PHI_K
                       phiK = uint32(data(3)) + ...
                                bitshift(uint32(data(4)), 8) + ...
                                bitshift(uint32(data(5)), 16) + ...
                                bitshift(uint32(data(6)), 24);
                       phiK = double(typecast(phiK, 'single'));
                       this.mPhiKValues = [this.mPhiKValues, phiK];
                       if(size(this.mPhiKTime,1) == 0)
                           this.mPhiKTime = 0;
                       else
                           this.mPhiKTime = [this.mPhiKTime,...
                               this.mPhiKTime(size(this.mPhiKTime,2)) + 0.05];
                       end
                   case ECommEvent.EV_TRANSMIT_PHI_K_D
                       phiKD = uint32(data(3)) + ...
                               bitshift(uint32(data(4)), 8) + ...
                               bitshift(uint32(data(5)), 16) + ...
                               bitshift(uint32(data(6)), 24);
                       phiKD = double(typecast(phiKD, 'single'));
                       this.mPhiKDValues = [this.mPhiKDValues, phiKD];
                       this.mPhiKDTime = [this.mPhiKDTime,...
                           this.mPhiKDTime(size(this.mPhiKDTime,2)) + 0.05];
               end
                       
           end
        end
        function stop(this)
            txData    = zeros(1,6, 'uint8');
            txData(1) = EComponentID.CONTROL_COMP;
            txData(2) = EControlEvent.EV_STOP;
            fwrite(this.mSerial, txData);
        end
        function setJumpFlag(this, flagValue)
            txData    = zeros(1,6, 'uint8');
            txData(1) = EComponentID.CONTROL_COMP;
            txData(2) = EControlEvent.EV_SET_JUMP_FLAG;
            txData(3) = uint8(flagValue);
            fwrite(this.mSerial, txData);
        end
        function setBalanceFlag(this, flagValue)
            txData    = zeros(1,6, 'uint8');
            txData(1) = EComponentID.CONTROL_COMP;
            txData(2) = EControlEvent.EV_SET_BALANCE_FLAG;
            txData(3) = uint8(flagValue);
            fwrite(this.mSerial, txData);
        end
        function setTransmitFlag(this, flagValue)
            txData    = zeros(1,6, 'uint8');
            txData(1) = EComponentID.CONTROL_COMP;
            txData(2) = EControlEvent.EV_SET_TRANSMIT_FLAG;
            txData(3) = uint8(flagValue);
            fwrite(this.mSerial, txData);
        end
        function jumpCommand(this)
            txData    = zeros(1,6, 'uint8');
            txData(1) = EComponentID.CONTROL_COMP;
            txData(2) = EControlEvent.EV_JUMP;
            fwrite(this.mSerial, txData);
        end
        function setJumpVelocity(this, velocity)
            txData    = zeros(1,2, 'uint8');
            txData(1) = EComponentID.CONTROL_COMP;
            txData(2) = EControlEvent.EV_SET_JUMP_VELOCITY;
            txData    = [txData, typecast(single(velocity), 'uint8')];
            fwrite(this.mSerial, txData);
        end
        function setPID_P_Value(this, pValue)
            txData    = zeros(1,2, 'uint8');
            txData(1) = EComponentID.CONTROL_COMP;
            txData(2) = EControlEvent.EV_SET_PID_P_VALUE;
            txData    = [txData, typecast(single(pValue), 'uint8')];
            fwrite(this.mSerial, txData);
        end
        function setPID_I_Value(this, iValue)
            txData    = zeros(1,2, 'uint8');
            txData(1) = EComponentID.CONTROL_COMP;
            txData(2) = EControlEvent.EV_SET_PID_I_VALUE;
            txData    = [txData, typecast(single(iValue), 'uint8')];
            fwrite(this.mSerial, txData);
        end
        function setPID_D_Value(this, dValue)
            txData    = zeros(1,2, 'uint8');
            txData(1) = EComponentID.CONTROL_COMP;
            txData(2) = EControlEvent.EV_SET_PID_D_VALUE;
            txData    = [txData, typecast(single(dValue), 'uint8')];
            fwrite(this.mSerial, txData);
        end
    end
    
end

