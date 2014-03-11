function r = andy_hw08_prb08_r(x,y,h,alpha,beta,varargin)

r = (h^2.*y.^2./(2+x));
disp(r);
r(1) = r(1) - alpha; r(end) = r(end) - beta;