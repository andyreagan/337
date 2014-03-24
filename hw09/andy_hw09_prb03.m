% HW09 Problem 3
%
% solve BVP by Galerkin method


%% setup
M = 10;

% compute the collocation points
h = 1/(M+1);
x = (0:h:1)';
disp(x);

% these are the centers of the basis functions
xmids = x(2:end-1);

% evaluate r using the approximation
r = h.*((2.*xmids-4)./((1+xmids).^2));
disp(r);


% build A
qmid = -2./((1+(xmids)).^2);
% push evaluation forward so that the matrix is symmetric
qmidh = -2./((1+(xmids(1:end-1)+h/2)).^2);
offdiag = (1/h+qmidh.*h./6);
A = spdiags((-2/h+qmid.*2.*h./3),0,M,M)+spdiags([0;offdiag],1,M,M)...
    +spdiags([offdiag;0],-1,M,M);
% verify that A is symmetric
disp(A);

c = A\r;

%% build A and r using the MATLAB's integrator

% evaluate r using quad
%     for i=1:length(xmids)
%         xj = xmids(i);
%         rfuncl = @(x) (1-abs(x-xj)./h).*(2.*x-4)./((1+x).^2);
%         r(i) = quad(rfuncl,x(i),x(i+2));
%     end
%     disp(r);
%
%     xdiags = r;
%     for i=1:length(xmids)
%         xj = xmids(i);
%         qfuncl = @(x) (1-abs(x-xj)./h).^2.*(-2.*x)./((1+x).^2);
%         xdiags(i) = -2/h+quad(qfuncl,x(i),x(i+2));
%     end
%
%     xupdiags = r;
%     for i=1:length(xmids)-1
%         xj = xmids(i);
%         xj1 = xmids(i+1);
%         qfunc2 = @(x) (1-abs(x-xj)./h).*(1-abs(x-xj1)./h).*(-2.*x)./((1+x).^2);
%         xupdiags(i) = 1/h+quad(qfunc2,x(i+1),x(i+2));
%     end
%     A = spdiags(xdiags,0,M,M)+spdiags([0;xupdiags],1,M,M)...
%         +spdiags([xupdiags;0],-1,M,M);

% solve
% c = A\r;

%% add all of the functions  for the solution
y = x;
for i=2:M+1
    y(i-1:i+1) = y(i-1:i+1)+c(i-1).*(1-abs(x(i-1:i+1)-x(i))/h);
end
yexact = 2.*x./(1+x);


%% compute max error (and save)
maxerror = max(abs(yexact-y));
fprintf('maximum error for M = %g is %g\n',M,maxerror);

figure;
for i=2:M+1
    plot(x(i-1:i+1),c(i-1).*(1-abs(x(i-1:i+1)-x(i))/h));
    hold on;
end
title('all of the basis functions')


figure;
tmpfigh = gcf;
clf;
figshape(600,600);
set(gcf,'Color','none');
set(gcf,'InvertHardCopy', 'off');
set(gcf,'DefaultAxesFontname','helvetica');
set(gcf,'DefaultLineColor','r');
set(gcf,'DefaultAxesColor','none');
set(gcf,'DefaultLineMarkerSize',5);
set(gcf,'DefaultLineMarkerEdgeColor','k');
set(gcf,'DefaultLineMarkerFaceColor','g');
set(gcf,'DefaultAxesLineWidth',0.5);
set(gcf,'PaperPositionMode','auto');

plot(x,y,'LineWidth',2,'Color','b');
hold on;
plot(x,yexact,'LineWidth',2,'Color','r')
legend({'numerical','exact'},'Location','NorthWest');
legend boxoff;
set(gca, 'fontsize',18)
xlabel('x','FontSize',20)
ylabel('y','FontSize',20)
title('exact and numerical solutions')

%%  plot the solution error
figure;
tmpfigh = gcf;
clf;
figshape(600,600);
set(gcf,'Color','none');
set(gcf,'InvertHardCopy', 'off');
set(gcf,'DefaultAxesFontname','helvetica');
set(gcf,'DefaultLineColor','r');
set(gcf,'DefaultAxesColor','none');
set(gcf,'DefaultLineMarkerSize',5);
set(gcf,'DefaultLineMarkerEdgeColor','k');
set(gcf,'DefaultLineMarkerFaceColor','g');
set(gcf,'DefaultAxesLineWidth',0.5);
set(gcf,'PaperPositionMode','auto');

plot(x,abs(yexact-y),'LineWidth',2,'Color','r')
set(gca, 'fontsize',18)
xlabel('x','FontSize',20)
ylabel('y','FontSize',20)
title('error of the numerical solution')

% %% plot error versus 1/M
% figure;
% tmpfigh = gcf;
% clf;
% figshape(600,600);
% set(gcf,'Color','none');
% set(gcf,'InvertHardCopy', 'off');
% set(gcf,'DefaultAxesFontname','helvetica');
% set(gcf,'DefaultLineColor','r');
% set(gcf,'DefaultAxesColor','none');
% set(gcf,'DefaultLineMarkerSize',5);
% set(gcf,'DefaultLineMarkerEdgeColor','k');
% set(gcf,'DefaultLineMarkerFaceColor','g');
% set(gcf,'DefaultAxesLineWidth',0.5);
% set(gcf,'PaperPositionMode','auto');
% 
% plot(1./Mvec,errorvec,'LineWidth',2,'Color','b')
% 
% set(gca, 'fontsize',18)
% xlabel('1/M','FontSize',20)
% ylabel('Max error','FontSize',20)