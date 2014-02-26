function yvec = andy_symE3(func,tspan,y0,h,params)
% symplectic Euler 3
%
% updates the equations in random order
%
% evaluates the function func for the whole new yvec, but
% really only needed the jth update (this is 
% unnecessary function evaluation)

t = tspan(1);

% random permutation (keep this random order)
rl = randperm(length(y0));
fprintf('using the random permutation:\n');
disp(rl);

% don't preallocate
yvec =  [];
yvec = [yvec y0];

for i=2:length(tspan)
    % guess
    ynew = yvec(:,i-1);
    for j=rl
        % update y
        tmp = yvec(:,i-1)+h*func(t,ynew,params);
        % set
        ynew(j) = tmp(j);
    end
    % savep
    yvec = [yvec ynew];
    t = t+h;
end