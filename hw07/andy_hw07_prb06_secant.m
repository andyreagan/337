% HW07 Problem 06...using smarter search
%
% solve the eigenvalue problem using the shooting method

% IC, BC
R = 10;
y0 = exp(-R);
h = 0.02;
tvec = -R:h:R;

% initialize lambda and f
lambdas = [0.98,1.02];
TOL = 10^-7;
yf = lambdas(1)*y0;
shot1 = andy_ME(@andy_hw07_prb06_ODE,tvec,[y0;yf],h,[lambdas(1)]);
yf = lambdas(2)*y0;
shot2 = andy_ME(@andy_hw07_prb06_ODE,tvec,[y0;yf],h,[lambdas(2)]);
f = [shot1(1,end),shot2(1,end)];
% now shoot for all lambda
while abs(lambdas(end-1)-lambdas(end)) > TOL
    % set lambda
    lambdas = [lambdas lambdas(end)-f(end)/((f(end)-f(end-1))/(lambdas(end)-lambdas(end-1)))];
    lambdanew = lambdas(end);
    yf = lambdanew*y0;
    % shoot
    shot = andy_ME(@andy_hw07_prb06_ODE,tvec,[y0;yf],h,[lambdanew]);
    % save shot
    f = [f,shot(1,end)];
end
disp(f(end));
lambdafinal = lambdas(end)-f(end)/((f(end)-f(end-1))/(lambdas(end)-lambdas(end-1)));
disp(lambdafinal);

% now take a shot with lambda*
yf = lambdafinal*y0;
shot = andy_ME(@andy_hw07_prb06_ODE,tvec,[y0;yf],h,[lambdafinal]);
disp(shot(1,end));

j=2;
soln = shot;
plot(tvec,soln(1,:));
xlabel('x','FontSize',20);
ylabel('y','FontSize',20);
set(gcf, 'units', 'inches', 'position', [1 1 10 10])
set(gcf,'PaperPositionMode','auto')
print('-depsc2','-zbuffer','-r200',sprintf('andy_hw07_prb06_%02g.eps',j))
system(sprintf('epstopdf andy_hw07_prb06_%02g.eps; \\rm andy_hw07_prb06_%02g.eps',j,j));
