function yvec = andy_symE2(func,tspan,y0,h,params)
% symplectic Euler 2
%
% updates the equations in reverse order
%
% evaluates the function func for the whole new yvec, but
% really only needed the jth update (this is 
% unnecessary function evaluation)

t = tspan(1);

% don't preallocate
yvec =  [];
yvec = [yvec y0];

for i=2:length(tspan)
    % guess
    ynew = yvec(i-1);
    for j=fliplr(1:length(y0))
        % update y
        tmp = yvec(i-1)+h*func(t,ynew,params);
        % set
        ynew(j) = tmp(j);
    end
    % savep
    yvec = [yvec ynew];
    t = t+h;
end