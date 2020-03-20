function [ state_dot ] = GyroscopeDynamics(t, state, parameters)

% state = [r_oc_in_a; v_oc_in_a; omega_ab_in_b; reshape(Rba,[9,1])];
% parameters = {g_in_a, Mbo_in_b, m, L}

g_in_a = parameters{1};
Mbo_in_b = parameters{2};
m = parameters{3};
L = parameters{4};

x = state(1:6);
r_oc_in_a = x(1:3);
v_oc_in_a = x(4:6);
omega_ab_in_b = state(7:9);
R = reshape(state(10:18), 3,3);

M = [zeros(3), eye(3); -sum(v_oc_in_a.^2) / L^2 * eye(3), zeros(3)];
b = [zeros(3,1); -g_in_a];

x_dot = M * x + b;
omega_ab_in_b_dot = (Mbo_in_b) \ (skewsym3x3(omega_ab_in_b) * Mbo_in_b * omega_ab_in_b + ...
                        m * skewsym3x3(R' * r_oc_in_a) * R' * g_in_a);

R_dot = R * skewsym3x3(omega_ab_in_b);

state_dot = [x_dot; omega_ab_in_b_dot; reshape(R_dot, 9,1)];


end