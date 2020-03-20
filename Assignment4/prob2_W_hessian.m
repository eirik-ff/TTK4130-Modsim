function W_hessian = prob2_W_hessian(in1,in2)
%PROB2_W_HESSIAN
%    W_HESSIAN = PROB2_W_HESSIAN(IN1,IN2)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    11-Feb-2020 11:27:04

J = in2(1,:);
M = in2(2,:);
R = in2(3,:);
t2 = M.*R.*(2.0./5.0);
W_hessian = reshape([M.*(7.0./5.0),t2,t2,J+M.*R.^2.*(2.0./5.0)],[2,2]);
