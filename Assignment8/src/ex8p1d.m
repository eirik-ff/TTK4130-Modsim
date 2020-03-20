%% Function definition
x = sym('x', [2,1]);
f_sym = [x(1) - 1 + cos(x(2))*(cos(x(2))*x(1) + 1);
         -x(1)*sin(x(2))*(cos(x(2))*x(1)+1)];
Jf_sym = jacobian(f_sym,x);

f = matlabFunction(f_sym, 'Vars',{x});
Jf = matlabFunction(Jf_sym, 'Vars',{x});

x0 = [1;3];


%% Newtons method
X = NewtonsMethod(f,Jf,x0);


%% Inf-norm residuals
Rf = zeros(1,length(X));
for i = 1:length(Rf)
    Rf(i) = norm(f(X(:,i)),Inf);
end

%% Plotting f
figure(1);
clf;

t = 1:length(Rf);
semilogy(t-1, Rf);
hold on;
grid on;

semilogy(t-1, Rf, 'o');
for i = t
    text(i-1, (Rf(i))*1.5, {sprintf('[%.2f]', X(1,i)),sprintf('[%.2f]', X(2,i))});
end


xticks(t-1);
xlabel('iteration n');
ylabel('|| f(x_k) ||_\infty');
title({'Modsim assignment 8 problem 1d','Infinity norm of residuals'});