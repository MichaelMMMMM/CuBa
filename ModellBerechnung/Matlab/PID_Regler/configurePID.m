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
l = 0.08455;
%Abstand Schwerpunkt des Körper zu (A)
l_b = 0.0751442;
%Anfangswinkel des Körpers
phi_b0 = degtorad(1);
%Anfangsgeschwindigkeit des Körpers
phi_b__d0 = degtorad(0);
%Anfagsnwinkel des Schwungrades
phi_w0 = degtorad(0);
%Anfangsgeschwindigkeit des Schwungrades
phi_w__d0 = degtorad(0);
%Masse des Körpers
m_b = 0.294;
%Masse des Schwungrades
m_w = 0.1298;
%Massentraegheitsmoment des Körpers um (A)
O_b_A = 3.3e-3;
%Massentraegheitsmoment des Schwungrades um (B)
O_w_B = 0.088e-3;
%Dynamischer Reibkoeffizient des Körpers
C_b = 2.1e-3;
%Dynamischer Reibkoeffizient des Schwungrades
C_w = 2.1268e-5;
%Massentraegheitsmoment des Gesamtsystem um (A)
O_G_A = O_b_A + m_w * l^2;

population = CPopulation(20, 0.5, 50, 0.5, -0.5, 10, 0);
population.run(10);
fittest = population.getFittestChromosom();
