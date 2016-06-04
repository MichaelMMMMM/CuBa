%Michael Meindl, 29.05.2016
% Bestimmung von C_K am Holzbau

m_K     = 0.294;
m_R     = 0.1298;
l_SA    = 0.0751442;
l_AB    = 0.08455;
Theta_K = 3.3e-3;
Theta_R = 0.088e-3;

m = 2000;
phiK = zeros(1,m);
phiK_d = zeros(1,m);
phiK_dd = zeros(1,m);

for i = 1:1:m
   while(serialInterface.BytesAvailable < 12)
       ;
   end
   
   phiK_Raw    = fread(serialInterface,4);
   phiK_d_Raw  = fread(serialInterface,4);
   phiK_dd_Raw = fread(serialInterface,4);
   
   phiK_Value = uint32(phiK_Raw(1)) + ...
                bitshift(uint32(phiK_Raw(2)), 8) + ...
                bitshift(uint32(phiK_Raw(3)), 16) + ...
                bitshift(uint32(phiK_Raw(4)), 24);
   phiK_Value = double(typecast(phiK_Value, 'single'));
   
   phiK_d_Value = uint32(phiK_d_Raw(1)) + ...
                  bitshift(uint32(phiK_d_Raw(2)), 8) + ...
                  bitshift(uint32(phiK_d_Raw(3)), 16) + ...
                  bitshift(uint32(phiK_d_Raw(4)), 24);
    phiK_d_Value = double(typecast(phiK_d_Value, 'single'));
    
    phiK(i) = phiK_Value;
    phiK_d(i) = phiK_d_Value;
end

phiK_cor = radtodeg(phiK);
for i = 1:1:m
    if(phiK(i) > 0)
        phiK_cor(i) = phiK_cor(i) - 360;
    end
end
phiK_d = phiK_d*-1;

deltaT = 5e-3;
time   = 0:deltaT:deltaT*m - deltaT;

subplot(2,1,1)
plot(time, phiK_cor);
grid;
subplot(2,1,2)
plot(time, radtodeg(phiK_d));
grid;

phiK_dd =  1./deltaT .* diff(phiK_d);
phiK_dd = [phiK_dd, phiK_dd(size(phiK_dd,1))];

A = phiK_d';
B = (((m_K * l_SA + m_R * l_AB)* 9.81 .* sind(phiK_cor)) - (Theta_K + Theta_R + m_R * l_AB^2) .* phiK_dd)';

C_K = A\B