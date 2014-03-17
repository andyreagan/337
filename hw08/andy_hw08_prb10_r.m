function r = andy_hw08_prb10_r(x,y,h,alpha,beta,varargin)
% return the RHS r vector for Newton-Raphson
%
% make sure to pass x from x_1 to x_N-1
% and same with y

r = -2.*y-h^2.*y./(2+x);
r = r+[y(2:end);beta];
r = r+[alpha;y(1:end-1)];
