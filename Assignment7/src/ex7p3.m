%% Van der Pol definitions
u = 5;
x0 = [2;0];
f = @(t,x) [x(2); u*(1-x(1)^2)*x(2) - x(1)];

%% RK4
A = [0   0   0 0;
     1/2 0   0 0;
     0   1/2 0 0;
     0   0   1 0];
c = [0; 1/2; 1/2; 1];
b = [1/6; 1/3; 1/3; 1/6];
RK4 = struct('A',A,'b',b,'c',c);


%% 3a: ODE45 simulation
tf = 25;
[T_ode45,X_ode45] = ode45(f, [0, tf], x0);

%% 3b: RK4 simulation
dt = 0.1;
T_RK4 = 0:dt:tf;
X_RK4 = ERKTemplate(RK4, f, T_RK4, x0);

dt2 = 0.15;
T_RK4_2 = 0:dt2:tf;
X_RK4_2 = ERKTemplate(RK4, f, T_RK4_2, x0);


%% Plot ODE45 solution
figure(1);
clf;

subplot(311);
hold on;
plot(T_ode45, X_ode45(:,1), 'LineWidth', 1.5);
ylabel('x');

title({'TTK4130 Assignment 7 problem 3a','Van der Pol solution with ODE45, plotted with time steps'});

subplot(312);
hold on;
plot(T_ode45, X_ode45(:,2), 'LineWidth', 1.5);
ylabel('y');

subplot(313);
for i = 1:length(T_ode45)
    xline(T_ode45(i),'--','LineWidth',0.5);
end
ylim([0 1]);
ylabel('time grid');

xlabel('time');


%% Plot RK4 solution with fixed time step
figure(2);
clf;

subplot(211);
hold on;
plot(T_ode45, X_ode45(:,1), 'LineWidth', 1.5);
plot(T_RK4, X_RK4(1,:), '--', 'LineWidth', 1);
plot(T_RK4_2, X_RK4_2(1,:), ':', 'LineWidth', 1);
ylabel('x');

title({'TTK4130 Assignment 7 problem 3b', 'Comparison of ODE45 with RK4 with fixed time step'})

subplot(212);
hold on;
plot(T_ode45, X_ode45(:,2), 'LineWidth', 1.5);
plot(T_RK4, X_RK4(2,:), '--', 'LineWidth', 1);
plot(T_RK4_2, X_RK4_2(2,:), ':', 'LineWidth', 1);
ylabel('y');

legend('ODE45', ...
       sprintf('RK4 with \\Delta t = %.2f', dt), ...
       sprintf('RK4 with \\Delta t = %.2f', dt2), ...
       'location','northwest');

xlabel('time');


%% Plot comparison of time grid alternative
figure(3);
clf;

semilogy(T_ode45(1:end-1), T_ode45(2:end) - T_ode45(1:end-1));
hold on; 
grid on;
semilogy(T_RK4(1:end-1), T_RK4(2:end) - T_RK4(1:end-1));
ylim([6e-3 1.2e-1]);

ylabel('\Delta t = t_{k+1} - t_k');
xlabel('time');
title({'TTK4130 Assignment 7 problem 3b','Comparison of \Delta t in ODE45 and RK4 with fixed time step'});
legend('ODE45', 'RK4 with \Delta t = 0.1', 'location', 'southeast');



