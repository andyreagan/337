% HW08 Problem 09
%
% solve the nonlinear BVP using picard iterations

% IC, BC
y0 = 1; yf = 1;
hvec = [0.1,0.2];
ysoln = {'shallow','deep','deeper'};

%% shallow solution
m = 1;
% cvec = [100,20,10,1.5,.75,0,-0.5,-0.9,-1,-1.5];
cvec = [-1];
for i=1:length(cvec)
    c = cvec(i);
    for j=1:2
        % set h
        h = hvec(j);
        % now set all the stuff that depends on h
        tvec = (0:h:2)';
        N = length(tvec)-2;
        % shallow, deep, deeper
        yvec = {tvec.^0,[1-16.*(0:h:1)';-31+16.*(1+h:h:2)'],...
            [1-20.*(0:h:1)';-39+20.*(1+h:h:2)']};
        % choose the y solution that we want
        y = yvec{m};
        % build A
        A = (spdiags(ones(N,1),-1,N,N)+spdiags(-2.*ones(N,1),0,N,N)+spdiags(ones(N,1),1,N,N));
        % test without modified method
        %k = andy_hw08_prb09_picard(@andy_hw08_prb08_r,A,tvec,y,1,10^(-6),h,'plot',1,'modified',0);
        % now run modified method (the default for the picard function)
        fprintf('%s y with h = %g, c = %g\n',ysoln{m},h,c);
        k = andy_hw08_prb09_picard(@andy_hw08_prb08_r,A,tvec,y,c,10^(-6),h,'plot',1);
        fprintf('took %g iterations for %s y with h = %g, c=%g\n',k,ysoln{m},h,c);
    end
end

% plot a figure showing the odd behavior
tmpfigh = gcf;
figshape(600,600);
set(gcf,'Color','none'); set(gcf,'InvertHardCopy', 'off');
set(gcf,'DefaultAxesFontname','helvetica');
set(gcf,'DefaultLineColor','r');
set(gcf,'DefaultAxesColor','none');
set(gcf,'DefaultLineMarkerSize',5);
set(gcf,'DefaultLineMarkerEdgeColor','k');
set(gcf,'DefaultLineMarkerFaceColor','g');
set(gcf,'DefaultAxesLineWidth',0.5);
set(gcf,'PaperPositionMode','auto');
set(gca, 'fontsize',18);
xlabel('x','FontSize',20);
ylabel('y','FontSize',20);
psprintcpdf_keeppostscript(sprintf('andy_hw08_prb09_illustrative'));

%% deep solution
m = 2;
cvec = [-2.9,-4,-3.9,-3.75,-3.62,-3.6,-3.55,-3.5,-5.95,-6.45,-6.95,-7.45];
for i=1:length(cvec)
    c = cvec(i);
    for j=1:2
        h = hvec(j);
        tvec = (0:h:2)';
        N = length(tvec)-2;
        yvec = {tvec.^0,[1-16.*(0:h:1)';-31+16.*(1+h:h:2)'],...
            [1-20.*(0:h:1)';-39+20.*(1+h:h:2)']};
        y = yvec{m};
        A = (spdiags(ones(N,1),-1,N,N)+spdiags(-2.*ones(N,1),0,N,N)+spdiags(ones(N,1),1,N,N));
        k = andy_hw08_prb09_picard(@andy_hw08_prb08_r,A,tvec,y,c,10^(-6),h,'plot',0);
       fprintf('took %g iterations for %s y with h = %g, c=%g\n',k,ysoln{m},h,c);
    end
end

%% deeper solution
m = 3;
cvec = [ -4,-3.9,-5.95,-6.45,-6.95,-7.45];
for i=1:length(cvec)
    c = cvec(i);
    for j=1:2
        h = hvec(j);
        tvec = (0:h:2)';
        N = length(tvec)-2;
        yvec = {tvec.^0,[1-16.*(0:h:1)';-31+16.*(1+h:h:2)'],...
            [1-20.*(0:h:1)';-39+20.*(1+h:h:2)']};
        y = yvec{m};
        A = (spdiags(ones(N,1),-1,N,N)+spdiags(-2.*ones(N,1),0,N,N)+spdiags(ones(N,1),1,N,N));
        k = andy_hw08_prb09_picard(@andy_hw08_prb08_r,A,tvec,y,c,10^(-6),h,'plot',0);
       fprintf('took %g iterations for %s y with h = %g, c=%g\n',k,ysoln{m},h,c);
    end
end