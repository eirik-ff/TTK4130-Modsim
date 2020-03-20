function [ state_dot ] = KinematicsDCM( t, state, omega_ab_in_b )
    % state_dot is time derivative of your state.
    % Hints:
    % - "parameters" allows you to pass some parameters to the "Kinematic" function.
    % - "state" will contain representations of the solid orientation (SO(3)).
    % - use the "reshape" function to turn a matrix into a vector or vice-versa.
    
    % t: time
    % state: reshaped R matrix in 9x1
    % omega_ab_in_b: rotation axis omega_ab in frame b
    %
    % state_dot: derivative of state reshaped to 9x1
    
    R = reshape(state, [3,3]);
    OmegaX = skewsym3x3(omega_ab_in_b);
    R_dot = R * OmegaX;
    state_dot = reshape(R_dot, [9,1]);
end
