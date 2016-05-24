% Autor : Michael Meindl
% Datum : 18.05.2016
% Kalibrierung der beiden Sensoren auf dem Prototyp, ermittelt die Rohwerte
% in allen Achsen

m = 100;
x1Values = zeros(1,m);
y1Values = zeros(1,m);
z1Values = zeros(1,m);
x2Values = zeros(1,m);
y2Values = zeros(1,m);
z2Values = zeros(1,m);

flushinput(serialInterface);

for i = 1:1:m
    while(serialInterface.BytesAvailable < 36)
        ;   %Wait for a new databatch to be available
    end

    %Read the Sensor-Data from the COM-Port
    sensor1Acc = fread(serialInterface, 6);
    sensor1Gyr = fread(serialInterface, 6);
    sensor1Mag = fread(serialInterface, 6);

    sensor2Acc = fread(serialInterface, 6);
    sensor2Gyr = fread(serialInterface, 6);
    sensor2Mag = fread(serialInterface, 6); 
    
    accX1Raw      = uint16(sensor1Acc(1)) + bitshift(uint16(sensor1Acc(2)),8);
    accX2Raw      = uint16(sensor2Acc(1)) + bitshift(uint16(sensor2Acc(2)),8);
    accY1Raw      = uint16(sensor1Acc(3)) + bitshift(uint16(sensor1Acc(4)),8);
    accY2Raw      = uint16(sensor2Acc(3)) + bitshift(uint16(sensor2Acc(4)),8);
    accZ1Raw      = uint16(sensor1Acc(5)) + bitshift(uint16(sensor1Acc(6)),8);
    accZ2Raw      = uint16(sensor2Acc(5)) + bitshift(uint16(sensor2Acc(6)),8);

    accX1Signed = -double(typecast(accX1Raw, 'int16'));
    accX2Signed = -double(typecast(accX2Raw, 'int16'));
    accY1Signed = -double(typecast(accY1Raw, 'int16'));
    accY2Signed = -double(typecast(accY2Raw, 'int16'));
    accZ1Signed = -double(typecast(accZ1Raw, 'int16'));
    accZ2Signed = -double(typecast(accZ2Raw, 'int16'));
    
    x1Values(i) = accX1Signed;
    x2Values(i) = accX2Signed;
    y1Values(i) = accY1Signed;
    y2Values(i) = accY2Signed;
    z1Values(i) = accZ1Signed;
    z2Values(i) = accZ2Signed;
end

x1Mean = round(mean(x1Values));
x2Mean = round(mean(x2Values));
y1Mean = round(mean(y1Values));
y2Mean = round(mean(y2Values));
z1Mean = round(mean(z1Values));
z2Mean = round(mean(z2Values));

meanArray = [x1Mean y1Mean z1Mean; x2Mean y2Mean z2Mean]
