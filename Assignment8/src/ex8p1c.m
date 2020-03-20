%% Function definition
% f(x) = (x - 1)(x - 2)(x - 3) + 1
f = @(x) x.^3 - 6*x.^2 + 11*x - 5;
Jf = @(x) 3*x.^2 - 12*x + 11;

x0 = 3;


%% Newtons method
X = NewtonsMethod(f,Jf,x0);


%% Plotting
t = linspace(floor(min(X)), ceil(max(X)), 1000);

figure(1);
clf;

subplot(311);
hold on;
grid on;
title({'Modsim Assignment 8 problem 1c', 'Function f with Newton''s method iteration'});
plot(t, zeros(size(t)), 'k--');
plot(t, f(t), 'LineWidth',1);
plot(X, f(X), 'o');
plot(X(end), f(X(end)), 'g*', 'MarkerSize',6);
xlabel('x');
ylabel('f(x)');


subplot(312);
plot(X, (0:length(X)-1));
hold on;
grid on;
ylim([0, length(X)-1]);
set(gca, 'YDir','reverse'); % flip y axis

title('x value of iteration');
ylabel('iteration n');
xlabel('x');


subplot(313);
hold on;
grid on;
title('Zoomed in around solution');
plot(t, zeros(size(t)), 'k--');
plot(t, f(t), 'LineWidth',1);
plot(X, f(X), 'o');
plot(X(end), f(X(end)), 'g*', 'MarkerSize',10,'LineWidth',1.5);
text(X(end), f(X(end))-0.2, sprintf('x = %.3f', X(end)), 'HorizontalAlignment','left');
xlim([0.4 1]);
ylim([-1 1]);

xlabel('x');
ylabel('f(x)');


