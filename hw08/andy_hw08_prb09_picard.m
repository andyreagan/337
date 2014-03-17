function [k,errvec] = andy_hw08_prb09_picard(rfunc,A,tvec,yguess,c,tol,h,varargin)
%
% implements the modified picard method
% made a function so that I can throw values of c at it
%
% return the iteration count

% parse input
pb = 0; vb = 0; m = 1;
for i=1:2:nargin-7
    switch varargin{i}
        case 'plot'
            pb = varargin{i+1};
        case 'verbose'
            vb = varargin{i+1};
        case 'modified'
            m = varargin{i+1};
    end
end

% don't need to solve for the BV
y = yguess(2:end-1);
% adjust A for the modified Picard
if m
    A = A-h^2*c.*spdiags(ones(length(A(:,1)),1),0,length(A(:,1)),length(A(:,1)));
end
k = 0;

if pb
    figure;
end

errvec = [];
err = 2*tol;

while err > tol
    k=k+1;
    if m
        ynew = A\(rfunc(tvec(2:end-1),y,h,yguess(1),yguess(end))-h^2*c.*y);
    else
        ynew = A\rfunc(tvec(2:end-1),y,h,yguess(1),yguess(end));
    end
    err = sqrt(sum((ynew-y).^2));
    if vb
        disp(ynew);
        disp(err);
    end
    errvec = [errvec err];
    y = ynew;
    if pb
        plot(tvec,[yguess(1);y;yguess(end)])
        hold on;
        pause(0.1);
    end
    if err > 10^5
        disp('solution exploded')
        break
    end
    if k > 10^3
        disp('iterations do NOT converge !!!!!!!!!!!!!')
        break
    end
end

if err <= tol
    disp('converged!!')
end