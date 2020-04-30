%% Definitions
m1 = 10.0; % kg
m2 = 0.1;  % kg
Fu = 1.1;  % N
k  = 0.5;  % N/m
l0 = 2.0;  % m
Fs = 1.0;  % N
Fc = 0.8;  % N

%% Model
Fb = @(x) k*(x(1) - x(2) - l0);
Ff = @(x) StrictionModel(x, Fs, Fc);
dxdt = @(t,x) [x(3); x(4); Fu - Fb(x); Fb(x) - Ff(x)];

%% Simulation definitions
t0 = 0;
tf = 15;  % s
x0 = [0; -2; 1; 0];

%% Simulation
[tout45, xout45] = ode45(dxdt, [t0 tf], x0);
[tout15s, xout15s] = ode15s(dxdt, [t0 tf], x0);

%% Plot
figure(1);

for i = 1:4
    subplot(4,2,2*i-1);
    plot(tout45, xout45(:,i));
    grid on
    xlabel('t [s]');
    ylabel(sprintf('x_%i',i));
end
subplot(4,2,1);
title('Stick and slip solution using ODE45');

for i = 1:4
    subplot(4,2,2*i);
    plot(tout15s, xout15s(:,i));
    grid on
    xlabel('t [s]');
    ylabel(sprintf('x_%i',i));
end
subplot(4,2,2);
title('Stick and slip solution using ODE15s');


%% Function definition
function fric = StrictionModel(x, Fs, Fc)
    % Stiction model with Coulomb force.
    % Fs: static/dry friction
    % Fc: dynamic friction
    if x(4) == 0
        fric = Fs;
    else
        fric = Fc*sign(x(4));
    end
end
