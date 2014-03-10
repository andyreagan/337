% HW08 Problem 6
%
%

hvec = fliplr([0.2;0.1;0.05;0.025;0.0125]);
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
    yExact = 2.*x./(1+x);
    
    maxError = max(abs(yExact-yNum));
    errorVec(i) = maxError;
end

errorVec = errorVec';
disp(hvec);
disp(errorVec);
plot(hvec,errorVec);
xlabel('h','FontSize',20)
ylabel('max error','FontSize',20)
set(gcf, 'units', 'inches', 'position', [1 1 10 10])
set(gcf,'PaperPositionMode','auto')
print('-depsc2','-zbuffer','-r200',sprintf('andy_hw08_prb06_%02g.eps',1))
system(sprintf('epstopdf andy_hw08_prb06_%02g.eps',1));