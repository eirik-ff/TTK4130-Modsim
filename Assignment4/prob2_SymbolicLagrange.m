%% Symbolic variables
% Generalized coordinates
syms x real;
syms theta real;

% Time derivative of generalized coords
syms dx real;
syms dtheta real;

q = [x; theta];  % generalized coords. vector
dq = [dx; dtheta];

% Parameters
syms R real;
syms M real;
syms J real;

% Constants
g = 9.81;  % acceleration due to gravity


% Position of ball in frame a
p_a = [x*cos(theta); 0; x*sin(theta)];

%% Lagrange
% Kinetic energy
T = 1/2 * M * dx^2 + 1/2 * J * dtheta^2 + 1/2 * 2/5 * M * R^2 * (dtheta + dx/R)^2;
T = simplify(T);

% Potential energy
V = M * g * p_a(3);
V = simplify(V);

% External torque
Torque = 200 * (x - theta) + 70 * (dx - dtheta); 
Q = [0; Torque];

% Lagrange function
L = T - V;


% Lagrange equation  (see (2) in task text)
W_hessian = hessian(L, dq);
other_vector = Q + jacobian(L,q)' - jacobian(W_hessian * dq, q) * dq;


%% Export function
state = [q; dq];
params = [J; M; R];

matlabFunction(W_hessian, 'File', 'prob2_W_hessian', 'Vars', {state, params});
matlabFunction(other_vector, 'File', 'prob2_other_vector', 'Vars', {state, params}); 
% Can't get parameters to work :(       , 'Vars', {state, params}
