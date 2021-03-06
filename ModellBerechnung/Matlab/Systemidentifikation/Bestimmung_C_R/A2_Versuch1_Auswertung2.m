% Autor : Michael Meindl
% Datum : 18.05.2016
% Programm liest die Messwerte ein, berechnet aus dem Motorstrom das
% Drehmoment(PT1-Verhalten) und bestimmt �ber kleinsten Fehlerquadrate
% beta2 und alpha6, hierbei werden die Messreihen auf einen glatten Bereich
% bescr�nkt
%Ergebnisse (beta2, alpha6) (M1,M2,M3,M4,M5)
%    1.0e+03 *
% 
%     3.6811    4.9105    5.1342    5.7753    5.9157
%    -0.0001   -0.0001   -0.0001   -0.0001   -0.0002


%Messwerte auslesen
filename = 'C:\Users\ich\Desktop\CuBa_SVN\trunk\ModellBerechnung\Matlab\M1.csv';
delimiter = ';';
startRow = 186;
endRow = 461;
formatSpec = '%f%f%f%*s%*s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', delimiter, 'HeaderLines', startRow-1, 'ReturnOnError', false);
fclose(fileID);
M1_time = dataArray{:, 1};
M1_I_M = dataArray{:, 2};
M1_N_DPM = dataArray{:, 3};
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

M1_time   = M1_time * 1e-3;
M1_deltaT = (max(M1_time) - min(M1_time)) / size(M1_time,1);



deltaT      = M1_deltaT;
time        = M1_time;
strom       = M1_I_M;
drehzahl_si = degtorad(M1_N_DPM * 6);
sim('PT1_Test');

dataPoints = 0:1:size(M1_time,1)-1;
dataPoints = dataPoints';
timeFactor = size(T_M,1) / size(dataPoints,1);
T_M_Cut = T_M(round(timeFactor.*dataPoints)+1);
M1_phiR_d = degtorad(M1_N_DPM * 6);
M1_phiR_dd = 1./diff(M1_time(:,1)) .* diff(M1_phiR_d);
M1_phiR_dd = [M1_phiR_dd;M1_phiR_dd(size(M1_phiR_dd,1))];

A1 = horzcat(T_M_Cut, M1_phiR_d);
B1 = M1_phiR_dd;
x1 = A1\B1;

%Auswertung Messung 2
filename = 'C:\Users\ich\Desktop\CuBa_SVN\trunk\ModellBerechnung\Matlab\M2.csv';
delimiter = ';';
startRow = 61;
endRow = 261;
formatSpec = '%f%f%f%*s%*s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', delimiter, 'HeaderLines', startRow-1, 'ReturnOnError', false);
fclose(fileID);
M2_time = dataArray{:, 1};
M2_I_M = dataArray{:, 2};
M2_N_DPM = dataArray{:, 3};
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

M2_time   = M2_time * 1e-3;
M2_deltaT = (max(M2_time) - min(M2_time)) / size(M2_time,1);



deltaT = M2_deltaT;
time   = M2_time;
strom  = M2_I_M;
sim('PT1_Test');

dataPoints = 0:1:size(M2_time,1)-1;
dataPoints = dataPoints';
timeFactor = size(T_M,1) / size(dataPoints,1);
T_M_Cut = T_M(round(timeFactor.*dataPoints)+1);
M2_phiR_d = degtorad(M2_N_DPM * 6);
M2_phiR_dd = 1./diff(M2_time(:,1)) .* diff(M2_phiR_d);
M2_phiR_dd = [M2_phiR_dd;M2_phiR_dd(size(M2_phiR_dd,1))];

A2 = horzcat(T_M_Cut, M2_phiR_d);
B2 = M2_phiR_dd;
x2 = A2\B2;

%Auswertung Messung 3
filename = 'C:\Users\ich\Desktop\CuBa_SVN\trunk\ModellBerechnung\Matlab\M3.csv';
delimiter = ';';
startRow = 61;
endRow = 174;
formatSpec = '%f%f%f%*s%*s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', delimiter, 'HeaderLines', startRow-1, 'ReturnOnError', false);
fclose(fileID);
M3_time = dataArray{:, 1};
M3_I_M = dataArray{:, 2};
M3_N_DPM = dataArray{:, 3};
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

