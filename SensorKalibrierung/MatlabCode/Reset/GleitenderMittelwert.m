load('Messergebnisse\phiK45_rawValues');
phiK45_x1_raw = x1SignedValues;
phiK45_x2_raw = x2SignedValues;
phiK45_y1_raw = y1SignedValues;
phiK45_y2_raw = y2SignedValues;
load('Messergebnisse\phiK30_rawValues');
phiK30_x1_raw = x1SignedValues;
phiK30_x2_raw = x2SignedValues;
phiK30_y1_raw = y1SignedValues;
phiK30_y2_raw = y2SignedValues;
load('Messergebnisse\phiK15_rawValues');
phiK15_x1_raw = x1SignedValues;
phiK15_x2_raw = x2SignedValues;
phiK15_y1_raw = y1SignedValues;
phiK15_y2_raw = y2SignedValues;
load('Messergebnisse\phiK0_rawValues');
phiK0_x1_raw = x1SignedValues;
phiK0_x2_raw = x2SignedValues;
phiK0_y1_raw = y1SignedValues;
phiK0_y2_raw = y2SignedValues;
load('Messergebnisse\phiK-15_rawValues');
phiKm15_x1_raw = x1SignedValues;
phiKm15_x2_raw = x2SignedValues;
phiKm15_y1_raw = y1SignedValues;
phiKm15_y2_raw = y2SignedValues;
load('Messergebnisse\phiK-30_rawValues');
phiKm30_x1_raw = x1SignedValues;
phiKm30_x2_raw = x2SignedValues;
phiKm30_y1_raw = y1SignedValues;
phiKm30_y2_raw = y2SignedValues;
load('Messergebnisse\phiK-45_rawValues');
phiKm45_x1_raw = x1SignedValues;
phiKm45_x2_raw = x2SignedValues;
phiKm45_y1_raw = y1SignedValues;
phiKm45_y2_raw = y2SignedValues;
load('Messergebnisse\polyApproximation');

phiK = [-45 -30 -15 0 15 30 45];
m = 10000;
deltaT = 5e-3;
time = 0:deltaT:9999*deltaT;
%Calcualte Acceleration values using the polynom approximation
phiK45_x1_acc = x1Pol1.p1 * phiK45_x1_raw + x1Pol1.p2;
phiK45_x2_acc = x2Pol1.p1 * phiK45_x2_raw + x2Pol1.p2;
phiK45_y1_acc = y1Pol1.p1 * phiK45_y1_raw + y1Pol1.p2;
phiK45_y2_acc = y2Pol1.p1 * phiK45_y2_raw + y2Pol1.p2;
phiK30_x1_acc = x1Pol1.p1 * phiK30_x1_raw + x1Pol1.p2;
phiK30_x2_acc = x2Pol1.p1 * phiK30_x2_raw + x2Pol1.p2;
phiK30_y1_acc = y1Pol1.p1 * phiK30_y1_raw + y1Pol1.p2;
phiK30_y2_acc = y2Pol1.p1 * phiK30_y2_raw + y2Pol1.p2;
phiK15_x1_acc = x1Pol1.p1 * phiK15_x1_raw + x1Pol1.p2;
phiK15_x2_acc = x2Pol1.p1 * phiK15_x2_raw + x2Pol1.p2;
phiK15_y1_acc = y1Pol1.p1 * phiK15_y1_raw + y1Pol1.p2;
phiK15_y2_acc = y2Pol1.p1 * phiK15_y2_raw + y2Pol1.p2;
phiK0_x1_acc = x1Pol1.p1 * phiK0_x1_raw + x1Pol1.p2;
phiK0_x2_acc = x2Pol1.p1 * phiK0_x2_raw + x2Pol1.p2;
phiK0_y1_acc = y1Pol1.p1 * phiK0_y1_raw + y1Pol1.p2;
phiK0_y2_acc = y2Pol1.p1 * phiK0_y2_raw + y2Pol1.p2;
phiKm15_x1_acc = x1Pol1.p1 * phiKm15_x1_raw + x1Pol1.p2;
phiKm15_x2_acc = x2Pol1.p1 * phiKm15_x2_raw + x2Pol1.p2;
phiKm15_y1_acc = y1Pol1.p1 * phiKm15_y1_raw + y1Pol1.p2;
phiKm15_y2_acc = y2Pol1.p1 * phiKm15_y2_raw + y2Pol1.p2;
phiKm30_x1_acc = x1Pol1.p1 * phiKm30_x1_raw + x1Pol1.p2;
phiKm30_x2_acc = x2Pol1.p1 * phiKm30_x2_raw + x2Pol1.p2;
phiKm30_y1_acc = y1Pol1.p1 * phiKm30_y1_raw + y1Pol1.p2;
phiKm30_y2_acc = y2Pol1.p1 * phiKm30_y2_raw + y2Pol1.p2;
phiKm45_x1_acc = x1Pol1.p1 * phiKm45_x1_raw + x1Pol1.p2;
phiKm45_x2_acc = x2Pol1.p1 * phiKm45_x2_raw + x2Pol1.p2;
phiKm45_y1_acc = y1Pol1.p1 * phiKm45_y1_raw + y1Pol1.p2;
phiKm45_y2_acc = y2Pol1.p1 * phiKm45_y2_raw + y2Pol1.p2;
%Caclulate the Degreevalues
r1 = 142.89e-3;
r2 = 32.84e-3;
mu = r1/r2;
phiK45_deg = radtodeg(-atan((phiK45_x1_acc - mu*phiK45_x2_acc)./...
             (phiK45_y1_acc - mu*phiK45_y2_acc)));
