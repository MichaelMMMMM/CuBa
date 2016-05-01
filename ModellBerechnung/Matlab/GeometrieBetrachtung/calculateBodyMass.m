%**************************************************************************
% Author: Michael Meindl
% Date: 25.3.2016
% Summary: Berechnet die Masse des Würfels in Abhängigkeit der Kantenlänge,
%          es wird eine vereinfachte Geometrie zur Voruntersuchung für die
%          Konstruktion verwendet.
% Units:   Das erste Argument enthält die Kantenlänge in Meter.
%          Das zweite Argument enthält die Tiefe des Körper in Meter.
%          Der Rückgabewert ist die Masse des Körper in Kg.
%**************************************************************************

function [ m_b ] = calculateBodyMass( cubeLength, cubeDepth )
    l_K = cubeLength;
    t_K = cubeDepth;
    %Abstand der Dreiecke zum Mittelpunkt in [m]
    l_DM = 0.01;
    %Abstand der Rechtecke zur Kante in [m]
    l_RK = 0.0075;
    %Abstand der Bohrung zur Kante im [m]
    l_BK = 0.015;
    %Länge der Dreiecke in [m]
    l_D = l_K - 4 * l_BK;
    %Höhe der Dreiecke
    h_D = l_D / 2;
    %Höhe der Rechtecke
    h_R = l_K / 2 - l_DM - h_D - l_RK;
    %Radius der Bohrungen
    r_B = 0.008;
    %Fläche einer Bohrung
    A_B = pi * r_B^2;
    %Fläche eines Rechteckes
    A_R = l_D .* h_R;
    %Fläche eines Dreieckes
    A_D = l_D .* h_D / 2;
    %Fläche des Körpers
    A_K = l_K.^2 - 4 * (A_B + A_D + A_R);
    %Volumen des Koerper in [m^3]
    V_K = A_K .* t_K;
    %Dichte Aluminium in [Kg/m^3]
    p_alu = 2.7e+3;
    %Masse des Koerper in [Kg]
    m_b = p_alu * V_K;
end

