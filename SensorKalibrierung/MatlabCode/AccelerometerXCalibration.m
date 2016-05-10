% Datum: 10.5.16
% Autor: Michael Meindl
% Programm zur Kalibrierung des Beschleunigungssensor in der X-Achse
% Es werden 10000 Messwerte aufgenommen
% Der X-Sollwert ist 1g, durch die Abweichung des Istwert wird der Offset
% bestimmt
%
% Messergebnis (X-Achse-Sensor entgegen der Gravitationsrichtung) (10.5.16)
% Durchgeführt mit Kalibriereinrichtung
% xSignedMean   = 1.5057e+4
% xGMean        = 0.9185
% xGOffset      = 0.0815
% xSignedOffset = 1336
% Messergebnis (X-Achse-Sensor mit der Gravitationsrichtung) (10.5.16)
% Durchgeführt mit Kalibriereinrichtung
% xSignedMean   = -1.977e+4
% xGMean        = -1.0966
% xGOffset      = 2.0966
% xSignedOffset = 34371

m = 10000;
xRawValues      = zeros(1,m);
xSignedValues   = zeros(1,m);
xGValues       = zeros(1,m);

accelSignedToGFactor = 0.061e-3; 

for i = 1:1:m
    while(serialInterface.BytesAvailable < 36)
        ;   %Wait for a new databatch to be available
    end
    
    %Read the Sensor-Data from the COM-Port
    sensor1Acc = fread(serialInterface, 6);
    sensor1Gyr = fread(serialInterface, 6);
    sensor1Mag = fread(serialInterface, 6);
    
    %Get the raw binary x-Data
    accX1Raw      = uint16(sensor1Acc(1)) + bitshift(uint16(sensor1Acc(2)),8);
    xRawValues(i) = accX1Raw;
    accX1Signed   = double(typecast(accX1Raw, 'int16'));
    xSignedValues(i) = accX1Signed;
    xGValue = accX1Signed * accelSignedToGFactor;
    xGValues(i) = xGValue;
end

xSignedMean     = mean(xSignedValues)
xGMean          = mean(xGValues)
xGOffset        = 1 - xGMean
xSignedOffset   = round(xGOffset/accelSignedToGFactor)
