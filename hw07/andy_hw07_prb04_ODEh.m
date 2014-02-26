function dy = andy_hw07_prb04_ODEh(t,y,params)
% [y';v']
% where y' = v, v' = -xv+3y

dy = [y(2);30^2*(y(1))];