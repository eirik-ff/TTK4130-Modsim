%% Functions
x = sym('x',[2,1]);

f_sym = [x(1)*x(2) - 2; x(1)^4/4 + x(2)^3/3 - 1];
Jf_sym = jacobian(f_sym,x); 

f = matlabFunction(f_sym, 'vars', {x});
Jf = matlabFunction(Jf_sym, 'vars', {x});

x0 = [-1; -1]; 

%% Newtons method
X = NewtonsMethod(f,Jf,x0);

%% Inf-norm residuals
R = zeros(1,length(X));
for i = 1:length(R)
    R(i) = norm(f(X(:,i)),Inf);
end

%% Plotting f
figure(1);
clf;

f_iters = 1:length(R);
semilogy(f_iters-1, R(f_iters));
hold on;
grid on;
xticks(f_iters);

title({'TTK4130 Assignment 8 problem 1b','Infinity norm of residuals'});
xlabel('iteration n');
ylabel('|| f(x_k) ||_\infty');

