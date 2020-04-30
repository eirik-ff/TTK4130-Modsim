%% model and simulation parameters
% model parameters
m = 1; % mass
c = 0.01; % friction coefficient
g = 9.81; % acceleration of gravity

% vector field of ODE
% x = [p1; p2; p1dot; p2dot];
BallDynamics = @(t,x) vertcat(x(3:4),-[0;g] -c/m*norm(x(3:4),2)*x(3:4));

% simulation parameters
x0 = [0;10;0;0];
t0 = 0;
tf = 20;
dt = 0.5;
ForwardEuler = struct('A',0,'b',1,'c',0);
T = t0:dt:tf;
Nt = length(T);

%% simulation of naive approach
x = zeros(4,Nt);
xt = x0;
x(:,1) = x0;
for nt = 2:Nt
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % use ERK to get next state estimate xt
    Tt = [nt-1, nt];
    Xseries = ERK(ForwardEuler,BallDynamics,Tt,xt);
    xt = Xseries(:,2);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % check for event and update xt if so
    if xt(2) <= 0 && xt(4) < 0
        xt = [xt(1:3); -xt(4)];
    end
    x(:,nt) = xt;
end

%% plot results for naive approach
figure
hold on
plot([t0,tf],[0,0],'k')
plot(T,x(2,:),'b')
hold off
title(['Naive approach with time step ',num2str(dt)])
xlabel('time t')
ylabel('height p_2')
