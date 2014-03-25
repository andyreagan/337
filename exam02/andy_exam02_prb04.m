% Exam 2 Problem 4
%
% solve the nonlinear BVP using Newton-Raphson

% IC, BC
y0 = 0; yf = 0;
h = 0.05;

tol = 10^(-9);
x = (-15:h:15)';
N = length(tvec)-2;
itercount=0;
err = 1;

% set y
y = exp(-x.^2);
lambda = 2.25;
% y = x.*exp(-x.^2);
% lambda = 0.778;
y = y(2:end-1);

% figure for plotting iterates
figure;
plot(x,[y0;y;yf])
errvec = [];

while err > tol
    % iterate
    itercount=itercount+1;
    
    % build A and r
    A = spdiags(-2+h^2.*(-3.*y.^2-lambda+6.*(sech(x(2:end-1)).^2)),0,N,N)...
        +spdiags(ones(N,1),-1,N,N)...
        +spdiags(ones(N,1),1,N,N);
    r = andy_exam02_prb04_r(x(2:end-1),y,h,y0,yf,[lambda]);
    
    % solve for error estimate
    epsnew = A\r;
    
    % update y
    ynew = y-epsnew;
    %disp(ynew);
    
    % use 2-norm for error (reasonable thing to do)
    err = sqrt(sum((ynew-y).^2));
    errvec = [errvec err];
    %disp(err);
    
    % set y to the new value
    y = ynew;
    % intermediate plots
    pause(.1);
    plot(x,[y0;y;yf])
    % save yourself ryan
    if itercount > 1000
        break
    end
end
% how did we do?
fprintf('took %g iterations with h = %g\n',itercount,h);

% plot final solution
soln = [y0;y;yf];
figure;
plot(x,soln);
xlabel('x');
ylabel('u');

figure;
plot(errvec);
xlabel('iteration');
ylabel('error');