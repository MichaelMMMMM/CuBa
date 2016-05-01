%**************************************************************************
% Author: Michael Meindl
% Date: 25.3.2016
% Summary: Berechnet den Verlauf des minimalen Motormoment über den
% Ausfallwinkelverlauf. Es wird angenommen, dass die
% Winkelgeschwindigkeiten gleich null sind.
% Examplirsch werden die Verläufe für die folgenden Werte berechnet:
% - Kantenlänge: 15cm, Breite: 3mm, Schwungradradien: 5cm, 4.5cm 
% - Kantenlänge: 20cm, Breite 3mm, Schwungradien: 7.5cm, 7cm
% - Kantenlänge: 25cm, Breite 3mm, Schwungradien: 10cm, 9.5cm
%**************************************************************************

%Ausfallwinkelvektor in rad
phib = 0:0.1:20;
phib = degtorad(phib);
%Vektor der Kantenlänge
edgeLength = [0.15 0.20 0.25];
%Vektor der Außenradien
outerRadius = [0.05 0.075 0.10];
%Vektor der Innenradien
innerRadius = [0.045 0.07 0.095];

%Vektor der Körpermassen
m_b = calculateBodyMass(edgeLength, 0.005);
%Vektor der Schwungmassen
m_w = calculateWheelMass(outerRadius, innerRadius, 0.02);

%Verlauf des Minimalmoment der verschiedenen Geometrien
T_M_0 = (m_b(1)*edgeLength(1)/2 + m_w(1)*edgeLength(1)/2) * 9.81 * sin(phib);
T_M_1 = (m_b(2)*edgeLength(2)/2 + m_w(2)*edgeLength(2)/2) * 9.81 * sin(phib);
T_M_2 = (m_b(3)*edgeLength(3)/2 + m_w(3)*edgeLength(3)/2) * 9.81 * sin(phib);

plot(radtodeg(phib), T_M_0, radtodeg(phib), T_M_1, radtodeg(phib), T_M_2);
legend('Kantenlänge: 15cm, Außenradius Schwungmasse: 5cm',...
       'Kantenlänge: 20cm, Außenradius Schwungmasse: 7.5cm',...
       'Kantenlänge: 25cm, Außenradius Schwungmasse: 10cm');
grid;
xlabel('Winkel in Grad');
ylabel('Minimales Motormoment in Nm');

%Verlauf des Minimalmoment für Kantenlänge 15cm mit verschiedenen
%Schwungmassen
m_b = m_b(1);
outerRadius = [0.05 0.04 0.03];
innerRadius = [0.045 0.035 0.025];
m_w = calculateWheelMass(outerRadius, innerRadius, 0.02);

T_M_0 = (m_b*edgeLength(1)/2 + m_w(1)*edgeLength(1)/2) * 9.81 * sin(phib);
T_M_1 = (m_b*edgeLength(1)/2 + m_w(2)*edgeLength(1)/2) * 9.81 * sin(phib);
T_M_2 = (m_b*edgeLength(1)/2 + m_w(3)*edgeLength(1)/2) * 9.81 * sin(phib);

figure;
plot(radtodeg(phib), T_M_0, radtodeg(phib), T_M_1, radtodeg(phib), T_M_2);
legend('Kantenlänge: 15cm, Außenradius Schwungmasse: 5cm',...
       'Kantenlänge: 15cm, Außenradius Schwungmasse: 4cm',...
       'Kantenlänge: 15cm, Außenradius Schwungmasse: 3cm');
grid;
xlabel('Winkel in Grad');
ylabel('Minimales Motormoment in Nm');