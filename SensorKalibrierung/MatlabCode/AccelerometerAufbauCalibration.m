%17.05 Messung1, phiK = -45, x_soll = -g*sin(45), y_soll = -g*sin(45)
%Erster Durchlauf mit invertierter x und y Achse
%x1SignedOffset = -5719
%y1SignedOffset = -4118
%z1SignedOffset = -2995
%x2SignedOffset = -5593
%y2SignedOffset = -3969
%z2SignedOffset = -3139
%17.05 Messung2, phiK = 45, x_soll = g*sin(45), y_soll = -g*sin(45)
%x1SignedOffset = -3141
%y1SignedOffset = -813
%z1SignedOffset = -380
%x2SignedOffset = -1794
%y2SignedOffset = 781
%z2SignedOffset = 807
%29.05 Messung1, phiK = 45, x_soll = g*sin(45), y_soll = -g*sin(45)
%x1SignedOffset = -2546;
%y1SignedOffset = 258;
%z1SignedOffset = -87;
%x2SignedOffset = -1772;
%y2SignedOffset = 538;
%z2SignedOffset = -46;

m = 10000;
x1RawValues      = zeros(1,m);
x1SignedValues   = zeros(1,m);
x1GValues        = zeros(1,m);

y1RawValues      = zeros(1,m);
y1SignedValues   = zeros(1,m);
y1GValues        = zeros(1,m);

z1RawValues      = zeros(1,m);
z1SignedValues   = zeros(1,m);
z1GValues        = zeros(1,m);

x2RawValues      = zeros(1,m);
x2SignedValues   = zeros(1,m);
x2GValues        = zeros(1,m);

y2RawValues      = zeros(1,m);
y2SignedValues   = zeros(1,m);
y2GValues        = zeros(1,m);

z2RawValues      = zeros(1,m);
z2SignedValues   = zeros(1,m);
z2GValues        = zeros(1,m);

accelSignedToGFactor = 0.061e-3; 

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
    
    %Evaluate the x-Data
    accX1Raw          = uint16(sensor1Acc(1)) + bitshift(uint16(sensor1Acc(2)),8);
    x1RawValues(i)    = accX1Raw;
    accX1Signed       = -double(typecast(accX1Raw, 'int16'));
    x1SignedValues(i) = accX1Signed;
    x1GValue          = accX1Signed * accelSignedToGFactor;
    x1GValues(i)      = x1GValue;
    accX2Raw          = uint16(sensor2Acc(1)) + bitshift(uint16(sensor2Acc(2)),8);
    x2RawValues(i)    = accX2Raw;
    accX2Signed       = -double(typecast(accX2Raw, 'int16'));
    x2SignedValues(i) = accX2Signed;
    x2GValue          = accX2Signed * accelSignedToGFactor;
    x2GValues(i)      = x2GValue;
    %Evaluate the y-Data
    accY1Raw             = uint16(sensor1Acc(3)) + bitshift(uint16(sensor1Acc(4)),8);
    y1RawValues(i)       = accY1Raw;
    accY1Signed          = -double(typecast(accY1Raw, 'int16'));
    y1SignedValues(i)    = accY1Signed;
    y1GValue             = accY1Signed * accelSignedToGFactor;
    y1GValues(i)         = y1GValue;
    accY2Raw             = uint16(sensor2Acc(3)) + bitshift(uint16(sensor2Acc(4)),8);
    y2RawValues(i)       = accY2Raw;
    accY2Signed          = -double(typecast(accY2Raw, 'int16'));
    y2SignedValues(i)    = accY2Signed;
    y2GValue             = accY2Signed * accelSignedToGFactor;
    y2GValues(i)         = y2GValue;
    %Evaluate the z-Data
    accZ1Raw             = uint16(sensor1Acc(5)) + bitshift(uint16(sensor1Acc(6)),8);
    z1RawValues(i)       = accZ1Raw;
    accZ1Signed          = double(typecast(accZ1Raw, 'int16'));
    z1SignedValues(i)    = accZ1Signed;
    z1GValue             = accZ1Signed * accelSignedToGFactor;
    z1GValues(i)         = z1GValue;
    accZ2Raw             = uint16(sensor2Acc(5)) + bitshift(uint16(sensor2Acc(6)),8);
    z2RawValues(i)       = accZ2Raw;
    accZ2Signed          = double(typecast(accZ2Raw, 'int16'));
    z2SignedValues(i)    = accZ2Signed;
    z2GValue             = accZ2Signed * accelSignedToGFactor;
    z2GValues(i)         = z2GValue;
end

x1SignedMean     = mean(x1SignedValues)
x1GMean          = mean(x1GValues)
x1GOffset        = sind(45) - x1GMean
x1SignedOffset   = round(x1GOffset/accelSignedToGFactor)

x2SignedMean     = mean(x2SignedValues)
x2GMean          = mean(x2GValues)
x2GOffset        = sind(45) - x2GMean
x2SignedOffset   = round(x2GOffset/accelSignedToGFactor)

y1SignedMean     = mean(y1SignedValues)
y1GMean          = mean(y1GValues)
y1GOffset        = -sind(45) - y1GMean
y1SignedOffset   = round(y1GOffset/accelSignedToGFactor)

y2SignedMean     = mean(y2SignedValues)
y2GMean          = mean(y2GValues)
y2GOffset        = -sind(45) - y2GMean
y2SignedOffset   = round(y2GOffset/accelSignedToGFactor)

z1SigendMean     = mean(z1SignedValues)
z1GMean          = mean(z1GValues)
z1GOffset        = - z1GMean
z1SignedOffset   = round(z1GOffset/accelSignedToGFactor)

z2SigendMean     = mean(z2SignedValues)
z2GMean          = mean(z2GValues)
z2GOffset        = - z2GMean
z2SignedOffset   = round(z2GOffset/accelSignedToGFactor)