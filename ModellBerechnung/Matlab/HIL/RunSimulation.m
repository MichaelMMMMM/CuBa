%Gravitationsbeschleunigung
g = 9.81;
%Mechanische Zeitkonstante Motor
T_M_m = 12.4e-3;
%Elektrische Zeitkonstante Motor
T_M_e = 5.5e-4;
%Abstand von A zu B
l_AS = 0.085;
%Abstand Schwerpunkt des Körper zu (A)
l_AB = 0.075;
%Anfangswinkel des Körpers
phi_K0 = degtorad(0);
%Anfangsgeschwindigkeit des Körpers
phi_K__d0 = degtorad(0);
%Anfagsnwinkel des Schwungrades
phi_R0 = degtorad(0);
%Anfangsgeschwindigkeit des Schwungrades
phi_R__d0 = degtorad(0);
%Masse des Körpers
m_K = 0.419;
%Masse des Schwungrades
m_R = 0.204;
%Massentraegheitsmoment des Körpers um (A)
O_K_A = 3.34e-3;
%Massentraegheitsmoment des Schwungrades um (B)
O_R_B = 0.57e-3;
%Dynamischer Reibkoeffizient des Körpers
C_K = 1.02e-3;
%Dynamischer Reibkoeffizient des Schwungrades
C_R = 0.05e-3;
%Massentraegheitsmoment des Gesamtsystem um (A)
O_G_A = O_K_A + m_R * l_AB^2;

sim('CubaModel');