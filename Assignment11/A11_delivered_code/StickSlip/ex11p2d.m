%% Definitions
gamma = 1e3;
vs = 0.1;

m1 = 10.0; % kg
m2 = 0.1;  % kg
Fu = 1.1;  % N
k  = 0.5;  % N/m
l0 = 2.0;  % m
Fs = 1.0;  % N
Fc = 0.8;  % N

%% Armstrong-Helouvry friction models
Ff_exact  = @(v) ArmstrongHelouvryExact(v, Fc, Fs, vs);
Ff_approx = @(v) ArmstrongHelouvryTanhApprox(v, Fc, Fs, vs, gamma);

%% Calculate
vmax = 0.1;
v = linspace(-vmax, vmax, 10000);
exact  = Ff_exact(v);
approx = Ff_approx(v);
error  = exact - approx;

%% Plot
figure(1);
sgtitle('Comparison of Armstrong-Helouvry friction model');

subplot(311);
plot(v, exact);
xlabel('v [m/s]');
ylabel('Exact');

subplot(312);
plot(v, approx);
xlabel('v [m/s]');
ylabel('sgn = tanh approx');

subplot(313);
plot(v, error);
xlabel('v [m/s]');
ylabel('signed error');


%% Function definitions
function fric = ArmstrongHelouvryExact(v, Fc, Fs, vs)
    fric = (Fc + (Fs - Fc)*exp((v/vs).^2)).*sign(v);
end

function fric = ArmstrongHelouvryTanhApprox(v, Fc, Fs, vs, gamma)
    sgn = @(v) tanh(gamma*v);  % Approx of sign function
    fric = (Fc + (Fs - Fc)*exp((v/vs).^2)).*sgn(v);
end
