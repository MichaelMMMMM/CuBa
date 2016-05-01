%**************************************************************************
% Author: Michael Meindl
% Date: 25.3.2016
% Summary: Berechnet die benoetigten Radgeschwindigkeiten um den Wuerfel 
%          aufzustellen.
% Examplirsch werden die Verläufe für die folgenden Werte berechnet:
% - Kantenlänge: 15cm, Breite: 3mm, Schwungradradien: 5cm, 4.5cm 
% - Kantenlänge: 20cm, Breite 3mm, Schwungradien: 7.5cm, 7cm
% - Kantenlänge: 25cm, Breite 3mm, Schwungradien: 10cm, 9.5cm
%**************************************************************************

%Vektor der Kantenlänge
edgeLength = [0.15 0.20 0.25];
%Vektor der Außenradien
outerRadius = [0.05 0.075 0.10];
%Vektor der Innenradien
innerRadius = [0.045 0.07 0.095];

%Vektor der Körpermassen
m_b = calculateBodyMass(edgeLength, 0.03);
%Vektor der Schwungmassen
m_w = calculateWheelMass(outerRadius, innerRadius, 0.02);
%Vektor der Körperträgheitsmomente
O_b = calculateBodyMomentum(edgeLength, 0.03);
%Vektor der Schwungmassenträgheitsmomente
O_w = calculateWheelMomentum(outerRadius, innerRadius, 0.02, edgeLength);

%Vektor der Winkelgeschwindigkeiten
phi_w = (m_b + m_w) .* edgeLength/2 * 9.81 * (2-sqrt(2)) .* (O_w + O_b + m_w .* edgeLength.^2) ./ O_w.^2;