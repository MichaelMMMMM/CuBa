%**************************************************************************
% Author: Michael Meindl
% Date: 28.3.2016
% Summary: Initialisiert die nötigen Werte für die Simulation in Simulink.
% Anschließend wird eine Population erzeugt und deren Evolution
% durchgeführt.
%**************************************************************************

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

population = CPopulation(20, 0.5, 50, 0.02, -0.02, 2, 0);
population.run(10);
fittest = population.getFittestChromosom();
