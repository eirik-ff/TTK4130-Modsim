%% System defs
xd = 1.32;
k = 2.40;
g = 9.81;
m = 200;

x = sym('x', [2,1]);
t = sym('t');

fSym = [x(2); -g * (1 - (xd/x(1))^k)];
dfSym = jacobian(fSym, x);

f  = matlabFunction(fSym,  'Vars', {t,x});
df = matlabFunction(dfSym, 'Vars', {t,x});
E = @(x) ((m*g) / (k-1)) * (xd^k) ./ (x(1,:).^(k-1)) + m*g*x(1,:) + 1/2*m*x(2,:).^2;

x0 = [2; 0];


%% Simulation defs
tf = 10;
dt = 0.01;
T  = 0:dt:tf;

%% Explicit Euler
A = 0;
b = 1;
c = 0;
ExplEuler = struct('A',A,'b',b,'c',c);

%% Implicit Euler
A = 1;
b = 1;
c = 1;
ImplEuler = struct('A',A,'b',b,'c',c);

%% Implicit midpoint (Gauss method order 2)
A = [1/4,               1/4 - sqrt(3) / 6;
     1/4 + sqrt(3) / 6, 1/4];
b = [1/2; 1/2];
c = [1/2 - sqrt(3) / 6;
     1/2 + sqrt(3) / 6];
ImplMidpoint = struct('A',A,'b',b,'c',c);


%% Simulations
x_ExplEuler    = IRK(ExplEuler,f,df,T,x0);
x_ImplEuler    = IRK(ImplEuler,f,df,T,x0);
x_ImplMidpoint = IRK(ImplMidpoint,f,df,T,x0);

E_ExplEuler    = E(x_ExplEuler);
E_ImplEuler    = E(x_ImplEuler);
E_ImplMidpoint = E(x_ImplMidpoint);


%% Plot expl euler
figure(1);
clf;

subplot(311);
plot(T, x_ExplEuler(1,:));
grid on;
xlabel('time [s]');
ylabel('$$x_1 = x$$', 'interpreter', 'latex');

title({'Modsim Assignment 9 problem 2b', 'Simulation of (2) with Explicit Euler'});

subplot(312);
plot(T, x_ExplEuler(2,:));
grid on;
xlabel('time [s]');
ylabel('$$x_2 = \dot{x}$$', 'interpreter', 'latex');

subplot(313);
plot(T,E_ExplEuler);
grid on;
xlabel('time [s]');
ylabel('energy', 'interpreter', 'latex');


%% Plot impl euler
figure(2);
clf;

subplot(311);
plot(T, x_ImplEuler(1,:));
grid on;
xlabel('time [s]');
ylabel('$$x_1 = x$$', 'interpreter', 'latex');

title({'Modsim Assignment 9 problem 2b', 'Simulation of (2) with Implicit Euler'});

subplot(312);
plot(T, x_ImplEuler(2,:));
grid on;
xlabel('time [s]');
ylabel('$$x_2 = \dot{x}$$', 'interpreter', 'latex');

subplot(313);
plot(T,E_ImplEuler);
grid on;
xlabel('time [s]');
ylabel('energy', 'interpreter', 'latex');


%% Plot impl midpoint
figure(3);
clf;

subplot(311);
plot(T, x_ImplMidpoint(1,:));
grid on;
xlabel('time [s]');
ylabel('$$x_1 = x$$', 'interpreter', 'latex');

title({'Modsim Assignment 9 problem 2b', 'Simulation of (2) with Implicit Midpoint Rule'});

subplot(312);
plot(T, x_ImplMidpoint(2,:));
grid on;
xlabel('time [s]');
ylabel('$$x_2 = \dot{x}$$', 'interpreter', 'latex');

subplot(313);
plot(T,E_ImplMidpoint);
grid on;
xlabel('time [s]');
ylabel('energy', 'interpreter', 'latex');




