% HW08 Problem 5
%
% 

h = 0.09;
x = 0:h:1.62;
y0 = 1;
yf = -2.24;
% set r
r = (30^2*h^2.*(2.*x(2:end-1)-1))';
% account for BC
r(1) = r(1) - y0;
r(end) = r(end) - yf;
% build A
A = diag((2-30^2*h^2)*ones(length(x)-2,1))+diag(ones(length(x)-3,1),-1)...
    +diag(ones(length(x)-3,1),1);

% check sizes
size(A)
size(r)

% solve
y = A\r;

% plot
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

plot(x',[y0;y;yf],'LineWidth',2);
set(gca, 'fontsize',18)
xlabel('x','FontSize',20)
ylabel('y','FontSize',20)

psprintcpdf_keeppostscript(sprintf('andy_hw08_prb05_%02g',1));

% print('-depsc2','-zbuffer','-r200',sprintf('andy_hw08_prb05_%02g.eps',1))
% system(sprintf('epstopdf andy_hw08_prb05_%02g.eps',1));