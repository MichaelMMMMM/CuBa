%**************************************************************************
% Author: Michael Meindl
% Date: 2.4.2016
% Summary: Initializes the sizes of the Cuba and calculate the masses and
% momenta of inertia. The SI-Units are being used.
%**************************************************************************

%Edgelength of the cube
l_K = 0.15;
%Length of the triangles
l_D = 0.12;
%Depth of the K1
z_1 = 0.004;
%Values of K2
y_2 = 0.04;
x_2 = 0.07;
z_2 = 0.003;
%Values of K3
y_3 = 0.04;
x_3 = 0.01;
z_3 = 0.025;
%Values of K4 
r_4 = 0.02;
z_4 = 0.003;
%Values of K5
y_5 = 0.026;
x_5 = 0.03;
z_5 = 0.012;
%Values of K6
r_6 = 0.02;
%Values of K7
r_7 = 0.011;
z_7 = 0.01;
%Values of K8
l_8 = 0.04;
b_8 = 0.004;
%Values of K9
r_9A = 0.055;
r_9I = 0.045;
z_9 = 0.004;
%Density of aluminium
p_alu = 2.7e+3;

%Mass and momentum of K1
m_1 = p_alu * z_1 *(l_K^2 - l_D^2);
O_A_1 = m_1 * l_K^2 / 48 + m_1 * l_K^2/2;
%Mass and momentum of K2
m_2 = y_2 * x_2 * z_2 * p_alu;
O_A_2 = m_2 / 12 * (y_2^2 + x_2^2) + m_2 * (l_K^2 / 4 + 0.005^2);
%Mass and momentum of K3
m_3 = y_3 * x_3 * z_3 * p_alu;
O_A_3 = m_3/12 *(y_3^2 + x_3^2) + m_3 *(0.01^2 + l_K^2 /4);
%Mass and momentum of K4
m_4 = pi/2 * r_4^2 * z_4 * p_alu;
O_A_4 = m_4 * r_4^2 / 2 + m_4 * l_K^2 / 2;
%Mass and momentum of K5
m_5 = 0.021;
O_A_5 = m_5 / 12 * (y_5^2 + x_5^2) + m_5 * (0.068^2 + 0.03^2);
%Mass and momentum of K6
m_6 = 0.11;
O_A_6 = m_6 *(r_6^2 + l_K^2) / 2;
%Mass and momentum of K7
m_7 = pi * r_7 ^2 * z_7 * p_alu;
O_B_7 = m_7*r_7^2 / 2;
%Mass and momentum of K8
m_8 = 3 * l_8 * b_8^2 * p_alu;
O_B_8 = m_8 * b_8^2 / 2 + 3*m_8 * (l_8 * r_7)^2;
%Mass and momentum of K9
m_9 = z_9 * pi * (r_9A^2 - r_9I^2) * p_alu;
O_B_9 = m_9 * (r_9A^2 + r_9I^2) / 2;

%Mass and momentum of the body
m_K = m_1 + m_2 + m_3 + m_4 + m_5 + m_6;
O_A_K = O_A_1 + O_A_2 + O_A_3 + O_A_4 + O_A_4 + O_A_5 + O_A_6;

m_R = m_7 + m_8 + m_9;
O_B_R = O_B_7 + O_B_8 + O_B_9;