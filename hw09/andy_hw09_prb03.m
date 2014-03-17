% HW09 Problem 3
%
% solve BVP by  method

Mvec = [10,15,20,30,40,60,80,100,120,1000]';
% Mvec = 10;
errorvec = zeros(size(Mvec));
for j=1:length(Mvec)
    %% setup
    M = Mvec(j);
    
    % collocation points
    h = 1/(M+1);
    x = (0:h:1)';

    % set r
    xmid = x(floor(length(x)/2));
    r = h*((2*xmid-4)./((1+xmid)^2)).*ones(M,1);
    
    % build A
    % A = sparse(M,M);
    qmid = -2*xmid/(1+xmid)^2;
    A = spdiags((-2/h+qmid*2*h/3).*ones(M,1),0,M,M)+spdiags((1/h+qmid*h/6).*ones(M,1),1,M,M)...
        +spdiags((1/h+qmid*h/6).*ones(M,1),-1,M,M);
    
    %% solve
    c = A\r;
    
    %% add all of the functions
    y = x;
    for i=2:M+1
        y(i-1:i+1) = y(i-1:i+1)+c(i-1).*(1-abs(x(i-1:i+1)-x(i))/h);
    end
    
    yexact = 2.*x./(1+x);
    
    %% quick plot of all of the theta's
    figure;
    for i=2:M+1
        plot(x(i-1:i+1),c(i-1).*(1-abs(x(i-1:i+1)-x(i))/h));
        hold on;
    end
    
    %% compute max error (and save)
    maxerror = max(abs(yexact-y));
    fprintf('maximum error for M = %g is %g\n',M,maxerror);
    errorvec(j) = maxerror;
    
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
    
    plot(x,y,'LineWidth',2,'Color','b');
    hold on;
    plot(x,yexact,'LineWidth',2,'Color','r')
    legend({'numerical','exact'},'Location','NorthWest');
    legend boxoff;
    set(gca, 'fontsize',18)
    xlabel('x','FontSize',20)
    ylabel('y','FontSize',20)
    
    psprintcpdf_keeppostscript(sprintf('andy_hw09_prb03_%02g_m%02g',1,M));
end

%% plot error versus 1/M

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

plot(1./Mvec,errorvec,'LineWidth',2,'Color','b')

set(gca, 'fontsize',18)
xlabel('1/M','FontSize',20)
ylabel('Max error','FontSize',20)

psprintcpdf_keeppostscript(sprintf('andy_hw09_prb03_%02g',2));

% close all;