phiK30_deg = radtodeg(-atan((phiK30_x1_acc - mu*phiK30_x2_acc)./...
             (phiK30_y1_acc - mu*phiK30_y2_acc)));
phiK15_deg = radtodeg(-atan((phiK15_x1_acc - mu*phiK15_x2_acc)./...
             (phiK15_y1_acc - mu*phiK15_y2_acc)));
phiK0_deg = radtodeg(-atan((phiK0_x1_acc - mu*phiK0_x2_acc)./...
             (phiK0_y1_acc - mu*phiK0_y2_acc)));
phiKm15_deg = radtodeg(-atan((phiKm15_x1_acc - mu*phiKm15_x2_acc)./...
             (phiKm15_y1_acc - mu*phiKm15_y2_acc)));
phiKm30_deg = radtodeg(-atan((phiKm30_x1_acc - mu*phiKm30_x2_acc)./...
             (phiKm30_y1_acc - mu*phiKm30_y2_acc)));
phiKm45_deg = radtodeg(-atan((phiKm45_x1_acc - mu*phiKm45_x2_acc)./...
             (phiKm45_y1_acc - mu*phiKm45_y2_acc)));
         
%Calculate the floating mean values for the degree values
n = 4;
phiK45_deg_float_mean  = phiK45_deg;
phiK30_deg_float_mean  = phiK30_deg;
phiK15_deg_float_mean  = phiK15_deg;
phiK0_deg_float_mean   = phiK0_deg;
phiKm15_deg_float_mean = phiKm15_deg;
phiKm30_deg_float_mean = phiKm30_deg;
phiKm45_deg_float_mean = phiKm45_deg;

for i = n+1:1:m
    phiK45_deg_float_mean(i)  = mean(phiK45_deg(i-n:i));
    phiK30_deg_float_mean(i)  = mean(phiK30_deg(i-n:i));
    phiK15_deg_float_mean(i)  = mean(phiK15_deg(i-n:i));
    phiK0_deg_float_mean(i)   = mean(phiK0_deg(i-n:i));
    phiKm15_deg_float_mean(i) = mean(phiKm15_deg(i-n:i));
    phiKm30_deg_float_mean(i) = mean(phiKm30_deg(i-n:i));
    phiKm45_deg_float_mean(i) = mean(phiKm45_deg(i-n:i));
end

%Calculate the variance of the degree values
phiK45_deg_var  = var(phiK45_deg);
phiK30_deg_var  = var(phiK30_deg);
phiK15_deg_var  = var(phiK15_deg);
phiK0_deg_var   = var(phiK0_deg);
phiKm15_deg_var = var(phiKm15_deg);
phiKm30_deg_var = var(phiKm30_deg);
phiKm45_deg_var = var(phiKm45_deg);
deg_var = [phiK45_deg_var phiK30_deg_var phiK15_deg_var phiK0_deg_var ...
            phiKm15_deg_var phiKm30_deg_var phiKm45_deg_var];
%Calculate hte standard deviation of the degree values
phiK45_deg_sd  = sqrt(phiK45_deg_var);
phiK30_deg_sd  = sqrt(phiK30_deg_var);
phiK15_deg_sd  = sqrt(phiK15_deg_var);
phiK0_deg_sd   = sqrt(phiK0_deg_var);
phiKm15_deg_sd = sqrt(phiKm15_deg_var);
phiKm30_deg_sd = sqrt(phiKm30_deg_var);
phiKm45_deg_sd = sqrt(phiKm45_deg_var);
deg_sd = [phiKm45_deg_sd phiKm30_deg_sd phiKm15_deg_sd phiK0_deg_sd...
            phiK15_deg_sd phiK30_deg_sd phiK45_deg_sd];
        
