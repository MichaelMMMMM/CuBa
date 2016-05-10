% Datum: 10.5.16
% Autor: Michael Meindl
% Programm zur Kalibrierung des Beschleunigungssensor in der Y-Achse
% Es werden 10000 Messwerte aufgenommen
% Der Y-Sollwert ist 1g, durch die Abweichung des Istwert wird der Offset
% bestimmt
%
% Messergebnis (Y-Achse-Sensor entgegen der Gravitationsrichtung) (10.5.16)
% Durchgeführt mit Kalibriereinrichtung
% ySignedMean   = 1.6293e+4
% yGMean        = 0.9939
% yGOffset      = 0.0061
% ySignedOffset = 100
% Messergebnis (Y-Achse-Sensor mit der Gravitationsrichtung) (10.5.16)
% Durchgeführt mit Kalibriereinrichtung
% ySignedMean   = -1.6085e+4
% yGMean        = -0.9812
% yGOffset      = 1.9812
% ySignedOffset = 32479

m = 10000;
yRawValues      = zeros(1,m);
ySignedValues   = zeros(1,m);
yGValues       = zeros(1,m);

accelSignedToGFactor = 0.061e-3; 

for i = 1:1:m
    while(serialInterface.BytesAvailable < 36)
        ;   %Wait for a new databatch to be available
    end
    
    %Read the Sensor-Data from the COM-Port
    sensor1Acc = fread(serialInterface, 6);
    sensor1Gyr = fread(serialInterface, 6);
    sensor1Mag = fread(serialInterface, 6);
    
    %Get the raw binary y-Data
    accy1Raw      = uint16(sensor1Acc(3)) + bitshift(uint16(sensor1Acc(4)),8);
    yRawValues(i) = accy1Raw;
    accy1Signed   = double(typecast(accy1Raw, 'int16'));
    ySignedValues(i) = accy1Signed;
    yGValue = accy1Signed * accelSignedToGFactor;
    yGValues(i) = yGValue;
end

ySignedMean     = mean(ySignedValues)
yGMean          = mean(yGValues)
yGOffset        = 1 - yGMean
ySignedOffset   = round(yGOffset/accelSignedToGFactor)
