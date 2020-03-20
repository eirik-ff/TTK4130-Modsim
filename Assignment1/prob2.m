%% Common
tspan = [0 5];

%% Function 1
f1 = @(t, x) x^2;
x0 = 1;
[t1, x1] = ode45(f1, tspan, x0);

figure(1);
plot(t1, x1);
title('Function 1: $\dot{x} = x^2$', 'interpreter', 'latex');
grid on;


%% Function 2
f2 = @(t, x) sqrt(abs(x));
x0 = 0;
[t2, x2] = ode45(f2, tspan, x0);

figure(2);
plot(t2, x2);
title('Function 2: $\dot{x} = \sqrt{|x|}$', 'interpreter', 'latex');
grid on;

