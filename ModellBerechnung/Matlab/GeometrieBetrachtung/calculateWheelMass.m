%**************************************************************************
% Author: Michael Meindl
% Date: 25.3.2016
% Summary: Berechnet die Masse des Schwungrad in Abhängigkeit der Radien,
%          es wird eine vereinfachte Geometrie zur Voruntersuchung für die
%          Konstruktion verwendet.
% Units:   Das erste Argument enthält den Aussenradius in Meter.
%          Das zweite Argument enthält den Innenradius in Meter.
%          Das dritte Argument enthält die Radtiefe in Meter.
%          Der Rückgabewert ist die Masse des Körper in Kg.
%**************************************************************************

function [ m_w ] = calculateWheelMass( outerRadius, innerRadius, wheelDepth )
    %Flaeche der Schwungmasse in [m^2]
    areaMomentumWheel = pi .* (outerRadius.^2 - innerRadius.^2) + 3 * innerRadius * 0.01;
    %Dichte Aluminium in [Kg/m^3]
    p_alu = 2.7e+3;
    %Volumen der Schwungmasse in [m^3]
    volumeMomentumWheel = areaMomentumWheel .* wheelDepth;
    %Masse der Schwungmasse in [kg]
    m_w = p_alu * volumeMomentumWheel;
end

