function [value, isterminal, direction] = EventSlip(~, state, ~)
    value   = state(4);
    isterminal = 1;
    direction  = 0;
end

