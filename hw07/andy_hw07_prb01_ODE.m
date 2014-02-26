function dy = andy_hw07_prb01_ODE(t,y,params)
% [y';v']
% where y' = v, v' = -xv+3y-3x

dy = [y(2);-t*y(2)+3*y(1)-3*t];