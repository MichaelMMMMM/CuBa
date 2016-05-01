%**************************************************************************
% Author: Michael Meindl
% Date: 30.3.2016
% Summary: Berechnung der Übertragungsfunktion.
%**************************************************************************

%Gravitationsbeschleunigung
g = 9.81;
%Abstand von A zu B
l = 0.085;
%Abstand Schwerpunkt des Körper zu (A)
l_b = 0.075;
%Anfangswinkel des Körpers
phi_b0 = degtorad(0);
%Anfangsgeschwindigkeit des Körpers
phi_b__d0 = degtorad(0);
%Anfagsnwinkel des Schwungrades
phi_w0 = degtorad(0);
%Anfangsgeschwindigkeit des Schwungrades
phi_w__d0 = degtorad(0);
%Masse des Körpers
m_b = 0.419;
%Masse des Schwungrades
m_w = 0.204;
%Massentraegheitsmoment des Körpers um (A)
O_b_A = 3.34e-3;
%Massentraegheitsmoment des Schwungrades um (B)
O_w_B = 0.57e-3;
%Dynamischer Reibkoeffizient des Körpers
C_b = 1.02e-3;
%Dynamischer Reibkoeffizient des Schwungrades
C_w = 0.05e-3;
%Massentraegheitsmoment des Gesamtsystem um (A)
O_G_A = O_b_A + m_w * l^2;

syms t s
A = [0, 1, 0, 0;
    (m_b*l_b + m_w * l) * g/O_G_A, -C_b/O_G_A, 0, C_w/O_G_A;...
     0, 0, 0, 1;
     -g*(m_b*l_b + m_w*l)/O_G_A, C_b/O_G_A, 0, -C_w*(O_G_A + O_w_B)/(O_w_B*O_G_A)];
B = [0; -1/O_G_A; 0; (O_G_A + O_w_B)/(O_w_B*O_G_A)];
C = [1, 0, 0, 0];
D = 0;
Phis = inv(s*eye(4)-A);
H = C*Phis*B;
h = ilaplace(H,t);

x = 0:0.1:0.5;
hnum = subs(h,t,x);
plot(x,hnum);
grid;
