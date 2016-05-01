%**************************************************************************
% Author: Michael Meindl
% Date: 25.3.2016
% Summary: Berechnet das Massentraegheitsmoment der Schungmasse in
%          Abhaenigkeit der Kantenlaenge und Seitentiefe.
% Units:   Das erste Argument enthält den Aussenradius in Meter.
%          Das zweite Argument enthält den Innenradius  in Meter.
%          Das dritte Argument enthaelt die Kantentiefe in Meter.
%          Das vierte Argument enthaelt die Kantenlaenge in Meter.
%          Der Rückgabewert ist das Massentraegheitsmoment.
%**************************************************************************


function [ O_w_A ] = calculateWheelMomentum( outerRadius, innerRadius, wheelDepth, cubeLength )
%Dichte Aluminium in [Kg/m^3]
p_alu = 2.7e+3;
massWheel = (pi*(outerRadius.^2 - innerRadius.^2)) * wheelDepth * p_alu;
O_w_A = massWheel .* (outerRadius.^2 + innerRadius.^2) / 2 + massWheel .* cubeLength.^2 / 4;
end

