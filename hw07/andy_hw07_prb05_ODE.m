function dy = andy_hw07_prb05_ODE(t,y,params)
% [y';v']
% where y' = v, v' = -xv+3y-3x

dy = [y(2);y(1)^2/(2+t)];