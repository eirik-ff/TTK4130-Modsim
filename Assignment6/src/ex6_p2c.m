%% Symbolic definition of diff. eq.

syms x1 x2 z1 z2 real
syms a e real

x = [x1; x2];
z = [z1; z2];

A = [x1^2, x2; 0, x2^2] + a * eye(2);
H = [1 1; 0 1];  % in (3a)
h = 1/10;  % in (3b)


xdot = -H * x - z;  % (3a)
zdot = (h*x - A*z) / e;  % (3b)
dae  = h*x - A*z;  % = 0


%% Simulation
% Initial conditions
x0 = [1; 1];
z0 = [1; 1];

% Create functions for simulation
a = 0;
e = 1e-5;

xdot = subs(xdot);
zdot = subs(zdot);
dae = subs(dae);

f = matlabFunction(xdot, 'Vars', {x,z});
g = matlabFunction(zdot, 'Vars', {x,z});

g_dae = matlabFunction(dae, 'Vars', {x,z});
sol = solve(dae == 0, z);

% Simulate
tf = 10;
[tsim, xsim] = ode15s( @(t, x) [f(x(1:2), x(3:4)); g(x(1:2), x(3:4))], [0 tf], [x0; z0]);
[tsim_dae, xsim_dae] = ode15s( @(t,x) DAEdynamics(t,x,xdot,sol), [0 tf], x0); 


%% Plot
figure(1);

subplot(211);
hold on;
grid on;
title({'TTK4130 Assignment 6 problem 2c', sprintf('Simulation of system (3) with \\epsilon = %.0e', e)});
plot(tsim, xsim(:,1:2), 'LineWidth', 1);
xlimits = xlim;
legend('x_1', 'x_2');

subplot(212);
hold on;
grid on;
plot(tsim_dae, xsim_dae, 'LineWidth', 1);
legend('x_{1,DAE}', 'x_{2,DAE}');
xlim(xlimits);

xlabel('time');




%% DAE dynamics function declaration
function x_dot = DAEdynamics(t, x, xdotSym, sol)
    x1 = x(1); x2 = x(2);
    z1 = subs(sol.z1); z2 = subs(sol.z2);
    
    x_dot = double(subs(xdotSym));
end

    
    