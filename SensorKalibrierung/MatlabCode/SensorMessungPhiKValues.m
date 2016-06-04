% Autor : Michael Meindl
% Datum : 17.05.2016
% Messung von phiK, phiK_d und phiK_dd, MC wertet Sensordaten aus

m = 1000;
deltaT = 5e-3;
time = 0:deltaT:(m-1)*deltaT;
phiK_Values    = zeros(1,m);
phiK_d_Values  = zeros(1,m);
phiK_dd_Values = zeros(1,m);

for i = 1:1:m
    while(serialInterface.BytesAvailable < 12)
        ;
    end

    phiK_Data    = fread(serialInterface, 4);
    phiK_d_Data  = fread(serialInterface, 4);
    phiK_dd_Data = fread(serialInterface, 4);

    phiK32      = uint32(phiK_Data(1)) + ...
                  bitshift(uint32(phiK_Data(2)),8) + ...
                  bitshift(uint32(phiK_Data(3)), 16) + ...
                  bitshift(uint32(phiK_Data(4)), 24);
    phiK        = typecast(phiK32, 'single');
    phiK_deg    = radtodeg(phiK);

    phiK32_d    = uint32(phiK_d_Data(1)) + ...
                  bitshift(uint32(phiK_d_Data(2)), 8) + ...
                  bitshift(uint32(phiK_d_Data(3)), 16) + ...
                  bitshift(uint32(phiK_d_Data(4)), 24);
    phiK_d      = typecast(phiK32_d, 'single');
    phiK_d_deg    = radtodeg(phiK_d);

    phiK32_dd   = uint32(phiK_dd_Data(1)) + ...
                  bitshift(uint32(phiK_dd_Data(2)), 8) + ...
                  bitshift(uint32(phiK_dd_Data(3)), 16) + ...
                  bitshift(uint32(phiK_dd_Data(4)), 24);
    phiK_dd     = typecast(phiK32_dd, 'single');
    phiK_dd_deg = radtodeg(phiK_dd);
    
    phiK_Values(i)    = phiK_deg;
    phiK_d_Values(i)  = phiK_d_deg;
    phiK_dd_Values(i) = phiK_dd_deg;
end

plot(time, phiK_Values); grid; xlabel('Zeit in Sekunden'); ylabel('\phi_K in Grad');