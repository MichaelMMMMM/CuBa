load('Messergebnisse\phiK45_rawValues');
phiK45_meanX1 = meanX1_raw;
phiK45_meanX2 = meanX2_raw;
phiK45_meanY1 = meanY1_raw;
phiK45_meanY2 = meanY2_raw;
load('Messergebnisse\phiK30_rawValues');
phiK30_meanX1 = meanX1_raw;
phiK30_meanX2 = meanX2_raw;
phiK30_meanY1 = meanY1_raw;
phiK30_meanY2 = meanY2_raw;
load('Messergebnisse\phiK15_rawValues');
phiK15_meanX1 = meanX1_raw;
phiK15_meanX2 = meanX2_raw;
phiK15_meanY1 = meanY1_raw;
phiK15_meanY2 = meanY2_raw;
load('Messergebnisse\phiK0_rawValues');
phiK0_meanX1 = meanX1_raw;
phiK0_meanX2 = meanX2_raw;
phiK0_meanY1 = meanY1_raw;
phiK0_meanY2 = meanY2_raw;
load('Messergebnisse\phiK-15_rawValues');
phiKm15_meanX1 = meanX1_raw;
phiKm15_meanX2 = meanX2_raw;
phiKm15_meanY1 = meanY1_raw;
phiKm15_meanY2 = meanY2_raw;
load('Messergebnisse\phiK-30_rawValues');
phiKm30_meanX1 = meanX1_raw;
phiKm30_meanX2 = meanX2_raw;
phiKm30_meanY1 = meanY1_raw;
phiKm30_meanY2 = meanY2_raw;
load('Messergebnisse\phiK-45_rawValues');
phiKm45_meanX1 = meanX1_raw;
phiKm45_meanX2 = meanX2_raw;
phiKm45_meanY1 = meanY1_raw;
phiKm45_meanY2 = meanY2_raw;

phiKValues   = [-45 -30 -15 0 15 30 45];
x1MeanValues = [phiKm45_meanX1, phiKm30_meanX1, phiKm15_meanX1,...
                phiK0_meanX1, phiK15_meanX1, phiK30_meanX1, phiK45_meanX1];
x2MeanValues = [phiKm45_meanX2, phiKm30_meanX2, phiKm15_meanX2,...
                phiK0_meanX2, phiK15_meanX2, phiK30_meanX2, phiK45_meanX2];
y1MeanValues = [phiKm45_meanY1, phiKm30_meanY1, phiKm15_meanY1,...
                phiK0_meanY1, phiK15_meanY1, phiK30_meanY1, phiK45_meanY1];
y2MeanValues = [phiKm45_meanY2, phiKm30_meanY2, phiKm15_meanY2,...
                phiK0_meanY2, phiK15_meanY2, phiK30_meanY2, phiK45_meanY2]; 

%Plot the Raw-Values
phiK = [-45 -30 -15 0 15 30 45];
figure;
plot(phiK, x1MeanValues); grid;
xlabel('\phi_K in Grad'); ylabel('X1 Rohwert');
title('Rohwertverlauf X1');
print('X1_rawvalues', '-depsc');
figure;
plot(phiK, y1MeanValues); grid;
xlabel('\phi_K in Grad'); ylabel('Y1 Rohwert');
title('Rohwertverlauf Y1');
print('Y1_rawvalues', '-depsc');
figure;
plot(phiK, x2MeanValues); grid;
xlabel('\phi_K in Grad'); ylabel('X2 Rohwert');
title('Rohwertverlauf X2');
print('X2_rawvalues', '-depsc');
figure;
plot(phiK, y2MeanValues); grid;
xlabel('\phi_K in Grad'); ylabel('Y2 Rohwert');
title('Rohwertverlauf Y2');
print('Y2_rawvalues', '-depsc');
            
%Polynomfitting for X1 and X2
xTargetVector = 9.81* sind(phiK);
x1Pol1 = fit(x1MeanValues', xTargetVector', 'poly1');
x1Pol1Corrected = x1MeanValues*x1Pol1.p1 + x1Pol1.p2;
x1ErrorVector   = x1Pol1Corrected - xTargetVector;
x2Pol1 = fit(x2MeanValues', xTargetVector', 'poly1');
x2Pol1Corrected = x2MeanValues*x2Pol1.p1 + x2Pol1.p2;
x2ErrorVector   = x2Pol1Corrected - xTargetVector;
%Polynomfitting for Y1 and Y2
yTargetVector = -9.81* cosd(phiK);
y1Pol1 = fit(y1MeanValues', yTargetVector', 'poly1');
y1Pol1Corrected = y1MeanValues*y1Pol1.p1 + y1Pol1.p2;
y1ErrorVector   = y1Pol1Corrected - yTargetVector;
y2Pol1 = fit(y2MeanValues', yTargetVector', 'poly1');
y2Pol1Corrected = y2MeanValues*y2Pol1.p1 + y2Pol1.p2;
y2ErrorVector   = y2Pol1Corrected - yTargetVector;

%Plot the results
figure;
plot(phiK, xTargetVector, phiK, x1Pol1Corrected, phiK, x1ErrorVector);
xlabel('\phi_K in Grad'); ylabel('Beschleunigung in m/s^2 X1'); 
title('Korrigierte Beschleunigungswerte X1'); grid;
legend('Sollwert', 'Polynom 1. Ordnung', 'Abweichung');
print('X1_mean_correction', '-depsc');
figure;
plot(phiK, xTargetVector, phiK, x2Pol1Corrected, phiK, x2ErrorVector);
xlabel('\phi_K in Grad'); ylabel('Beschleunigung in m/s^2 X2'); 
title('Korrigierte Beschleunigungswerte X2'); grid;
legend('Sollwert', 'Polynom 1. Ordnung', 'Abweichung');
print('X2_mean_correction', '-depsc');
figure;
plot(phiK, yTargetVector, phiK, y1Pol1Corrected, phiK, y1ErrorVector);
xlabel('\phi_K in Grad'); ylabel('Beschleunigung in m/s^2 Y1'); 
title('Korrigierte Beschleunigungswerte Y1'); grid;
legend('Sollwert', 'Polynom 1. Ordnung', 'Abweichung');
print('Y1_mean_correction', '-depsc');
figure;
plot(phiK, yTargetVector, phiK, y2Pol1Corrected, phiK, y2ErrorVector);
xlabel('\phi_K in Grad'); ylabel('Beschleunigung in m/s^2 Y2'); 
title('Korrigierte Beschleunigungswerte Y2'); grid;
legend('Sollwert', 'Polynom 1. Ordnung', 'Abweichung');
print('Y2_mean_correction', '-depsc');

save('Messergebnisse\polyApproximation',...
     'x1Pol1','x2Pol1', 'y1Pol1', 'y2Pol1');