function dydt = apocalypse(t, y, a, b, b_d, d, i, n, r, q_i, q_z, d_q)
% System of diff.eq. from TTK4130 Modsim 2020 Assignment 1
% Zombie apocalypse modeled 
%
% Populations: 
% H: healthy
% I: infected 
% Z: zombie 
% D: dead 
% Q: quarantined 
%
% Population in y vector: y = [H; I; Z; D; Q]

H = y(1);
I = y(2);
Z = y(3);
D = y(4);
Q = y(5);

dH = b * H - b_d * H^2 - d * H - i * Z * H;
dI = i * Z * H - (a + d + q_i) * I;
dZ = r * D + a * I - n * H * Z - q_z * Z;
dD = d * H + n * H * Z + d * I + d_q * Q - r * D;
dQ = q_i * I + q_z * Z - d_q * Q;

dydt = [dH; dI; dZ; dD; dQ];