% Autor : Michael Meindl
% Datum : 17.05.2016
% Messung von phiK, phiK_d und phiK_dd, MC wertet Sensordaten aus

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

[phiK_deg, phiK_d_deg, phiK_dd_deg]