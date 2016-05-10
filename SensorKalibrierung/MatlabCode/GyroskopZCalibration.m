% Datum: 10.5.16
% Autor: Michael Meindl
% Programm zur Kalibrierung des Gyroskop um die Z-Achse
% Es werden 10000 Messwerte aufgenommen
% Der Z-Sollwert ist 0dps, durch die Abweichung des Istwert wird der Offset
% bestimmt
%
% Messergebnis (Z-Achse) (10.5.16)
% Durchgeführt mit Kalibriereinrichtung
% zSignedMean   = 54.7790
% zDPSMean      = 0.4793
% yGOffset      = -0.4793
% zSignedOffset = -55

m = 10000;
zRawValues       = zeros(1,m);
zSignedValues    = zeros(1,m);
zDPSValues       = zeros(1,m);

gyroSignedToDPSFactor = 8.75e-3;

for i = 1:1:m
    while(serialInterface.BytesAvailable < 36)
        ;   %Wait for a new databatch to be available
    end
    
    %Read the Sensor-Data from the COM-Port
    sensor1Acc = fread(serialInterface, 6);
    sensor1Gyr = fread(serialInterface, 6);
    sensor1Mag = fread(serialInterface, 6);
    
    %Get the raw binary x-Data
    gyrZ1Raw      = uint16(sensor1Gyr(5)) + bitshift(uint16(sensor1Gyr(6)),8);
    zRawValues(i) = gyrZ1Raw;
    gyrZ1Signed   = double(typecast(gyrZ1Raw, 'int16'));
    zSignedValues(i) = gyrZ1Signed;
    zDPSValue = gyrZ1Signed * gyroSignedToDPSFactor;
    zDPSValues(i) = zDPSValue;
end

zSignedMean     = mean(zSignedValues)
zDPSMean        = mean(zDPSValues)
zDPSOffset      = 0 - zDPSMean
zSignedOffset   = round(zDPSOffset/gyroSignedToDPSFactor)
