% HW08 Problem 6
%
%

% FOR MAKING SECOND PLOT
% tmpsym = {'o','s','v','o','s','v'};
% tmpcol = {'g','b','r','k','c','m'};
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

hvec = 10^-4:10^-3:10^-1; % FIRST PLOT
% hvec = [.05,.05/2]; % SECOND PLOT
for i=1:length(hvec)
    h = hvec(i);
    x = (0:h:1)';
    y0 = 0;
    yf = 2;
    % next two for mixed BC
    a1 = 1;
    a2 = 2;
    % set r, N of them
    r = -4*h^2./((1+x(2:end)).^2);
    % account for BC
    r(1) = r(1) - y0;
    r(end) = r(end)-2*h*yf/a2;
    % build A
    A = diag(-2-h^2*2./((1+x(2:end)).^2))... % main diagonal
        +diag(ones(length(x)-2,1),-1)... % sub
        +diag(ones(length(x)-2,1),1); % super
    % account for mixed BC
    A(end,end-1:end) = A(end,end-1:end)+[1,-2*h*a1/a2];
    % disp(A);
    
    % check sizes
    % size(A)
    % size(r)
    
    % solve
    yNum = [y0;A\r];
    % figure;
    yExact = 2.*x./(1+x);
    % FOR MAKING SECOND PLOT
%     plot(x,abs(yExact-yNum),'LineWidth',2,'Color',tmpcol{i});
%     hold on;
%     set(gca, 'fontsize',18);
    
    maxError = max(abs(yExact-yNum));
    errorVec(i) = maxError;
end

% FOR MAKING SECOND PLOT
% xlabel('x','FontSize',20)
% ylabel('error','FontSize',20)
% tmp1h = legend({'h = 0.05','h = 0.025'});
% set(tmp1h,'FontSize',17);
% legend boxoff
% psprintcpdf_keeppostscript(sprintf('andy_hw08_prb06_%02g',2));

errorVec = errorVec';

% FIST PLOT
% plot error versus h
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

plot(hvec,errorVec,'LineWidth',2);
set(gca, 'fontsize',18)
xlabel('h','FontSize',20)
ylabel('max error','FontSize',20)
psprintcpdf_keeppostscript(sprintf('andy_hw08_prb06_%02g_tom',1));