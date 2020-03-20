clear all
close all
clc

%% Declarations
% Parameters
L = 1;
M = 1;
m = 1;

% Initial position
x0 = 0;
theta1_0 = pi/4;
theta2_0 = pi/2;
q0 = [x0; theta1_0; theta2_0];

% Initial velocity
dq0 = zeros(3,1);

% Initial state
%      1  2       3       4   5        6
% x = [x; theta1; theta2; dx; dtheta1; dtheta2];
state = [q0; dq0];


%% Simulation
tf = 45;

% Function declarations
W = @(x) prob1_W_hessian(L,M,m,x(2),x(3));
other = @(x) prob1_other_vector(L,M,x(5),x(6),x(4),x(2),x(3),x(1));
simFunc = @(t, x) [x(4:6); W(x) \ other(x)];

[time, statetraj] = ode45(simFunc, [0 tf], state);


%% 3D animation
DoublePlot = true;
FS = 30;
scale = 0.1;

% Create Objects
% Cube
vert{1} = 3*[ -1, -1, 0;  %1
               1, -1, 0;  %2
               1,  1, 0;  %3
              -1,  1, 0;  %4
              -1, -1, 2;  %5
               1, -1, 2;  %6
               1,  1, 2;  %7
              -1,  1, 2]/2; %8
fac{1} = [1 2 3 4;
          5 6 7 8;
          1 4 8 5;
          1 2 6 5;
          2 3 7 6;
          3 4 8 7];
Lrail = 1.2*max(abs(statetraj(:,1)))/scale;
% Rail
a = 1.5;
vert{2} = [-Lrail,-a,-0.1;
           -Lrail, a,-0.1;
            Lrail, a,-0.1;
            Lrail,-a,-0.1];
fac{2} = [1,2,3,4];
% Sphere
[X,Y,Z] = sphere(20);
[fac{3},vert{3},c] = surf2patch(3*X/2,3*Y/2,3*Z/2);
% Animation
tic
t_disp = 0;
SimSpeed = 1;
 while t_disp < tf/SimSpeed
    % Interpolate state
    state_animate = interp1(time,statetraj,SimSpeed*t_disp)';

    x = state_animate(1);
    theta1 = state_animate(2);
    theta2 = state_animate(3);
    
    p0 = [x; 0];  % box
    p1 = p0 + [L*sin(theta1); -L*cos(theta1)];  % sphere 1
    p2 = p1 + [L*sin(theta2); -L*cos(theta2)];  % sphere 2
    
    % shift coords 
    p0_3d = [-p0(1); 0; p0(2)];
    p1_3d = [-p1(1); 0; p1(2)];
    p2_3d = [-p2(1); 0; p2(2)];

    % Input argument for DrawPendulm
    pos_disp = [p0_3d(1); p1_3d; p2_3d];

    figure(1);clf;hold on
    if DoublePlot
        subplot(1,2,1);hold on
        DrawPendulum( pos_disp, vert, fac, scale);
        campos(scale*[15    15     -70])
        camtarget(scale*[0,0,1.5])
        camva(30)
        camproj('perspective')
        subplot(1,2,2);hold on
    end
    DrawPendulum( pos_disp, vert, fac, scale);
    campos(scale*[1    70     20])
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
