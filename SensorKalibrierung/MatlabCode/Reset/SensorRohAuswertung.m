%30.05.2016

phiK = -15;

m = 10000;
deltaT = 5e-3;
time = 0:deltaT:(m-1)*deltaT;
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

%Calculate the variance and standard deviation of the accel (rawValues)
%X1-Values
varX1_raw       = var(x1SignedValues);
sdX1_raw        = sqrt(varX1_raw);
meanX1_raw      = mean(x1SignedValues);
%Y1-Values
varY1_raw       = var(y1SignedValues);
sdY1_raw        = sqrt(varY1_raw);
meanY1_raw      = mean(y1SignedValues);
%X2-Values
varX2_raw       = var(x2SignedValues);
sdX2_raw        = sqrt(varX2_raw);
meanX2_raw      = mean(x2SignedValues);
%Y2-Values
varY2_raw       = var(y2SignedValues);
sdY2_raw        = sqrt(varY2_raw);
meanY2_raw      = mean(y2SignedValues);

%Plot the Values
meanX1_rawVector = ones(1,m) * meanX1_raw;
meanX2_rawVector = ones(1,m) * meanX2_raw;
meanY1_rawVector = ones(1,m) * meanY1_raw;
meanY2_rawVector = ones(1,m) * meanY2_raw;
%Plot X1-RawValues
figure;
plot(time, x1SignedValues, time, meanX1_rawVector);
grid;
xlabel('Zeit in Sekunden');
ylabel('X-Beschleunigung Rohwert');
legend('Roh-Werte', 'Mittelwert');
title(strcat('X1-Rohwerte bei \phi_K = ', num2str(phiK)));
print(strcat('phiK', num2str(phiK), '_x1_raw'), '-depsc');
%Plot X2-RawValues
figure;
plot(time, x2SignedValues, time, meanX2_rawVector);
grid;
xlabel('Zeit in Sekunden');
ylabel('X-Beschleunigung Rohwert');
legend('Roh-Werte', 'Mittelwert');
title(strcat('X2-Rohwerte bei \phi_K = ', num2str(phiK)));
print(strcat('phiK', num2str(phiK), '_x2_raw'), '-depsc');
%Plot Y1-RawValues
figure;
plot(time, y1SignedValues, time, meanY1_rawVector);
grid;
xlabel('Zeit in Sekunden');
ylabel('Y-Beschleunigung Rohwert');
legend('Roh-Werte', 'Mittelwert');
title(strcat('Y1-Rohwerte bei \phi_K = ', num2str(phiK)));
print(strcat('phiK', num2str(phiK), '_y1_raw'), '-depsc');
%Plot Y2-RawValues
figure;
plot(time, y2SignedValues, time, meanY2_rawVector);
grid;
xlabel('Zeit in Sekunden');
ylabel('Y-Beschleunigung Rohwert');
legend('Roh-Werte', 'Mittelwert');
title(strcat('Y2-Rohwerte bei \phi_K = ', num2str(phiK)));
print(strcat('phiK', num2str(phiK), '_y2_raw'), '-depsc');

saveFilename = strcat('Messergebnisse\phiK', num2str(phiK), '_rawValues');
save(saveFilename,...
     'meanX1_raw',...
     'meanX2_raw',...
     'meanY1_raw',...
     'meanY2_raw',...
     'x1SignedValues',...
     'x2SignedValues',...
     'y1SignedValues',...
     'y2SignedValues');