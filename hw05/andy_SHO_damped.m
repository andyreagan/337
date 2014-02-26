function dy = andy_SHO_damped(t,y,params)
% simple harmonic oscillator
% y'' = -2\gamma y' -\omega_0^2 y
%
% as a system of two equations:
% v' = -2\gamma v -\omega_0^2 y
% y' = v
%
% return [y';v']

[g,w0] = deal(params{1},params{2});

dy = [y(2);-2*g*y(2)-w0^2*y(1)];