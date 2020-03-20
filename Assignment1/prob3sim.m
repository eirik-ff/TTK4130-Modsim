%% Parameters, unit = 1/sec
a   = 1.4e-6;
b   = 3.1e-8;
b_d = 5.6e-16;
d   = 2.8e-8;
i   = 2.6e-6;
n   = 1.4e-6;
r   = 2.8e-7;
q_i = 2.7e-6;
q_z = 2.7e-6;
d_q = 2.8e-5;


%% Initial values
H0 = (b - d) / b_d;
I0 = 0;
Z0 = 0;
D0 = 0;
Q0 = 0;
y0 = [H0; I0; Z0; D0; Q0];

%% Simulation
day_secs = 24 * 60 * 60;
tf = 100 * day_secs;  % 100 days in seconds
tspan = [0 tf];
sol = ode15s(@(t, y) apocalypse(t, y, a, b, b_d, d, i, n, r, q_i, q_z, d_q), tspan, y0);

x = linspace(0, tf, 1000);
y = deval(sol, x);

%% Plot
figure(1);
grid on;
hold on;
plot(x / day_secs, y, 'LineWidth', 1.5);

title('Zombie apocalypse simulation with quarantine');
xlabel('Time [days]');
ylabel('Population size');
legend('Healthy', 'Infected', 'Zombies', 'Dead', 'Quarantined', 'Location', 'east');

