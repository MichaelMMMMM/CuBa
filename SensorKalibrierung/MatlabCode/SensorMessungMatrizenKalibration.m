% Datum: 11.5.16
% Autor: Michael Meindl
% Programm zum Auslesen der aktuellen Sensorwerte, Kalibrierung über
% Matrizen

M1 = [0.995, 0.068, -0.021;-0.072,1.011, -0.027;0.028, 0.043, 0.994];
B1 = [1890.934; -112.03;-163.762];
M2 = [1.012, -0.028, 0.019;0.015, 0.988, -0.033;-0.005,0.039, 1.011];
B2 = [1916.211;-303.049;328.907];

accelSignedToGFactor = 0.061e-3; 

r_1 = 168e-3;
r_2 = 15.5e-3;
mu  = r_1 / r_2;

g = 9.81;

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

%Für invertierung, signed-Wert * -1 und offset subtrahieren
acc1 = M1 * ([accX1Signed;accY1Signed;accZ1Signed] - B1);
accX1Off = acc1(1);
accY1Off = acc1(2);
accZ1Off = acc1(3);

acc2 = M2 * ([accX2Signed;accY2Signed;accZ2Signed] - B2);
accX2Off = acc2(1);
accY2Off = acc2(2);
accZ2Off = acc2(3);

x1G         = accX1Off * accelSignedToGFactor;
x2G         = accX2Off * accelSignedToGFactor;
y1G         = accY1Off * accelSignedToGFactor;
y2G         = accY2Off * accelSignedToGFactor;
z1G         = accZ1Off * accelSignedToGFactor;
z2G         = accZ2Off * accelSignedToGFactor;

%Winkelschätzung
phiK   = -atan((x1G - mu*x2G)/(y1G - mu*y2G));
thetaK = asin((z1G - mu*z2G)/(g*(1-mu)));

phiK_deg   = radtodeg(phiK)
thetaK_deg = radtodeg(thetaK)

phiK1_dd = (x1G * g - g * sin(phiK) * cos(thetaK)) / r_1;
phiK2_dd = (x2G * g - g * sin(phiK) * cos(thetaK)) / r_2;

phiK1_dd_deg = radtodeg(phiK1_dd)
phiK2_dd_deg = radtodeg(phiK2_dd)