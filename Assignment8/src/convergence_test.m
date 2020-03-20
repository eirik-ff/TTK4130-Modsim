f = @(x) 10.^(-2 * x);

x = 0:0.01:1;
y = f(x);

e = y(2:end) - y(1:end-1);

semilogy(x(1:end-1), e);
semilogy(x, y);