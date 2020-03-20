clear all
clc

% Parameters
syms m1 m2 L g real
% Force
u = sym('u',[3,1]);

% Positions of point masses
pm1 = sym('pm1',[3,1]);
pm2 = sym('pm2',[3,1]);
dpm1 = sym('dpm1',[3,1]);
dpm2 = sym('dpm2',[3,1]);
ddpm1 = sym('d2pm1',[3,1]);
ddpm2 = sym('d2pm2',[3,1]);
% Generalized coordinates
q  = [pm1;pm2];
dq = [dpm1;dpm2];
ddq = [ddpm1;ddpm2];
% Algebraic variable
z = sym('z');

% Generalized forces
Q = [u; zeros(3,1)];
% Kinetic energy (function of q and dq)
T = 1/2 * m1 * (dpm1.') * dpm1 + 1/2 * m2 * (dpm2.') * dpm2;
% Potential energy
V = m1 * g * pm1(3) + m2 * g * pm2(3);
% Lagrangian (function of q and dq)
Lag = T - V;
% Constraint
dpm  = pm1 - pm2; % difference of positions
C = 1/2 * ((dpm.') * dpm - L^2);

% Derivatives of constrained Lagrangian
Lag_q = simplify(jacobian(Lag,q)).';
Lag_qdq = simplify(jacobian(Lag_q.',dq));
Lag_dq = simplify(jacobian(Lag,dq)).';
Lag_dqdq = simplify(jacobian(Lag_dq.',dq)); % W
C_q = simplify(jacobian(C,q)).';

% Matrices for problem 1b
M = Lag_dqdq;
b = Q + simplify(Lag_q - Lag_qdq*dq - z*C_q);

% Matrices for problem 2
Himplicit = [M, C_q; C_q.', 0];
c = [Q + simplify(Lag_q - Lag_qdq*dq); -jacobian((C_q.')*dq,q)*dq];

Hexplicit = simplify(inv(Himplicit));
rhs = simplify(Hexplicit*c);
