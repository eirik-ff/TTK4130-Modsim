%% Definition of test system
lambda = -2;
f = @(t,x) lambda * x;
dfdx = @(t,x) lambda; 
x0 = 1;

%% Simulation definitions
dt = 0.2;
tf = 2;
T = 0:dt:tf;

%% Simulation
x = ImplicitEuler(f, dfdx, T, x0);


%% True solution
Ttrue = linspace(0, tf, 1000);
xtrue = exp(lambda * Ttrue);


%% Plot
figure(1)
clf;

plot(T, x, 'LineWidth',1);
hold on;
grid on;
plot(Ttrue, xtrue, 'LineWidth',1);
legend('Implicit Euler', 'True solution');

xlabel('time t');
ylabel('amplitude');
title({'Modsim assignment 9 problem 1b','Simulation of test system'});



