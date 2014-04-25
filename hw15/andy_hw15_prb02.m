% HW15 Problem 2
%
% Solve the 2D IBVP using the simple explicit method

%% parameters
pb = 1; % whether to plot intermediate solution
t0 = 0.0;
tf = 0.5;
h = 0.1; % one at a time!
k = 0.002;
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
g00 = @(t) sin(2*pi.*y./ymax).*exp(-(2*pi/ymax)^2*t); % x at 0
g10 = @(t) cos(2*pi.*y./ymax).*exp(-(2*pi/ymax)^2*t); % x at 1
g01 = @(t) x.*exp(-(2*pi/ymax)^2*t); % y at 0
g11 = @(t) x.*exp(-(2*pi/ymax)^2*t); % y at ymax

u = u0;

%% solving loop

if pb
    figure(15020101); % for watching solution
    subplot(221);
    mesh(yy,xx,u0);
    xlabel('y','FontSize',16);
    ylabel('x','FontSize',16);
    zlabel('u','FontSize',16);
    zlim([0,max(max(u0))]);
end

for i=2:length(t)
    disp(t(i));
    % first set the size of unew
    unew = zeros(N,M);
    % take the middle of the matrix
    umid = u(2:end-1,2:end-1);
    % update
    % note that the index is (y,x)
    % such that (1:end-2,2:end-1) grabs from 0 boundary in y
    unew(2:end-1,2:end-1) = (1-4*r).*umid...
        +r.*u(1:end-2,2:end-1)+r.*u(3:end,2:end-1)... % shifted in y
        +r.*u(2:end-1,1:end-2)+r.*u(2:end-1,3:end); % shifted in x
    unew(:,1) = g00(t(i));
    unew(:,end) = g10(t(i));
    unew(1,:) = g01(t(i));
    unew(end,:) = g11(t(i));
    
    % check minimax prinicple
    % if max(unew) > max(u0)
    %     fprintf('your solution is behaving badly\n')
    %     break
    % end
    
    u = unew;
    
    if pb
        figure(15020101); % for watching solution
        subplot(221);        
        mesh(yy,xx,u);
        xlim([0,ymax]);
        zlim([0,max(max(u0))]);
        xlabel('y','FontSize',16);
        ylabel('x','FontSize',16);
        zlabel('u','FontSize',16);
        % pause(.01);
    end
end

title('intermediate solution');

%% plotting
% figure(15020201);
% clf;
figure(15020101);
subplot(222);        
mesh(yy,xx,u);
xlim([0,ymax]);
xlabel('y','FontSize',16);
ylabel('x','FontSize',16);
zlabel('u','FontSize',16);
title('final solution');

uexact = 10.*sin(pi.*xx).*sin(pi.*yy./ymax).*exp(-(1+1/ymax^2)*pi^2*tf)+(sin(2*pi.*yy./ymax).*(1-xx)+cos(2*pi.*yy./ymax).*xx).*exp(-(2*pi/ymax)^2*tf);y

figure(15020101);
subplot(223);        
mesh(yy,xx,uexact);
xlim([0,ymax]);
xlabel('y','FontSize',16);
ylabel('x','FontSize',16);
zlabel('u','FontSize',16);
title('exact');


% compare to exact
% figure(15020301);
% clf;
figure(15020101);
subplot(224);        
mesh(yy,xx,abs(uexact-u));
xlim([0,ymax]);
xlabel('y','FontSize',16);
ylabel('x','FontSize',16);
zlabel('u','FontSize',16);
title('error');