function [value, isterminal, direction] = EventStick(~, state, param)
    mass1_pos   = state(1);
    mass2_pos   = state(2);
    Fspring  = param.k*(mass1_pos - mass2_pos - param.x0);        
    value = param.Fs - abs(Fspring);
    isterminal = 1;
    direction  = -1;
end

