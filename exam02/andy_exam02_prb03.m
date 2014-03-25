% Exam 02 Problem 3
%
%

h = 0.1;
x = (2:h:3)';
N = length(x);
y0 = -15/19;
yf = 0;
% next for BC
a1 = 0;
a2 = 1;
% set r, N of them
r = h^2.*(x(1:end-1)-6)./(x(1:end-1).^2); %h^2*R_n
% account for BC
r(1) = r(1)+2*h*y0/a2; % equation 8.36
r(end) = r(end)-yf; % usual (eq 8.7)
% build A
A = spdiags(-(2+2*h^2./x(1:end-1).^2),0,N-1,N-1)... % main diagonal
    +spdiags(ones(N-1,1),-1,N-1,N-1)... % sub
    +spdiags(ones(N-1,1),1,N-1,N-1); % super
% account for mixed BC
A(1,1:2) = A(1,1:2)+[2*h*a1/a2,1]; % should add 0 to main diag, 1 to off
disp(A);

% check sizes
size(A)
size(r)

% solve
yNum = [A\r;yf];

yExact = (114.*x - 19.*x.^2 - 5.*x.^3 - 36)./(38.*x);

figure;
plot(x,yNum,'b');
hold on;
plot(x,yExact,'r');
xlabel('x')
ylabel('u')
legend({'numerical','analytical'})

figure;
plot(x,abs(yNum-yExact),'b');
xlabel('x')
ylabel('error in u')

