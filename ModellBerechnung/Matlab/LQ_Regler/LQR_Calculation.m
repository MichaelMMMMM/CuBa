%Gravitationsbeschleunigung
g = 9.81;
%Mechanische Zeitkonstante Motor
T_M_m = 12.4e-3;
%Elektrische Zeitkonstante Motor
T_M_e = 5.5e-4;
%Abstand von A zu B
l_SA = 0.0751442;
%Abstand Schwerpunkt des Körper zu (A)
l_AB = 0.08455;
%Anfangswinkel des Körpers
phi_K0 = degtorad(1);
%Anfangsgeschwindigkeit des Körpers
phi_K__d0 = degtorad(0);
%Anfagsnwinkel des Schwungrades
phi_R0 = degtorad(0);
%Anfangsgeschwindigkeit des Schwungrades
phi_R__d0 = degtorad(0);
%Masse des Körpers
m_K = 0.294;
%Masse des Schwungrades
m_R = 0.1298;
%Massentraegheitsmoment des Körpers um (A)
O_K_A = 3.3e-3;
%Massentraegheitsmoment des Schwungrades um (B)
O_R_B = 0.088e-3;
%Dynamischer Reibkoeffizient des Körpers
C_K = 2.1e-3;
%Dynamischer Reibkoeffizient des Schwungrades
C_R = 2.1268e-5;
%Massentraegheitsmoment des Gesamtsystem um (A)
O_G_A = O_K_A + m_R * l_AB^2;

alpha1 = (g*(m_K * l_SA + m_R * l_AB)) / (O_G_A);
alpha2 = -C_K / (O_G_A);
alpha3 = C_R / (O_G_A);
alpha4 = -alpha1;
alpha5 = -alpha2;
alpha6 = (-C_R*(O_R_B + O_G_A)) / (O_R_B * O_G_A);
beta1  = -1/(O_G_A);
beta2  = (O_G_A + O_R_B) / (O_G_A * O_R_B);

A = [0 1 0;
    alpha1 alpha2 alpha3;
    alpha4 alpha5 alpha6];
B = [0;beta1;beta2];

R = 5e+6;
Q = [1 0 0; 0 1 0; 0 0 1];

[K,S,e] = lqr(A,B,Q,R);
