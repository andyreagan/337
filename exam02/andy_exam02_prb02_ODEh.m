function dy = andy_exam02_prb02_ODEh(t,y,params)
% [u';v']
% where u' = v, v' = (2u)/t^2

dy = [y(2);(2*y(1))/(t^2)];