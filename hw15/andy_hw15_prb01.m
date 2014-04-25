% HW15 Problem 1
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
ymids = y(2:end-1);
x = (0:h:1)';
xmids = x(2:end-1);
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

u = u0;

%% solving loop

if pb
    figure(15010101); % for watching solution
    subplot(221);
    mesh(u0);
    xlabel('y','FontSize',16);
    ylabel('x','FontSize',16);
    zlabel('u','FontSize',16);
    zlim([0,1]);
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
    
    % check minimax prinicple
    % if max(unew) > max(u0)
    %     fprintf('your solution is behaving badly\n')
    %     break
    % end
    
    u = unew;
    
    if pb
        figure(15010101); % for watching solution
        subplot(221);
        mesh(yy,xx,u);
        xlim([0,ymax]);
        zlim([0,1]);
        xlabel('y','FontSize',16);
        ylabel('x','FontSize',16);
        zlabel('u','FontSize',16);
        % pause(.1);
    end
end

title('intermediate solution');
%% plotting
% figure(15010201);
% clf;
figure(15010101); 
subplot(222);
mesh(yy,xx,u);
xlim([0,ymax]);
xlabel('y','FontSize',16);
ylabel('x','FontSize',16);
zlabel('u','FontSize',16);
title('final solution');

uexact = sin(pi.*xx).*sin(pi.*yy./ymax).*exp(-(1+1/ymax^2)*(pi^2*tf));

% plot exact
% figure(15010301);
% clf;
figure(15010101); 
subplot(223);
mesh(yy,xx,uexact);
xlim([0,ymax]);
xlabel('y','FontSize',16);
ylabel('x','FontSize',16);
zlabel('u','FontSize',16);
title('exact');

% compare to exact
% figure(15010301);
% clf;
figure(15010101); 
subplot(224);
mesh(yy,xx,abs(uexact-u));
xlim([0,ymax]);
xlabel('y','FontSize',16);
ylabel('x','FontSize',16);
zlabel('u','FontSize',16);
title('error');

