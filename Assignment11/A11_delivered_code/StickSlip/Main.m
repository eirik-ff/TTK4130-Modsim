clear all
clc
close all
% model parameters
param.m1 = 10;
param.m2 = 0.1;
param.k  = 0.5;
param.x0 = 2;
param.Fu = 1.1; 
param.Fs = 1;
param.Fc = 0.8;
% model dynamics
Stick = @(t,x) DynStick(t, x, param);
Slip  = @(t,x) DynSlip(t, x, param);
% simulation parameters
x0 = [-8;-10;1;0];
tf = 15;
% event detection
EventStick = @(t,x)EventStick( t, x, param);
EventSlip  = @(t,x)EventSlip(  t, x, param);
optStick = odeset('RelTol',1e-6,'AbsTol',1e-6,'Events',EventStick);
optSlip  = odeset('RelTol',1e-6,'AbsTol',1e-6,'Events',EventSlip);
% simulation
% it goes back-and-forth between stick and slip, starting with stick
tsim = 0;
xsim = x0.';
stick = 1;
while true
    [tsim_k,xsim_k] = ode15s(Stick,[tsim(end),tf],xsim(end,:).',optStick);
    tsim = [tsim;tsim_k(2:end)];
    xsim = [xsim;xsim_k(2:end,:)];
    stick = [stick;ones(length(tsim_k)-1,1)];
    if tsim(end) == tf
        break
    end
    [tsim_k,xsim_k] = ode15s(Slip,[tsim(end),tf],xsim(end,:).',optSlip);
    tsim = [tsim;tsim_k(2:end)];
    xsim = [xsim;xsim_k(2:end,:)];
    stick = [stick;zeros(length(tsim_k)-1,1)];
    if tsim(end) == tf
        break
    end
end
% plot simulated states
% the curves are red when m2 sticks, and blue when m2 slips
tStick = tsim;
tStick(stick==0) = nan;
tSlip = tsim;
tSlip(stick==1) = nan;
figure(1)
clf
for k = 1:4
    subplot(2,2,k);
    hold on
    plot(tStick,xsim(:,k),'linewidth',2,'color','r')
    plot(tSlip,xsim(:,k),'linewidth',2,'color','b')
    hold off
    switch k
        case 1
            ylabel('x_1')
        case 2
            ylabel('x_2')
        case 3
            ylabel('v_1')
        case 4
            ylabel('v_2')
    end
    xlabel('t')
end
% animation
% the block for m2 is red when m2 sticks, and blue when m2 slips
transparency = 0.7;
tic
tDisplay = 0;
 while tDisplay < tf
    stateDisplay = interp1(tsim,xsim,tDisplay).';    
    stickDisplay = interp1(tsim,stick,tDisplay).';
    figure(2)
    clf
    hold on
    DrawStickSlip(stateDisplay,[stickDisplay,0,1-stickDisplay],transparency);
    drawnow
    if tDisplay == 0
        disp('Press a key to start animation')
        pause
        tic
    end
    tDisplay = toc;
 end
 