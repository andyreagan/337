% HW15 Problem 8
%
% Solve the 2D IBVP using Peaceman-Rachford ADI method
% A coding bonanza unfolds below

%% parameters
t0 = 0.0;
tf = 3;
h = 0.1; % one at a time!
k = 0.02;
r = k/h^2;
% domain
ymax = 2.5;
y = (0:h:ymax)';
x = (0:h:1)';
M = length(x); 
N = length(y);
t = (t0:k:tf)';
% initial distribution
[xx,yy] = meshgrid(x,y);
u0 = 10.*sin(pi.*xx).*sin(pi.*yy./ymax)+sin(2*pi.*yy./ymax).*(1-xx)+cos(2*pi.*yy./ymax).*xx;
% boundaries
g00 = @(t,y) sin(2*pi.*y./ymax).*exp(-(2*pi/ymax)^2*t); % x at 0
g10 = @(t,y) cos(2*pi.*y./ymax).*exp(-(2*pi/ymax)^2*t); % x at 1
g01 = @(t,x) x.*exp(-(2*pi/ymax)^2*t); % y at 0
g11 = @(t,x) x.*exp(-(2*pi/ymax)^2*t); % y at ymax

A = spdiags(-2*ones(M-2,1),0,M-2,M-2)+...
    spdiags([ones(M-3,1);0],-1,M-2,M-2)+...
    spdiags([0;ones(M-3,1)],1,M-2,M-2);

B = spdiags(-2*ones(N-2,1),0,N-2,N-2)+...
    spdiags([ones(N-3,1);0],-1,N-2,N-2)+...
    spdiags([0;ones(N-3,1)],1,N-2,N-2);

%% solving loop
u = u0;
ustar = zeros(N,M);

for i=2:length(t)
    disp(t(i));
    % update
    % note that the index is (y,x)
    % such that (1:end-2,2:end-1) grabs from 0 boundary in y
    
    % solve column by column
    for ell=2:N-1
        ustar(ell,2:end-1) = (speye(M-2)-r/2.*A)\...
            (u(ell,2:end-1)'+r/2.*(u(ell+1,2:end-1)'-2.*u(ell,2:end-1)'+u(ell-1,2:end-1)'));
    end
    
    % Eq 15.60:
    % set x=0 BC
    ustar(2:end-1,1) = 1/2.*(g00(t(i-1),y(2:end-1))+g00(t(i),y(2:end-1)))...
        +r/4.*(g00(t(i-1),y(3:end))-2.*g00(t(i-1),y(2:end-1))+g00(t(i-1),y(1:end-2)))...
        +r/4.*(g00(t(i),y(3:end))-2.*g00(t(i),y(2:end-1))+g00(t(i),y(1:end-2)));
    % set x=M BC
    ustar(2:end-1,end) = 1/2.*(g10(t(i-1),y(2:end-1))+g10(t(i),y(2:end-1)))...
        +r/4.*(g10(t(i-1),y(3:end))-2.*g10(t(i-1),y(2:end-1))+g10(t(i-1),y(1:end-2)))...
        +r/4.*(g10(t(i),y(3:end))-2.*g10(t(i),y(2:end-1))+g10(t(i),y(1:end-2)));
    
    % solve column by column
    for m=2:M-1
        u(2:end-1,m) = (speye(N-2)-r/2.*B)\...
            (ustar(2:end-1,m)+r/2.*(ustar(2:end-1,m+1)-2.*ustar(2:end-1,m)+ustar(2:end-1,m-1)));
    end
    u(:,1) = g00(t(i),y);
    u(:,end) = g10(t(i),y);
    u(1,:) = g01(t(i),x);
    u(end,:) = g11(t(i),x);
        
    % check minimax prinicple
    % if max(unew) > max(u0)
    %     fprintf('your solution is behaving badly\n')
    %     break
    % end
end












