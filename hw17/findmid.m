function [xlpot,uplot] = findmid(x,u0,mvv)
%
% Compute the discontinuity in the shock wave equation using
% monte carlo evaluation of areas above and below
%
% unfinished

fprintf('find equal area approximation point....\n');

xplot = x;
uplot = 0;

% find the index where it starts coming back
ind = find(x==mvv);
% find the min value from there
b = min(x(ind:end));
% other bound for optimization
c = max(x);
p = (b+c)/2;
fprintf('initial guess is %g\n',p);

% interpolate the function onto a uniform grid
% not as simple as is sounds
newx = b:0.05:c;
newu = u0;

TOL = 10^(-3);
err = 1;
while err > TOL
    % do monte carlo area calculation
    at = max(u0); % box top
    ab = u0(find(x==p)); % box bottom
    p = (p+c)/2;
    err = 0;
end






