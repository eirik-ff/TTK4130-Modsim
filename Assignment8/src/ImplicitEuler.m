function x = ImplicitEuler(f, dfdx, T, x0)
    % Returns the iterations of the implicit Euler method
    % f: Function handle
    %    Vector field of ODE, i.e., x_dot = f(t,x)
    % dfdx: Function handle
    %       Jacobian of f w.r.t. x
    % T: Vector of time points, 1 x Nt
    % x0: Initial state, Nx x 1
    % x: Implicit Euler iterations, Nx x Nt
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Define variables
    % Allocate space for iterations (x)
    nx = size(x0,1);
    Nt = size(T,2);
    
    x = zeros(nx,Nt);
    x(:,1) = x0;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    xt = x0;
    % Loop over time points
    for nt=2:Nt
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Update variables
        % Define the residual function for this time step
        % Define the Jacobian of this residual
        % Call your Newton's method function
        % Calculate and save next iteration value xt
        dt = T(nt) - T(nt-1);
        
        r = @(xt1) xt + dt * f(nt, xt1) - xt1;
        drdx = @(xt1) dt * dfdx(nt, xt1) - eye(nx);
        
        xt1 = NewtonsMethod(r, drdx, xt);
        xt1 = xt1(:,end); % last element is solution
        
        x(:,nt) = xt + dt * f(nt, xt1);
        xt = x(:,nt);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
end
