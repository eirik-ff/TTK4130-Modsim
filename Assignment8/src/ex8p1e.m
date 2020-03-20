%% Function
% f(x) = 100(x2 - x1)^2 + (x1 - 1)^4
x = sym('x',[2,1]);
f_sym = 100*(x(2) - x(1))^2 + (x(1) - 1)^4;
Jf_sym = jacobian(f_sym,x);
Gf_sym = Jf_sym.'; % gradient of f
Hf_sym = jacobian(Gf_sym,x);

f  = matlabFunction(f_sym,  'Vars', {x});
Jf = matlabFunction(Jf_sym, 'Vars', {x});
Gf = matlabFunction(Gf_sym, 'Vars', {x});
Hf = matlabFunction(Hf_sym, 'Vars', {x});

x0 = [10; 10];


%% Newtons method
X = NewtonsMethod(Gf,Hf,x0);


%% Error 
x_sol = [1;1];

e = zeros(length(X),1);
for i = 1:length(X)
    e(i) = norm(X(:,i) - x_sol, Inf);
end

%% Order
o = zeros(length(e)-1,1);
for i = 1:length(e)-1
    o(i) = (log10(e(i+1)/e(i)));
end
o'


%% Plot
figure(1);
clf;

t = 1:length(X);
semilogy(t-1, e);
hold on;
grid on;
semilogy(t-1, e, 'o');

xlabel('iteration n');
ylabel('||x_n - x^*||');
title({'Modsim Assignment 8 problem 1e', ...
       'Error at each iteration with Newtons method'});


