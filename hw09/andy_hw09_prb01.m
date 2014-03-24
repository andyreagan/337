% HW09 Problem 1
%
% solve BVP by collocation method

M=10;

% collocation points
x = linspace(0,1,M+2);

% set r
r = ((2.*x(2:end-1)-4)./((1+x(2:end-1)).^2))';

% build A
% A = sparse(M,M);
A = zeros(M,M);
for i=1:M
    A(:,i) = -pi^2*i^2.*sin(i*pi.*x(2:end-1)) + (-2./((1+x(2:end-1)).^2)).*sin(i*pi.*x(2:end-1));
end

%% solve
c = A\r;

%% add all of the functions
y = x';
for i=1:M
    y = y+c(i).*sin(i*pi.*x');
end

yexact = 2.*x./(1+x);

%% quick plot of all of the theta's
figure;
for i=1:M
    plot(x,c(i).*sin(i*pi.*x'));
    hold on;
end

%% compute max error (and save)
maxerror = max(abs(yexact'-y));
fprintf('maximum error for M = %g is %g\n',M,maxerror);

%%  plot the solution, and exact
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

plot(x',y,'LineWidth',2,'Color','b');
hold on;
plot(x,yexact,'LineWidth',2,'Color','r')
legend({'numerical','exact'},'Location','NorthWest');
legend boxoff;
set(gca, 'fontsize',18)
xlabel('x','FontSize',20)
ylabel('y','FontSize',20)
title(sprintf('numerical versus exact solution, M = %g',M));

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

plot(x,abs(yexact-y'),'LineWidth',2,'Color','r')
set(gca, 'fontsize',18)
xlabel('x','FontSize',20)
ylabel('y','FontSize',20)
title(sprintf('error of solution, M = %g',M));

% %% plot error versus 1/M
%
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