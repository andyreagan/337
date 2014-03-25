function dy = andy_exam02_prb02_ODE(t,y,params)
% [u';v']
% where u' = v, v' = (x-6+2u)/t^2

dy = [y(2);(2*y(1)+t-6)/(t^2)];