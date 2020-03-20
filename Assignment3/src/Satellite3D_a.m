clear all
%close all
clc

% Define your initial state, e.g. as:
% state = [position;
%          orientation;
%          velocity;
%          angular velocity];

% "parameters" allows you to pass some parameters to the "SatelliteDynamics" function
G = 6.674e-11;
m_T = 5.972e24;
radius_earth = 6356e3;  % meters
orbital_height = 36e6;  % meters
r_c = radius_earth + orbital_height;
parameters = {1, 1, 1}; %{G, m_T, r_c};
% Smaller values of the parameters gave a much better orbit in our small
% simulation than the actual physical values did. 

omega_ab_in_b = [1;1;1];  %[-1; 0; 1];
R_vec = reshape(eye(3), [9,1]);
p0 = 1e0 * [1;2;3];
v0 = zeros(3,1); %5e-1 * [1;1;1];

state = [p0; R_vec; v0; omega_ab_in_b];


time_final = 120; %Final time

% Simulate satellite dynamics
[time,statetraj] = ode45(@(t,x)SatelliteDynamics_a(t, x, parameters),[0,time_final],state);

% Here below is a template for a real-time animation
tic; % resets Matlab clock
time_display = 0; % time displayed
while time_display < time(end)
    time_animate = toc; % get the current clock time
    % Interpolate the simulation at the current clock time
    state_animate = interp1(time,statetraj,time_animate);

    p = state_animate(1:3)';
    R = state_animate(4:12);
    R = reshape(R, [3,3]);
    omega = state_animate(16:18)';
    
    figure(1);clf;hold on
    % Use the example from "Satellite3DExample.m" to display your satellite
    
    ScaleFrame = 5;   % Scaling factor for adjusting the frame size (cosmetic)
    FS         = 15;  % Fontsize for text
    SW         = 0.035; % Arrows size

    MakeFrame(zeros(3,1),eye(3),ScaleFrame,FS,SW,'a', 'color', 'k')
    MakeFrame(p,R,ScaleFrame,FS,SW,'b', 'color', 'r')
    MakeFrame(zeros(3,1),R,ScaleFrame,FS,SW,'b', 'color', 'r')
    MakeArrow(p,R*omega,FS,SW,'$$\omega$$', 'color', [0,0.5,0])
    DrawRectangle(p,R,'color',[0.5,0.5,0.5]);
    FormatPicture([0;0;2],0.5*[73.8380   21.0967   30.1493])
    
    
    if time_display == 0
        display('Hit a key to start animation')
        pause
        tic
    end
    time_display = toc; % get the current clock time
end
