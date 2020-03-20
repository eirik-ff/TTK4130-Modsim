%% Definition of test system
lambda = -2;
f = @(t,x) lambda * x;
x0 = 1;

%% Simulation definitions
dt = 0.4;
tf = 2;
N = tf / dt;
T = linspace(0, tf, N);

%% RK1: Explicit Euler
A = [0];
c = [0];
b = [1];
RK1 = struct('A',A,'b',b,'c',c);

%% RK2
A = [0  0;
    1/2 0];
c = [0; 1/2];
b = [0; 1];
RK2 = struct('A',A,'b',b,'c',c);

%% RK4
A = [0   0   0 0;
     1/2 0   0 0;
     0   1/2 0 0;
     0   0   1 0];
c = [0; 1/2; 1/2; 1];
b = [1/6; 1/3; 1/3; 1/6];
RK4 = struct('A',A,'b',b,'c',c);


%% Simulation
X_RK1 = ERKTemplate(RK1,f,T,x0);
X_RK2 = ERKTemplate(RK2,f,T,x0);
X_RK4 = ERKTemplate(RK4,f,T,x0);

%% True solution
% x(t) = x0 * exp(-lambda * t) 
Ttrue = linspace(0, tf, 1000);
X_true = x0 * exp(lambda * Ttrue);

%% Plotting
figure(1);
clf
hold on;
grid on;
title({'TTK4130 Assignment 7 problem 2a', 'Comparison of RK methods vs. true solution'});
xlabel('time');

plot(Ttrue, X_true, 'LineWidth', 1.5);
plot(T, X_RK1, 'LineWidth', 1);
plot(T, X_RK2, 'LineWidth', 1);
plot(T, X_RK4, 'LineWidth', 1);

legend('True solution', 'Explicit Euler (RK1)', 'RK2', 'RK4');