%Calculate the variance of the deg_float_meanree values
phiK45_deg_float_mean_var  = var(phiK45_deg_float_mean);
phiK30_deg_float_mean_var  = var(phiK30_deg_float_mean);
phiK15_deg_float_mean_var  = var(phiK15_deg_float_mean);
phiK0_deg_float_mean_var   = var(phiK0_deg_float_mean);
phiKm15_deg_float_mean_var = var(phiKm15_deg_float_mean);
phiKm30_deg_float_mean_var = var(phiKm30_deg_float_mean);
phiKm45_deg_float_mean_var = var(phiKm45_deg_float_mean);
deg_float_mean_var = [phiK45_deg_float_mean_var phiK30_deg_float_mean_var phiK15_deg_float_mean_var phiK0_deg_float_mean_var ...
            phiKm15_deg_float_mean_var phiKm30_deg_float_mean_var phiKm45_deg_float_mean_var];
%Calculate hte standard deviation of the deg_float_meanree values
phiK45_deg_float_mean_sd  = sqrt(phiK45_deg_float_mean_var);
phiK30_deg_float_mean_sd  = sqrt(phiK30_deg_float_mean_var);
phiK15_deg_float_mean_sd  = sqrt(phiK15_deg_float_mean_var);
phiK0_deg_float_mean_sd   = sqrt(phiK0_deg_float_mean_var);
phiKm15_deg_float_mean_sd = sqrt(phiKm15_deg_float_mean_var);
phiKm30_deg_float_mean_sd = sqrt(phiKm30_deg_float_mean_var);
phiKm45_deg_float_mean_sd = sqrt(phiKm45_deg_float_mean_var);
deg_float_mean_sd = [phiKm45_deg_float_mean_sd phiKm30_deg_float_mean_sd phiKm15_deg_float_mean_sd phiK0_deg_float_mean_sd...
            phiK15_deg_float_mean_sd phiK30_deg_float_mean_sd phiK45_deg_float_mean_sd];


%Plot the degree values and the floating mean degree values
figure;
plot(time, phiK45_deg, time, phiK45_deg_float_mean); grid;
xlabel('Zeit in Sekunden'); ylabel('\phi_K in Grad');
legend('Standardwert', 'Gleitender Mittelwert'); title('Winkelwertevergleich bei \phi_K = 45');
print('phiK45_floatingMean_degree', '-depsc');
figure;
plot(time, phiK30_deg, time, phiK30_deg_float_mean); grid;
xlabel('Zeit in Sekunden'); ylabel('\phi_K in Grad');
legend('Standardwert', 'Gleitender Mittelwert'); title('Winkelwertevergleich bei \phi_K = 30');
print('phiK30_floatingMean_degree', '-depsc');
figure;
plot(time, phiK15_deg, time, phiK15_deg_float_mean); grid;
xlabel('Zeit in Sekunden'); ylabel('\phi_K in Grad');
legend('Standardwert', 'Gleitender Mittelwert'); title('Winkelwertevergleich bei \phi_K = 15');
print('phiK15_floatingMean_degree', '-depsc');
figure;
plot(time, phiK0_deg, time, phiK0_deg_float_mean); grid;
xlabel('Zeit in Sekunden'); ylabel('\phi_K in Grad');
legend('Standardwert', 'Gleitender Mittelwert'); title('Winkelwertevergleich bei \phi_K = 0');
print('phiK0_floatingMean_degree', '-depsc');
figure;
plot(time, phiKm15_deg, time, phiKm15_deg_float_mean); grid;
xlabel('Zeit in Sekunden'); ylabel('\phi_K in Grad');
legend('Standardwert', 'Gleitender Mittelwert'); title('Winkelwertevergleich bei \phi_K = -15');
print('phiKm15_floatingMean_degree', '-depsc');
figure;
plot(time, phiKm30_deg, time, phiKm30_deg_float_mean); grid;
xlabel('Zeit in Sekunden'); ylabel('\phi_K in Grad');
legend('Standardwert', 'Gleitender Mittelwert'); title('Winkelwertevergleich bei \phi_K = -30');
print('phiKm30_floatingMean_degree', '-depsc');
figure;
plot(time, phiKm45_deg, time, phiKm45_deg_float_mean); grid;
xlabel('Zeit in Sekunden'); ylabel('\phi_K in Grad');
legend('Standardwert', 'Gleitender Mittelwert'); title('Winkelwertevergleich bei \phi_K = -45');
print('phiKm45_floatingMean_degree', '-depsc');
figure;
plot(phiK, deg_sd, '*', phiK, deg_float_mean_sd, '*'); grid;
xlabel('\phi_K in Grad'); ylabel('Standardabweichung in m/s^2');
legend('Winkelschätzung', 'Gleitende Mittlung'); title('Standardabweichungsvergleich');
print('degree_floatingMean_sd', '-depsc');