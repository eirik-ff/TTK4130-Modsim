%% Mass-damper-spring parameters
m = 1;
d = 0.1;
k = 1;
A = [ 0      1;
     -k/m -d/m];
% Mass-damper-spring vector field
fMassDamperSpring = @(t,x) A*x;
% Heun's third-order method
A = [0  0  0;
    1/3 0  0;
    0  2/3 0];
c = sum(A,2);
b = [1/4; 0; 3/4];
HeunArray = struct('A',A,'b',b,'c',c);
% Simulation parameters
T = linspace(0,100,1000);
x0 = [1;1];

%% Simulate
X = ERKTemplate(HeunArray,fMassDamperSpring,T,x0);

%% Plot
figure
subplot(2,1,1)
plot(T,X(1,:))
ylabel('Position [m]')
xlabel('Time [s]')
grid on
subplot(2,1,2)
plot(T,X(2,:))
grid on
ylabel('Velocity [m/s]')
xlabel('Time [s]')