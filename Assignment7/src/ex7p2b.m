%% Definition of test system
lambda = -2;
f = @(t,x) lambda * x;
x0 = 1;


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


%% True solution
% x(t) = x0 * exp(-lambda * t) 
Ttrue = linspace(0, tf, 1000);
f_true = @(t) x0 * exp(lambda * t);
X_true = f_true(Ttrue);


%% Simulation
tf = 2;
steps = [0.1, 0.01, 0.001];
multipliers = flip(1:9)';
dts = reshape(steps .* multipliers, length(steps)*length(multipliers),1);
dts = [1; dts];

Eglobal = zeros(size(dts,1),3);
for i = 1:length(dts)
    dt = dts(i);
    T = 0:dt:tf;

    X_RK1 = ERKTemplate(RK1,f,T,x0);
    X_RK2 = ERKTemplate(RK2,f,T,x0);
    X_RK4 = ERKTemplate(RK4,f,T,x0);
    
    Eglobal(i,1) = abs(X_RK1(end) - f_true(T(end)));
    Eglobal(i,2) = abs(X_RK2(end) - f_true(T(end)));
    Eglobal(i,3) = abs(X_RK4(end) - f_true(T(end)));
end % for


%% Calculate order
dt1 = find(dts == 1e-1);
dt3 = find(dts == 1e-3);
ddt = log10(1e-1) - log10(1e-3);

o1 = (log10(Eglobal(dt1,1)) - log10(Eglobal(dt3,1))) / ddt
o2 = (log10(Eglobal(dt1,2)) - log10(Eglobal(dt3,2))) / ddt
o4 = (log10(Eglobal(dt1,3)) - log10(Eglobal(dt3,3))) / ddt

%% Plotting
figure(1);
clf;

loglog(dts,Eglobal,'LineWidth',1);
hold on; grid on;


title({'TTK4130 Assignment 7 problem 2b', 'Comparison of global error of different RK methods'});
xlabel('\Delta t');
ylabel('Global error: |x_N - x(T)|');

legend(sprintf('RK1: true order = %.2f',o1), ...
       sprintf('RK2: true order = %.2f',o2), ...
       sprintf('RK4: true order = %.2f',o4), 'location','southeast');


