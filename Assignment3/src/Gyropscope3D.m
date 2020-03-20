clear all
clc

m = 1;  % kg, mass of gyroscope disk
Radius = 1;  % m, radius of gyroscope disk
L = 2;  % m, length of gyropscope rod

g_in_a = [0; 0; 9.81];
Mbo_in_b = m * [L^2+Radius^2/4, 0, 0; 0, L^2+Radius^2/4, 0; 0, 0, Radius^2/2];

omega = [0;0;pi];  % Omega

r = [0;pi/6;0];
R = expm([   0,      -r(3),  +r(2);
             +r(3),     0,   -r(1);
             -r(2), +r(1),    0]);

v = [1;0;0];
p = R*[0;0;L];  % Position of the gyropscope centre
%R = eye(3);

state = [p; v; omega; reshape(R, 9,1)];
parameters = {g_in_a, Mbo_in_b, m, L};


time_final = 120; %Final time

% Simulate satellite dynamics
[time,statetraj] = ode45(@(t,x)GyroscopeDynamics(t, x, parameters),[0,time_final],state);


%% Draw animation
tic; % resets Matlab clock
time_display = 0; % time displayed
while time_display < time(end)
    time_animate = toc; % get the current clock time
    % Interpolate the simulation at the current clock time
    state_animate = interp1(time,statetraj,time_animate);

    p = state_animate(1:3)';
    R = state_animate(10:18);
    R = reshape(R, [3,3]);
    omega = state_animate(7:9)';
    
    
    ScaleFrame = 2;   % Scaling factor for adjusting the frame size (cosmetic)
    FS         = 15;  % Fontsize for text
    SW         = 0.02; % Arrows size

    figure(1);clf;hold on
    MakeFrame(zeros(3,1),eye(3),ScaleFrame,FS,SW,'a', 'color', 'k')  % frame a
    MakeFrame(p,R,ScaleFrame,FS,SW,'b', 'color', 'b')  % frame b
    Cylinder(zeros(3,1),p,0.1, 'color', [.5,0,.1]);
    MakeArrow(p,R*omega,FS,SW,'$$\omega$$', 'color', [0,0.5,0])  % omega_ab
    Cylinder(p,p+R*[0;0;0.25],1,'FaceColor','r','facealpha',0.25,'FaceLighting','gouraud','SpecularStrength',1,'Diffusestrength',0.5,'AmbientStrength',0.7,'SpecularExponent',5);
    FormatPicture([0;0;2],0.25*[73.8380   21.0967   30.1493])
    
    
    if time_display == 0
        display('Hit a key to start animation')
        pause
        tic
    end
    time_display = toc; % get the current clock time
end
