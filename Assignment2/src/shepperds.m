function [k, theta] = shepperds(R)
% Calculate angle-axis representation of a rotation matrix using
% Shepperd's method, p. 236
%
% R:        rotation matrix
% 
% k:        axis
% theta:    angle

%% Setup
T = trace(R);
r00 = T;
temp = num2cell(diag(R));
[r11, r22, r33] = temp{:};
ris = [r00 r11 r22 r33];

%% Step 1
[~, j] = max(ris);

%% Step 2
zii = sqrt(1 + 2 * ris(j) - T);

%% Step 3
% Sign not important for just finding *one* angle-axis representation

%% Step 4
z = zeros(4,1);
z(j) = zii;

if j == 1
    z(2) = (R(3,2) - R(2,3)) / z(1);
    z(3) = (R(1,3) - R(3,1)) / z(1);
    z(4) = (R(2,1) - R(1,2)) / z(1);
elseif j == 2
    z(1) = (R(3,2) - R(2,3)) / z(2);
    z(3) = (R(2,1) + R(1,2)) / z(2);
    z(4) = (R(1,3) + R(3,1)) / z(2);
elseif j == 3
    z(1) = (R(1,3) - R(3,1)) / z(3);
    z(2) = (R(1,3) + R(3,1)) / z(3);
    z(4) = (R(3,2) + R(2,3)) / z(3);  
elseif j == 4
    z(1) = (R(2,1) - R(1,2)) / z(4);
    z(2) = (R(1,3) + R(3,1)) / z(4);
    z(3) = (R(3,2) + R(2,3)) / z(4);
end  % if

%% Step 5
n = z(1) / 2;
e = zeros(3,1);
for j = 1:3
    e(j) = z(j+1) / 2;
end  % for

%% Step 6: calculate angle and axis, see p. 231
theta = 2 * acos(n);
k = e / sin(theta / 2);
end  % function