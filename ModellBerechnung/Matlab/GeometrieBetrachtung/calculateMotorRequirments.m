%**************************************************************************
% Author: Michael Meindl
% Date: 2.4.2016
% Summary: Calculates the required Motormomenta and Velocities.
%**************************************************************************

calculateMassesAndMomenta;

phi = degtorad(0:0.1:20);
T_M = (m_K * l_K / 2 + m_R * l_K/2) * 9.81 * sin(phi);

plot(radtodeg(phi), 1000*T_M);
xlabel('Winkel in Grad');
ylabel('Nötiges Motormoment in mNm');
grid;

phi_w__d = sqrt(l_K/2 * (m_K + m_R) * 9.81 *(2-sqrt(2)) *... 
           (O_A_K + O_B_R + m_R * l_K^2 /4) / (O_B_R^2));
       
n = phi_w__d /(2*pi) * 60;