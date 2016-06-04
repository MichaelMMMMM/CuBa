% Autor : Michael Meindl
% Datum : 18.05.2016
% Programm liest die Messwerte ein, berechnet aus dem Motorstrom das
% Drehmoment(PT1-Verhalten) und bestimmt über kleinsten Fehlerquadrate C_R

Theta = 8.8e-5;
K_M   = 33.5e-3;
%Messwerte auslesen
filename = 'M1_14mNm.csv';
delimiter = ';';
startRow = 11;
formatSpec = '%f%f%f%*s%*s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
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
sim('PT1_IM_KM');

dataPoints = 0:1:size(M1_time,1)-1;
dataPoints = dataPoints';
timeFactor = size(T_M,1) / size(dataPoints,1);
T_M_Cut = T_M(round(timeFactor.*dataPoints)+1);
M1_phiR_d = degtorad(M1_N_DPM * 6);
M1_phiR_dd = 1./diff(M1_time(:,1)) .* diff(M1_phiR_d);
M1_phiR_dd = [M1_phiR_dd;M1_phiR_dd(size(M1_phiR_dd,1))];
A1 = M1_phiR_d;
B1 = T_M_Cut - (Theta*M1_phiR_dd);
C_R1 = A1\B1;

%Auswertung Messung 2
filename = 'M2_25mNm.csv';
delimiter = ';';
startRow = 11;
formatSpec = '%f%f%f%*s%*s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
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
sim('PT1_IM_KM');

dataPoints = 0:1:size(M2_time,1)-1;
dataPoints = dataPoints';
timeFactor = size(T_M,1) / size(dataPoints,1);
T_M_Cut = T_M(round(timeFactor.*dataPoints)+1);
M2_phiR_d = degtorad(M2_N_DPM * 6);
M2_phiR_dd = 1./diff(M2_time(:,1)) .* diff(M2_phiR_d);
M2_phiR_dd = [M2_phiR_dd;M2_phiR_dd(size(M2_phiR_dd,1))];
A2 = M2_phiR_d;
B2 = T_M_Cut - (Theta*M2_phiR_dd);
C_R2 = A2\B2;

%Auswertung Messung 3
filename = 'M3_32mNm.csv';
delimiter = ';';
startRow = 11;
formatSpec = '%f%f%f%*s%*s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
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
sim('PT1_IM_KM');

dataPoints = 0:1:size(M3_time,1)-1;
dataPoints = dataPoints';
timeFactor = size(T_M,1) / size(dataPoints,1);
T_M_Cut = T_M(round(timeFactor.*dataPoints)+1);
M3_phiR_d = degtorad(M3_N_DPM * 6);
M3_phiR_dd = 1./diff(M3_time(:,1)) .* diff(M3_phiR_d);
M3_phiR_dd = [M3_phiR_dd;M3_phiR_dd(size(M3_phiR_dd,1))];
A3 = M3_phiR_d;
B3 = T_M_Cut - (Theta*M3_phiR_dd);
C_R3 = A3\B3;

%Messung 4
filename = 'M4_40mNm.csv';
delimiter = ';';
startRow = 11;
formatSpec = '%f%f%f%*s%*s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
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
sim('PT1_IM_KM');

dataPoints = 0:1:size(M4_time,1)-1;
dataPoints = dataPoints';
timeFactor = size(T_M,1) / size(dataPoints,1);
T_M_Cut = T_M(round(timeFactor.*dataPoints)+1);
M4_phiR_d = degtorad(M4_N_DPM * 6);
M4_phiR_dd = 1./diff(M4_time(:,1)) .* diff(M4_phiR_d);
M4_phiR_dd = [M4_phiR_dd;M4_phiR_dd(size(M4_phiR_dd,1))];
A4 = M4_phiR_d;
B4 = T_M_Cut - (Theta*M4_phiR_dd);
C_R4 = A4\B4;


%Messung 5
filename = 'M5_50mNm.csv';
delimiter = ';';
startRow = 11;
formatSpec = '%f%f%f%*s%*s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
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
sim('PT1_IM_KM');

dataPoints = 0:1:size(M5_time,1)-1;
dataPoints = dataPoints';
timeFactor = size(T_M,1) / size(dataPoints,1);
T_M_Cut = T_M(round(timeFactor.*dataPoints)+1);
M5_phiR_d = degtorad(M5_N_DPM * 6);
M5_phiR_dd = 1./diff(M5_time(:,1)) .* diff(M5_phiR_d);
M5_phiR_dd = [M5_phiR_dd;M5_phiR_dd(size(M5_phiR_dd,1))];
A5 = M5_phiR_d;
B5 = T_M_Cut - (Theta*M5_phiR_dd);
C_R5 = A5\B5;

%Ausgabe Ergebnisse
[C_R1 C_R2 C_R3 C_R4 C_R5]

A = [A1;A2;A3;A4;A5];
B = [B1;B2;B3;B4;B5];
C_R = A\B