%**************************************************************************
% Author: Michael Meindl
% Date: 25.3.2016
% Summary: Berechnet das Massentraegheitsmoment der Wuerfelseite in
%          Abhaenigkeit der Kantenlaenge und Seitentiefe.
% Units:   Das erste Argument enthält die Kantenlänge in Meter.
%          Das zweite Argument enthält die Tiefe des Körper in Meter.
%          Der Rückgabewert ist das Massentraegheitsmoment.
%**************************************************************************

function [ O_G_A ] = calculateBodyMomentum( cubeLength, cubeDepth )
%Dichte Aluminium in [Kg/m^3]
p_alu = 2.7e+3;
massCube = cubeLength.^2 .* cubeDepth * p_alu;
%Massentraegheitsmoment des Quader um (A)
O_R_A = massCube .* cubeLength .^2 * 2 / 3;
%Abstand der Bohrungsmitte zur Kante
l_BK = 0.015;
%Radius der Bohrungen
r_B = 0.008;
%Masse der Bohrung
m_B = pi * r_B^2 .* cubeDepth * p_alu;
%Massentraegheitsmoment der Bohrung 1
O_B1_A = m_B .* r_B^2 / 2 + 2 .* m_B * l_BK^2;
%Massentraegheitsmoment der Bohrung 2 und 3
O_B23_A = m_B .* r_B^2 / 2 + m_B .* (l_BK^2 + (cubeLength - l_BK).^2);
%Massentraegheitsmoment der Bohrung 4
O_B4_A = m_B .* r_B^2 / 2 + 2 * m_B .* (cubeLength - l_BK).^2;
% Laenge der Dreicke
l_D = cubeLength - 4 .* l_BK;
%Masse der Dreiecke
m_D = l_D.^2 / 4  .* cubeDepth * p_alu;
%Massentraegheitsmoment der Dreiecke 1 und 2
O_D12_A = m_D .* l_D.^2 / 18 + m_D .* (cubeLength.^2 / 4 + (l_BK + l_D./6).^2);
%Massentraegheitsmoment der Dreiecke 3 und 4
O_D34_A = m_D .* l_D.^2 / 18 + m_D .* (cubeLength.^2 / 4 + (cubeLength - l_BK - l_D/6).^2);
%Massentraegheitsmoment der Wuerfelseite
O_G_A = O_R_A - O_B1_A - 2 .* O_B23_A - O_B4_A - 2 .* O_D12_A - 2 .* O_D34_A;
end

