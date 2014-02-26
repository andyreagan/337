function dy = andy_hw07_prb04_ODE(t,y,params)
% [y';v']
% where y' = v, v' = -xv+3y-3x

dy = [y(2);30^2*(y(1)-1+2*t)];