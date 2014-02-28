function dy = andy_hw07_prb06_ODE(t,y,params)
% [y';v']
% where y' = v, v' = (lambda^2 - 2sech^2 (x))y

dy = [y(2);y(1)*(params(1)^2-2*sech(t)^2)];