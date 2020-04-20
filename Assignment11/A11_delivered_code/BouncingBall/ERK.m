function x = ERK(ButcherArray, f, T, x0)
    % Returns the iterations of an ERK method
    % ButcherArray: Struct with the ERK's Butcher array
    % f: Vector field of ODE, i.e., x_dot = f(t,x)
    % T: Vector of time points, 1 x Nt
    % x0: Initial state, Nx x 1
    % x: ERK iterations, Nx x Nt
    Nt = length(T);
    Nx = length(x0);
    dT = diff(T);
    x = zeros(Nx,Nt);
    x(:,1) = x0;
    A = ButcherArray.A;
    b = ButcherArray.b(:);
    c = ButcherArray.c(:);
    Nstage = size(A,1);
    K = zeros(Nx,Nstage);
    xt = x0;
    for nt=2:Nt
        t = T(nt-1);
        dt = dT(nt-1);
        K(:,1) = f(t,xt);
        for nstage=2:Nstage
            a = A(nstage,1:nstage-1)';
            K(:,nstage) = f(t+dt*c(nstage),xt+dt*(K(:,1:nstage-1)*a));            
        end
        xt = xt + dt*(K*b);
        x(:,nt) = xt;
    end
end