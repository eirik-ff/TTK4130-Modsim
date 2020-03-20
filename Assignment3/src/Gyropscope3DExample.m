clear all
clc

L = 2;   % Length of the gyropscope
omega = [0;0;4];  % Omega

r = [0;pi/4;0]; % random('norm',0,1,[3,1]);
R = expm([   0,      -r(3),  +r(2);
             +r(3),     0,   -r(1);
             -r(2), +r(1),    0]);      % Rotation matrix describing the Gyropscope orientation

p = R*[0;0;L];    % Position of the gyropscope centre

ScaleFrame = 2;   % Scaling factor for adjusting the frame size (cosmetic)
FS         = 15;  % Fontsize for text
SW         = 0.02; % Arrows size

figure(1);clf;hold on
MakeFrame(zeros(3,1),eye(3),ScaleFrame,FS,SW,'a', 'color', 'k')
MakeFrame(p,R,ScaleFrame,FS,SW,'b', 'color', 'b')
Cylinder(zeros(3,1),p,0.1, 'color', [.5,0,.1]);
MakeArrow(p,R*omega,FS,SW,'$$\omega$$', 'color', [0,0.5,0])
Cylinder(p,p+R*[0;0;0.25],1,'FaceColor','r','facealpha',0.25,'FaceLighting','gouraud','SpecularStrength',1,'Diffusestrength',0.5,'AmbientStrength',0.7,'SpecularExponent',5);
FormatPicture([0;0;2],0.25*[73.8380   21.0967   30.1493])
