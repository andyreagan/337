function dy = andy_SHO_2(t,y,params)
% simple harmonic oscillator
% y'' = -y
%
% as a system of two equations:
% v' = -y
% y' = v
%
% return [y';v']

dy = [y(2);-y(1)];