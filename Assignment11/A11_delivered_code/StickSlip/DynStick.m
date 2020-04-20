function state_dot = DynStick(~, state, param)    
    mass1_pos   = state(1);
    mass2_pos   = state(2);
    Fspring  = param.k*(mass1_pos - mass2_pos - param.x0); 
    mass1_acc  = (param.Fu - Fspring)/param.m1;
    mass2_acc  = 0;
    state_dot = [state(3:4);
                 mass1_acc;
                 mass2_acc];
end

