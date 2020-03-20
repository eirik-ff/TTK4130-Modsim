function [ state_dot ] = SatelliteDynamics_a( t, state, parameters )
% parameters = {G, m_T, norm_r_c_in_a}
% 
% state = [r_c;
%          R_ba;
%          v_c;
%          omega_ab];
% state = [r_c1; r_c2; r_c3;
%          R_ba1; R_ba2; R_ba3; R_ba4; R_ba5; R_ba6; R_ba7; R_ba8; R_ba9;
%          v_c1; v_c2; v_c3;
%          omega_ab1; omega_ab2; omega_ab3]
% The code must return in the order you selected, e.g.:
%    state_dot =  [velocity;
%                  orientation_dot;
%                  acceleration (ac);
%                  angular acceleration (omega dot)];

r_c = state(1:3);
v_c = state(13:15);
omega_ab_in_b = state(16:18);
R_ba_vec = state(4:12);

x = [r_c; v_c; omega_ab_in_b];
R = reshape(R_ba_vec, [3,3]);

G = parameters{1};
m_T = parameters{2};
norm_r_c_in_a = parameters{3};

grav_force = -G * m_T / norm_r_c_in_a^3;

M = [zeros(3),            eye(3),   zeros(3);
     grav_force * eye(3), zeros(3), zeros(3);
     zeros(3),            zeros(3), zeros(3)];

x_dot = M * x;
R_dot = R * skewsym3x3(omega_ab_in_b);
R_dot_vec = reshape(R_dot, [9,1]);

state_dot = [x_dot(1:3); R_dot_vec; x_dot(4:end)];


end
