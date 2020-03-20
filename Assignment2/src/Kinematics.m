function [ state_dot ] = Kinematics( t, state, omega_ab_in_b )
    % state_dot is time derivative of your state.
    % Hints:
    % - "parameters" allows you to pass some parameters to the "Kinematic" function.
    % - "state" will contain representations of the solid orientation (SO(3)).
    % - use the "reshape" function to turn a matrix into a vector or vice-versa.
    
    [R,M] = Rotations(state);
    state_dot = M \ omega_ab_in_b;
end
