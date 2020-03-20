%% Symbolic variables
% Generalized coordinates
syms x real;
syms theta1 real;
syms theta2 real;

% Time derivative of generalized coords
syms dx real;
syms dtheta1 real;
syms dtheta2 real;

q = [x; theta1; theta2];  % generalized coords. vector
dq = [dx; dtheta1; dtheta2];

% Parameters
syms m real;
syms M real;
syms L real;

% Constants
g = 9.81;  % acceleration due to gravity

% Position of masses M
p0 = [x; 0];
p1 = p0 + [L*sin(theta1); -L*cos(theta1)];
p2 = p1 + [L*sin(theta2); -L*cos(theta2)];

% Time derivaitve of position of masses M
dp1 = jacobian(p1, q) * dq;
dp2 = jacobian(p2, q) * dq;


%% Lagrange
% Kinetic energy
T = 1/2 * m * dx^2 + 1/2 * M * (dp1') * dp1 + 1/2 * M * (dp2') * dp2;
T = simplify(T);

% Potential energy
V = M * g * p1(2) + M * g * p2(2);
V = simplify(V);

% External force
F = -10*x - dx;
Q = [F; 0; 0];

% Lagrange function
L = T - V;


% Lagrange equation  (see (2) in task text)
W_hessian = hessian(L, dq);
other_vector = Q + jacobian(L,q)' - jacobian(W_hessian * dq, q) * dq;


%% Export function
state = [x; theta1; theta2; dx; dtheta1; dtheta2];
params = {L, M, m};

syms t real;  % supporting variagble for function creation
matlabFunction(W_hessian, 'File', 'prob1_W_hessian');
matlabFunction(other_vector, 'File', 'prob1_other_vector'); 
% Can't get parameters to work :(       , 'Vars', {t, state, params}
