function X = NewtonsMethod(f, J, x0, tol, N)
    % Returns the iterations X of the Newton's method
    % f: Function handle
    %    Objective function, i.e. equation f(x)=0
    % J: Function handle
    %    Jacobian of f
    % x0: Initial root estimate, Nx x 1
    % tol: tolerance
    % N: Maximum number of iterations
    if nargin < 5
        N = 100;
    end
    if nargin < 4
        tol = 1e-6;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Define variables
    % Allocate space for iterations (X)
    nx = size(x0,1);
    X = NaN(nx,N+1);
    X(:,1) = x0;
    
    xn = x0; % initial estimate
    n = 1; % iteration number
    fn = f(xn); % save calculation    
    % Iterate until f(x) is small enough or
    % the maximum number of iterations has been reached
    while norm(fn,Inf) > tol && n <= N
        % Calculate and save next iteration value x
        fn = f(xn);
        Jn = J(xn);
        dx = -Jn \ fn;
        xn = xn + dx;
        X(:,n+1) = xn;
        
        n = n + 1;
    end % while
    
    % remove NaN but keep shape of X
    X = X(:,1:n);
end % function
