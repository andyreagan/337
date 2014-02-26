function dy = andy_hw07_prb01_ODEh(t,y,params)
% [y';v']
% where y' = v, v' = -xv+3y

dy = [y(2);-t*y(2)+3*y(1)];