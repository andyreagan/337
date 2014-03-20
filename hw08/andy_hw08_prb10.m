% HW08 Problem 10
%
% solve the nonlinear BVP using Newton-Raphson

% IC, BC
y0 = 1; yf = 1;
hvec = [0.1,0.2];
ysoln = {'shallow','deep'};
tol = 10^(-6);
errorcell = cell(4,1);
for i=1:2
    h = hvec(i);
    tvec = (0:h:2)';
    % set both y solutions
    yvec = {tvec.^0,[1-16.*(0:h:1)';-31+16.*(1+h:h:2)']};
    N = length(tvec)-2;
    A = (spdiags(ones(N,1),-1,N,N)+spdiags(-2.*ones(N,1),0,N,N)+spdiags(ones(N,1),1,N,N));
    
    for j=1:2
        err = 1;
        itercount = 0;
        errvec = [];
        % set Y initially
        y = yvec{j};
        y = y(2:end-1);
        figure;
        while err > tol
            itercount=itercount+1;
            A = spdiags(-2-2*h^2.*y./(2+tvec(2:end-1)),0,N,N)...
                +spdiags(ones(N,1),-1,N,N)...
                +spdiags(ones(N,1),1,N,N);
            r = andy_hw08_prb10_r(tvec(2:end-1),y,h,y0,yf);
            epsnew = A\r;
            ynew = y-epsnew;
            %disp(ynew);
            err = sqrt(sum((ynew-y).^2));
            %disp(err);
            errvec = [errvec err];
            y = ynew;
            plot(tvec,[y0;y;yf])
            hold on;
            if itercount > 1000
                break
            end
        end
        fprintf('took %g iterations for y %g with h = %g\n',itercount,j,h);
        errorcell{i+2*(j-1)} = errvec;
        soln = [y0;y;yf];
    end
end

%% make nice plots
figure;
% plot error versus iterations
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

plot(log10(errorcell{1}),'LineWidth',2,'Color','b');
hold on;
plot(log10(errorcell{2}),'LineWidth',2,'Color','g');
tmp1h = legend({'h = 0.1','h = 0.2'});
set(tmp1h,'FontSize',17);
legend boxoff
set(gca, 'fontsize',18)
xlabel('iteration','FontSize',20)
ylabel('log10(error)','FontSize',20)
psprintcpdf_keeppostscript(sprintf('andy_hw08_prb10_shallowerror'));

%% make nice plots
figure;
% plot error versus iterations
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

plot(log10(errorcell{3}),'LineWidth',2,'Color','b');
hold on;
plot(log10(errorcell{4}),'LineWidth',2,'Color','g');
tmp1h = legend({'h = 0.1','h = 0.2'});
set(tmp1h,'FontSize',17);
legend boxoff
set(gca, 'fontsize',18)
xlabel('iteration','FontSize',20)
ylabel('log10(error)','FontSize',20)
psprintcpdf_keeppostscript(sprintf('andy_hw08_prb10_deeperror'));

close all