% HW07 Problem 05
%
% solve the nonlinear BVP using the shooting method
% shoot iteratively
% use the secand method for solving

% IC, BC
y0 = 1; yf = 1;
h = 0.02;
tvec = 0:h:2;
tol = 10^(-3);


i=2;
err = 1;
% initialize theta and f
thetacell = {[-2,-1],[2,1]};
for j=1:2
    theta = thetacell{j};
    shot1 = andy_ME(@andy_hw07_prb05_ODE,tvec,[y0;theta(1)],h,[]);
    shot2 = andy_ME(@andy_hw07_prb05_ODE,tvec,[y0;theta(2)],h,[]);
    f = [shot1(1,end),shot2(1,end)];
    while err > tol
        % generate new theta
        theta = [theta theta(end)-f(end)/((f(end)-f(end-1))/(theta(end)-theta(end-1)))];
        % solve the ODE
        shot = andy_ME(@andy_hw07_prb05_ODE,tvec,[y0;theta(end)],h,[]);
        % f is y(2) at that theta
        f = [f shot(1,end)-yf];
        % count the iterations
        i=i+1;
        % error is just f
        err = abs(f(end));
    end
    fprintf('took %g iterations for %g-th theta',i,j);
    
    soln = shot;
    plot(tvec,soln(1,:));
    xlabel('x','FontSize',20);
    ylabel('y','FontSize',20);
    set(gcf, 'units', 'inches', 'position', [1 1 10 10])
    set(gcf,'PaperPositionMode','auto')
    print('-depsc2','-zbuffer','-r200',sprintf('andy_hw07_prb05_%02g.eps',j))
    system(sprintf('epstopdf andy_hw07_prb05_%02g.eps; \\rm andy_hw07_prb05_%02g.eps',j));
end