%% System defs
p  = sym('p', [3,1]);
dp = sym('dp', [3,1]);
v  = sym('v', [3,1]);
dv = sym('dv', [3,1]);
x  = [p; v];
dx = [dp; dv];

t = sym('t');
z = sym('z');
L = 1;
g = 9.81;

%FSym = dx - [zeros(3), eye(3); -z*eye(3), -g*diag([0,0,1])] * x;
FSym = [dx; 0] - [v; -g*[0;0;1] - z*p; (p.')*p + L^2]; 
dFdxdotSym = jacobian(FSym,dx);
dFdxSym = jacobian(FSym,x);
dFdzSym = jacobian(FSym,z);

F = matlabFunction(FSym, 'vars', {dx,x,z,t});
dFdxdot = matlabFunction(dFdxdotSym, 'vars', {dx,x,z,t});
dFdx = matlabFunction(dFdxSym, 'vars', {dx,x,z,t});
dFdz = matlabFunction(dFdzSym, 'vars', {dx,x,z,t});

x0 = [1, 0, 0, 0, 1, 0].';
z0 = 1;

%% Sim defs
A = [1/4,               1/4 - sqrt(3) / 6;
     1/4 + sqrt(3) / 6, 1/4];
b = [1/2; 1/2];
c = [1/2 - sqrt(3) / 6;
     1/2 + sqrt(3) / 6];
BT_IRK4 = struct('A',A,'b',b,'c',c);

tf = 30;
dt = 0.01; % TODO: try different
T = 0:dt:tf;

[x,xdot,z] = RKDAE(BT_IRK4, F, dFdxdot, dFdx, dFdz, T, x0, z0);


%% Plot 3D
figure(1);
clf;

subplot(211);
plot3(x(1,:), x(2,:), x(3,:));
xlabel('p_1');
ylabel('p_2');
zlabel('p_3');
title({'Modsim assignment 9 problem 3b', sprintf('3D path of pendulum (\\Delta t = %G)', dt)});
grid on;


%% Plot constraint
CFunc = @(p) 1/2 * ((p.')*p - L^2);
constraint = NaN(1,length(x));
for i = 1:length(constraint)
    constraint(i) = CFunc(x(1:3,i));
end

subplot(212);
plot(T,constraint);
grid on;
xlabel('time [s]');
ylabel('constraint');
title('Value of constraint (5) vs. simulation time');




