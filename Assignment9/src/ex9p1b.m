%% Test system
lambda = -2;
f = @(t,x) lambda * x;
df = @(t,x) lambda;

x0 = 1;


%% Simulation defs
tf = 2;
dt = 0.4;
T = 0:dt:tf;

A = [1/4,               1/4 - sqrt(3) / 6;
     1/4 + sqrt(3) / 6, 1/4];
b = [1/2; 1/2];
c = [1/2 - sqrt(3) / 6;
     1/2 + sqrt(3) / 6];
ButcherTableau = struct('A',A,'b',b,'c',c);


%% Real solution
Ttrue = linspace(0,tf,1000);
xtrue = x0 * exp(lambda * Ttrue);


%% Simulation
x = IRK(ButcherTableau, f, df, T, x0);


%% Plot
figure(1);
clf
hold on;
grid on;
title({'Modsim Assignment 8 problem 1b', 'Comparison of IRK (s=2) vs. true solution'});
xlabel('time');

plot(Ttrue, xtrue, 'LineWidth', 1.5);
plot(T, x, 'LineWidth', 1);

legend('True solution', 'IRK');
