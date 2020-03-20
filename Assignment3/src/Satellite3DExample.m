clear all
clc

p = [2;3;4];   % Position of the satellite
omega = [1;2;3];  % Omega

r = random('norm',0,1,[3,1]); % Random axis of rotation / angle
R = expm([   0,      -r(3),  +r(2);
             +r(3),     0,   -r(1);
             -r(2), +r(1),    0]);      % Rotation matrix describing the satellite orientation

ScaleFrame = 5;   % Scaling factor for adjusting the frame size (cosmetic)
FS         = 15;  % Fontsize for text
SW         = 0.035; % Arrows size

figure(1);clf;hold on
MakeFrame(zeros(3,1),eye(3),ScaleFrame,FS,SW,'a', 'color', 'k')
MakeFrame(p,R,ScaleFrame,FS,SW,'b', 'color', 'r')
MakeArrow(p,R*omega,FS,SW,'$$\omega$$', 'color', [0,0.5,0])
DrawRectangle(p,R ,'color',[0.5,0.5,0.5]);
FormatPicture([0;0;2],0.5*[73.8380   21.0967   30.1493])
