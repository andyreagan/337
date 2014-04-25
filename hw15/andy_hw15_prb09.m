% HW15 Problem 9
%
% Solve the 2D IBVP using Peaceman-Rachford ADI method

%% parameters
pb = 1; % whether to plot intermediate solution
t0 = 0.0;
tf = 0.5;
h = 0.1; % one at a time!
k = 0.02;
r = k/h^2;
% domain
ymax = 2.5;
y = (0:h:ymax)';
x = (0:h:1)';
M = length(x); 
L = length(y);
t = (t0:k:tf)';
% initial distribution
[xx,yy] = meshgrid(x,y);
u0 = 10.*sin(pi.*xx).*sin(pi.*yy./ymax)+sin(2*pi.*yy./ymax).*(1-xx)+cos(2*pi.*yy./ymax).*xx;
% boundaries
g00 = @(t,y) sin(2*pi.*y./ymax).*exp(-(2*pi/ymax)^2*t); % x at 0
g10 = @(t,y) cos(2*pi.*y./ymax).*exp(-(2*pi/ymax)^2*t); % x at 1
g01 = @(t,x) x.*exp(-(2*pi/ymax)^2*t); % y at 0
g11 = @(t,x) x.*exp(-(2*pi/ymax)^2*t); % y at ymax

if pb
    figure(15090101); % for watching solution
    subplot(221);
    mesh(yy,xx,u0);
    xlim([0,ymax]);
    xlabel('y','FontSize',16);
    ylabel('x','FontSize',16);
    zlabel('u','FontSize',16);
    zlim([0,max(max(u0))]);
end

A = spdiags(-2*ones(M-2,1),0,M-2,M-2)+...
    spdiags([ones(M-3,1);0],-1,M-2,M-2)+...
    spdiags([0;ones(M-3,1)],1,M-2,M-2);

B = spdiags(-2*ones(L-2,1),0,L-2,L-2)+...
    spdiags([ones(L-3,1);0],-1,L-2,L-2)+...
    spdiags([0;ones(L-3,1)],1,L-2,L-2);

%% solving loop
u = u0;
ustar = zeros(L,M);

for i=2:length(t)
    disp(t(i));
    % update
    % note that the index is (y,x)
    % such that (1:end-2,2:end-1) grabs from 0 boundary in y

        
    % Eq 15.60:
    % set x=0 BC
    ustar(2:end-1,1) = 1/2.*(g00(t(i-1),y(2:end-1))+g00(t(i),y(2:end-1)))...
        +r/4.*(g00(t(i-1),y(3:end))-2.*g00(t(i-1),y(2:end-1))+g00(t(i-1),y(1:end-2)))...
        -r/4.*(g00(t(i),y(3:end))-2.*g00(t(i),y(2:end-1))+g00(t(i),y(1:end-2)));
    % set x=M BC
    ustar(2:end-1,end) = 1/2.*(g10(t(i-1),y(2:end-1))+g10(t(i),y(2:end-1)))...
        +r/4.*(g10(t(i-1),y(3:end))-2.*g10(t(i-1),y(2:end-1))+g10(t(i-1),y(1:end-2)))...
        -r/4.*(g10(t(i),y(3:end))-2.*g10(t(i),y(2:end-1))+g10(t(i),y(1:end-2))); 
    
    % account for these BC from the LHS of the method
    C = zeros(L-2,M-2);
    C(:,1) = ustar(2:end-1,1);
    C(:,end) = ustar(2:end-1,end);
    
    % solve column by column
    for ell=2:L-1
        ustar(ell,2:end-1) = (speye(M-2)-r/2.*A)\...
            (u(ell,2:end-1)'+r/2.*(u(ell+1,2:end-1)'-2.*u(ell,2: ...
                                                          end-1)'+u(ell-1,2:end-1)')+r/2.*C(ell-1,:)');
    end
    

    % solve column by column
    u(:,1) = g00(t(i),y);
    u(:,end) = g10(t(i),y);
    u(1,:) = g01(t(i),x);
    u(end,:) = g11(t(i),x);
    
    % account for these BC from the LHS of the method
    % at the boundaries in y
    C = zeros(L-2,M-2);
    C(1,:) = u(1,2:end-1);
    C(end,:) = u(end,2:end-1);
    
    for m=2:M-1
        u(2:end-1,m) = (speye(L-2)-r/2.*B)\...
            (ustar(2:end-1,m)+r/2.*(ustar(2:end-1,m+1)-2.*ustar(2:end-1,m)+ustar(2:end-1,m-1))+r/2.*C(:,m-1));
    end
    
    if pb
        figure(15090101); % for watching solution
        subplot(221);
        mesh(yy,xx,u);
        xlim([0,ymax]);
        zlim([0,max(max(u0))]);
        xlabel('y','FontSize',16);
        ylabel('x','FontSize',16);
        zlabel('u','FontSize',16);
        pause(.01);
    end
end


%% plotting
% figure(15090201);
% clf;
figure(15090101);
subplot(222);
mesh(yy,xx,u);
xlim([0,ymax]);
xlabel('y','FontSize',16);
ylabel('x','FontSize',16);
zlabel('u','FontSize',16);
title('final solution');

uexact = 10.*sin(pi.*xx).*sin(pi.*yy./ymax).*exp(-(1+1/ymax^2)*pi^2*tf)+(sin(2*pi.*yy./ymax).*(1-xx)+cos(2*pi.*yy./ymax).*xx).*exp(-(2*pi/ymax)^2*tf);y

figure(15090101);
subplot(223);
mesh(yy,xx,uexact);
xlim([0,ymax]);
xlabel('y','FontSize',16);
ylabel('x','FontSize',16);
zlabel('u','FontSize',16);
title('exact');

% compare to exact
% figure(15090301);
% clf;
figure(15090101);
subplot(224);
mesh(yy,xx,abs(uexact-u));
xlim([0,ymax]);
xlabel('y','FontSize',16);
ylabel('x','FontSize',16);
zlabel('u','FontSize',16);
title('error');
