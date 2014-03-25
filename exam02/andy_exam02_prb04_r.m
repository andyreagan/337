function r = andy_exam02_prb04_r(x,y,h,alpha,beta,params)
% return the RHS r vector for Newton-Raphson
%
% make sure to pass x from x_1 to x_N-1
% and same with y

lambda = params(1);

r = -2.*y-h^2.*y.*(y.^2+lambda-6.*(sech(x).^2)); % the y_n terms
r = r+[y(2:end);beta]; % the y_n+1 terms
r = r+[alpha;y(1:end-1)]; % the y_n-1 terms
