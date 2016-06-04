serialInterface = serial('COM14', 'Terminator', '', 'BaudRate', '');
cuba = CCuBaControl(serialInterface);

cuba.setTransmitFlag();
cuba.setJumpFlag();

jumpVelocity = degtorad(2000);
learnIncrement = 100;
learnRate = 0.9;

cuba.setJumpVelocity(jumpVelocity);
cuba.start();
cuba.jump();

pause(1);

phiK_zeroCrossing   = 0;
phiK_d_zeroCrossing = 0;
while(phiK_zeroCrossing == 0 && phiK_d_zeroCrossing == 0)
    cuba.pollCOM();
    if(EState(cuba.mSubstate) == EState.STATE_BRAKE)
        phiK_size = size(cuba.mPhiKValues);
        phiK    = cuba.mPhiKValues(phiK_size - 2000 : phiKsize);
        phiK_zc = phiK > 0;
        phiK_zc = diff(phiK_zc);
        phiK_zc = [phiK_zc phiK_zc(size(phiK_zc,2))];
        phiK_zc = find(phiK_zc ~= 0);
        if(size(phiK_zc,2) > 0)
            phiK_zeroCrossing = 1;
        end
        
        phiK_d_size = size(cuba.mPhiKDValues);
        phiK_d    = cuba.mPhiKDValues(phiK_d_size - 2000 : phiK_d_size);
        phiK_d_zc = phiK_d > 0;
        phiK_d_zc = diff(phiK_d_zc);
        phiK_d_zc = [phiK_d_zc phiK_d_zc(size(phiK_d_zc,2))];
        phiK_d_zc = find(phiK_d_zc ~= 0);
        if(size(phiK_zc,2) > 0)
            phiK_d_zeroCrossing = 1;
        end
    end  
end

cuba.stop();
jumpVelocity = jumpVelocity + learnIncrement;
learnIncrement = learnIncrement * learnRate;