M3_time   = M3_time * 1e-3;
M3_deltaT = (max(M3_time) - min(M3_time)) / size(M3_time,1);



deltaT = M3_deltaT;
time   = M3_time;
strom  = M3_I_M;
sim('PT1_Test');

dataPoints = 0:1:size(M3_time,1)-1;
dataPoints = dataPoints';
timeFactor = size(T_M,1) / size(dataPoints,1);
T_M_Cut = T_M(round(timeFactor.*dataPoints)+1);
M3_phiR_d = degtorad(M3_N_DPM * 6);
M3_phiR_dd = 1./diff(M3_time(:,1)) .* diff(M3_phiR_d);
M3_phiR_dd = [M3_phiR_dd;M3_phiR_dd(size(M3_phiR_dd,1))];

A3 = horzcat(T_M_Cut, M3_phiR_d);
B3 = M3_phiR_dd;
x3 = A3\B3;

%Messung 4
filename = 'C:\Users\ich\Desktop\CuBa_SVN\trunk\ModellBerechnung\Matlab\M4.csv';
delimiter = ';';
startRow = 61;
endRow = 124;
formatSpec = '%f%f%f%*s%*s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', delimiter, 'HeaderLines', startRow-1, 'ReturnOnError', false);
fclose(fileID);
M4_time = dataArray{:, 1};
M4_I_M = dataArray{:, 2};
M4_N_DPM = dataArray{:, 3};
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

M4_time   = M4_time * 1e-3;
M4_deltaT = (max(M4_time) - min(M4_time)) / size(M4_time,1);



deltaT = M4_deltaT;
time   = M4_time;
strom  = M4_I_M;
sim('PT1_Test');

dataPoints = 0:1:size(M4_time,1)-1;
dataPoints = dataPoints';
timeFactor = size(T_M,1) / size(dataPoints,1);
T_M_Cut = T_M(round(timeFactor.*dataPoints)+1);
M4_phiR_d = degtorad(M4_N_DPM * 6);
M4_phiR_dd = 1./diff(M4_time(:,1)) .* diff(M4_phiR_d);
M4_phiR_dd = [M4_phiR_dd;M4_phiR_dd(size(M4_phiR_dd,1))];

A4 = horzcat(T_M_Cut, M4_phiR_d);
B4 = M4_phiR_dd;
x4 = A4\B4;

%Messung 5
filename = 'C:\Users\ich\Desktop\CuBa_SVN\trunk\ModellBerechnung\Matlab\M5.csv';
delimiter = ';';
startRow = 66;
endRow = 131;
formatSpec = '%f%f%f%*s%*s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', delimiter, 'HeaderLines', startRow-1, 'ReturnOnError', false);
fclose(fileID);
M5_time = dataArray{:, 1};
M5_I_M = dataArray{:, 2};
M5_N_DPM = dataArray{:, 3};
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

M5_time   = M5_time * 1e-3;
M5_deltaT = (max(M5_time) - min(M5_time)) / size(M5_time,1);



deltaT = M5_deltaT;
time   = M5_time;
strom  = M5_I_M;
sim('PT1_Test');

dataPoints = 0:1:size(M5_time,1)-1;
dataPoints = dataPoints';
timeFactor = size(T_M,1) / size(dataPoints,1);
T_M_Cut = T_M(round(timeFactor.*dataPoints)+1);
M5_phiR_d = degtorad(M5_N_DPM * 6);
M5_phiR_dd = 1./diff(M5_time(:,1)) .* diff(M5_phiR_d);
M5_phiR_dd = [M5_phiR_dd;M5_phiR_dd(size(M5_phiR_dd,1))];

A5 = horzcat(T_M_Cut, M5_phiR_d);
B5 = M5_phiR_dd;
x5 = A5\B5;

%Ausgabe Ergebnisse
[x1 x2 x3 x4 x5]