%**************************************************************************
% Author: Michael Meindl
% Date: 27.3.2016
% Summary: Initialisiert die nötigen Werte für die Simulation in Simulink.
%**************************************************************************

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

% K_P = 3.9208;
% K_D = 2.0107;
% K_I = 5;
K_D = 1.8206;
K_I = 1.4006;
K_P = 6.4842;

sim('CubaModel');

subplot(3,1,1);
plot(tout, radtodeg(phi_K));
xlabel('Zeit in sec');
ylabel('phi_K in Grad');
grid;
subplot(3,1,2);
plot(tout, radtodeg(phi_K__d));
xlabel('Zeit in sec');
ylabel('phi_K_d in Grad/sec');
grid;
subplot(3,1,3);
plot(tout, radtodeg(phi_K__dd));
xlabel('Zeit in sec');
ylabel('phi_K_dd in Grad/sec^2');
grid;
figure;
plot(tout, T_M);
xlabel('Zeit in sec');
ylabel('T_M in Nm');
grid;

% figure;
% plot(tout, radtodeg(phi_b), tout, radtodeg(phi_b__d), tout, radtodeg(phi_b__dd));
% legend('phi_b', 'phi_b d', 'phi_b dd');
% grid;
% 
% figure;
% plot(tout, radtodeg(phi_w), tout, radtodeg(phi_w__d), tout, radtodeg(phi_w__dd));
% legend('phi_w', 'phi_w d', 'phi_w dd');
% grid;