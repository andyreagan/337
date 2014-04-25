% HW15 Problem 8: no plots, no output (for testing speed)
%
% Solve the 2D IBVP using Peaceman-Rachford ADI method

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
u0 = sin(pi.*xx).*sin(pi.*yy./ymax);
% boundaries
g00 = 0.*ones(length(t),1); % x at 0
g10 = 0.*ones(length(t),1); % x at 1
g01 = 0.*ones(length(t),1); % y at 0
g11 = 0.*ones(length(t),1); % y at ymax

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
    % disp(t(i));
    % update
    % note that the index is (y,x)
    % such that (1:end-2,2:end-1) grabs from 0 boundary in y
    
    % solve column by column
    for ell=2:N-1
        ustar(ell,2:end-1) = (speye(M-2)-r/2.*A)\...
            (u(ell,2:end-1)'+r/2.*(u(ell+1,2:end-1)'-2.*u(ell,2:end-1)'+u(ell-1,2:end-1)'));
    end
    % ustar(:,1) = g00(t(i));
    % ustar(:,end) = g10(t(i));
    % ustar(1,:) = g01(t(i));
    % ustar(end,:) = g11(t(i));
    
    % solve column by column
    for m=2:M-1
        u(2:end-1,m) = (speye(N-2)-r/2.*B)\...
            (ustar(2:end-1,m)+r/2.*(ustar(2:end-1,m+1)-2.*ustar(2:end-1,m)+ustar(2:end-1,m-1)));
    end
    % unew(:,1) = g00(t(i));
    % unew(:,end) = g10(t(i));
    % unew(1,:) = g01(t(i));
    % unew(end,:) = g11(t(i));
        
    % check minimax prinicple
    % if max(unew) > max(u0)
    %     fprintf('your solution is behaving badly\n')
    %     break
    % end
end