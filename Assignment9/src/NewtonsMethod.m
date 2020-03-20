function x = NewtonsMethod(f,J,x0,tol,N)
    if nargin < 5
        N = 100;
    end
    if nargin < 4
        tol = 1e-6;
    end
    x = x0;
    n = 1;
    fx = f(x);    
    iterate = norm(fx,Inf) > tol;
    while iterate
        x = x - J(x)\fx;
        n = n+1;
        fx = f(x);
        iterate = norm(fx,Inf) > tol && n <= N;
    end
end