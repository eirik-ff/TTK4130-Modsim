clear all
close all
clc


%% Declarations
% Parameters
J = 1;
M = 1;
R = 0.25;

% Initial position
x0 = 1;
theta_0 = 0;
q0 = [x0; theta_0];

% Initial velocity
dq0 = zeros(2,1);

% Initial state
%      1  2      3   4
% x = [x; theta; dx; dtheta];
state = [q0; dq0];


%% Simulation
tf = 15;

% Function declarations
W = @(x) prob2_W_hessian(x,[J,M,R]');
other = @(x) prob2_other_vector(x, [J,M,R]');
simFunc = @(t, x) [x(3:4); W(x) \ other(x)];

[tsim, xsim] = ode45(simFunc, [0 tf], state);


%% 3D animation
DoublePlot = true;
scale = 0.25;
FS = 30;
ball_radius = 0.25;

% Create Objects
% Rail
Lrail = 2;
a = ball_radius;
vert{1} = [-Lrail,-a, 0;
           -Lrail, a, 0;
            Lrail, a, 0;
            Lrail,-a, 0];
fac{1} = [1,2,3,4];
% Sphere
[X,Y,Z] = sphere(20);
[fac{2},vert{2},c] = surf2patch(X,Y,Z);

% Animation
tic
t_disp = 0;
SimSpeed = 1;
while t_disp < tf/SimSpeed
    % Interpolate state
    x_disp   = interp1(tsim,xsim,SimSpeed*t_disp)';

    % Unwrap state. MODIFY
    x = x_disp(1);
    theta = x_disp(2); % beam angle
    pos = x*[cos(theta);sin(theta)] + ball_radius*[-sin(theta);cos(theta)];
    pos = [pos(1);0;pos(2)]; % ball position

    figid = figure(1);clf;hold on
    if DoublePlot
        subplot(1,2,1);hold on
        DrawBallAndBeam(pos, theta, vert, fac, xsim, ball_radius);
        campos(scale*[10    10     20])
        camtarget(scale*[0,0,1.5])
        camva(30)
        camproj('perspective')
        subplot(1,2,2);hold on
    end
    DrawBallAndBeam(pos, theta, vert, fac, xsim, ball_radius);
    campos(0.4*scale*[1    70     20])
    camtarget(scale*[0,0,1.5])
    camva(30)
    camproj('perspective')
    drawnow

    if t_disp == 0
        display('Hit a key to start animation')
        pause
        tic
    end
    t_disp = toc;
end
