% HW09 Problem 3
%
% solve BVP by  method

Mvec = [1,2,5,10,15,20,30,40,60,80,100,120]';
Mvec = [10,20,40]';
Mvec = 10;
errorvec = zeros(size(Mvec));
for j=1:length(Mvec)
    %% setup
    M = Mvec(j);
    
    % compute the collocation points
    h = 1/(M+1);
    h = 0.1;
    x = (0:h:1)';
    disp(x);
    
    % set r
    % xmid = x(floor(length(x)/2));
    xmids = x(2:end-1);

    % evaluate r using the approximation
    r = h.*((2.*(xmids)-4)./((1+(xmids)).^2));
    disp(r);
    
    % evaluate r using quad
    %     for i=1:length(xmids)
    %         xj = xmids(i);
    %         rfuncl = @(x) (1-abs(x-xj)./h).*(2.*x-4)./((1+x).^2);
    %         r(i) = quad(rfuncl,x(i),x(i+2));
    %     end
    %     disp(r);
    % build A
    
    qmid = -2.*xmids./((1+xmids).^2);
    % push evaluation of q forward to the actual midpoint
    % qmidh = -2.*(xmids-h/2)./(1+(xmids-h/2)).^2;
    % qmidfh = -2.*(xmids+h/2)./(1+(xmids+h/2)).^2;
    % push evaluation forward so that the matrix is symmetrix
    qmidh = -2.*(xmids)./((1+(xmids)).^2);
    qmidfh = -2.*(xmids+h)./((1+(xmids+h)).^2);
    A = spdiags((-2/h+qmid.*2.*h./3),0,M,M)+spdiags((1/h+qmidh.*h./6),1,M,M)...
        +spdiags((1/h+qmidfh.*h./6),-1,M,M);
    % verify that A is symmetric
    disp(A);
    
    % build A using the MATLAB's integrator
     
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
    
    %% solve
    c = A\r;
    
    %% add all of the functions  for the solution
    y = x;
    for i=2:M+1
        y(i-1:i+1) = y(i-1:i+1)+c(i-1).*(1-abs(x(i-1:i+1)-x(i))/h);
    end
    yexact = 2.*x./(1+x);    
    
    
    %% compute max error (and save)
    maxerror = max(abs(yexact-y));
    fprintf('maximum error for M = %g is %g\n',M,maxerror);
    errorvec(j) = maxerror;
    
    %%  plot the solution, and exact
    if M > 0
        %% quick plot of all of the theta's
        figure;
        for i=2:M+1
            plot(x(i-1:i+1),c(i-1).*(1-abs(x(i-1:i+1)-x(i))/h));
            hold on;
        end
        
        
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
        
        psprintcpdf_keeppostscript(sprintf('andy_hw09_prb03_%02g_m%02g_error',1,M));
        % close all;
    end
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