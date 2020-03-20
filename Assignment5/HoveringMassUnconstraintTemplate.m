clear all
clc

% Parameters
syms m1 m2 L g real
% Force
u = sym('u',[3,1]);

% Position point mass 1
pm1 = sym('p1',[3,1]);
dpm1 = sym('dp1',[3,1]);
ddpm1 = sym('d2p1',[3,1]);
% Angles for point mass 2
a  = sym('a',[2,1]);
da = sym('da',[2,1]);
dda = sym('d2a',[2,1]);
% Generalized coordinates
q  = [pm1;a];
dq = [dpm1;da];
ddq = [ddpm1;dda];

% Position of point mass 2
pm2  = pm1 + [L*sin(a(1))*cos(a(2)); L*sin(a(1))*sin(a(2)); L*cos(a(1))];
% Velocity of point mass 2
dpm2 = jacobian(pm2,q)*dq;
% Generalized forces
Q = [u; 0; 0];
% Kinetic energy
T = 1/2 * m1 * (dpm1.') * dpm1 + 1/2 * m2 * (dpm2.') * dpm2;
T = simplify(T);
% Potential energy
V = m1 * g * pm1(3) + m2 * g * pm2(3);
V = simplify(V);
% Lagrangian
Lag = T - V;

% Derivatives of the Lagrangian
Lag_q = simplify(jacobian(Lag,q)).';
Lag_qdq = simplify(jacobian(Lag_q.',dq));
Lag_dq = simplify(jacobian(Lag,dq)).';
Lag_dqdq = simplify(jacobian(Lag_dq.',dq)); % W

% Matrices for problem 1
M = Lag_dqdq;
b = Q + simplify(Lag_q - Lag_qdq*dq);
