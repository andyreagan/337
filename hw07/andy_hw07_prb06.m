% HW07 Problem 06
%
% solve the eigenvalue problem using the shooting method

% IC, BC
R = 10;
y0 = exp(-R);
h = 0.02;
tvec = -R:h:R;

% initialize lambda and f
% can set the search to .001 for f=-.34
% searching with .00001 we find f=-0.012, better!
lambdas = 0.98:.001:1.02;
f = zeros(1,length(lambdas));
% now shoot for all lambda
for i=1:length(lambdas)
    % set lambda
    lambda = lambdas(i);
    yf = lambda*y0;
    % shoot
    shot = andy_ME(@andy_hw07_prb06_ODE,tvec,[y0;yf],h,[lambda]);
    % save shot
    f(i) = shot(1,end);
end
disp(f);

% find where f crosses 0
for i=1:length(f)-1
    % where it crosses
    if f(i+1)*f(i) < 0
        disp(i);
        % take the middle value
        lambdastar = (lambdas(i-1)+lambdas(i+1))/2;
        disp(lambdastar);
    end
end

% now take a shot with lambda*
yf = lambdastar*y0;
shot = andy_ME(@andy_hw07_prb06_ODE,tvec,[y0;yf],h,[lambdastar]);

j=1;
soln = shot;
plot(tvec,soln(1,:));
xlabel('x','FontSize',20);
ylabel('y','FontSize',20);
set(gcf, 'units', 'inches', 'position', [1 1 10 10])
set(gcf,'PaperPositionMode','auto')
print('-depsc2','-zbuffer','-r200',sprintf('andy_hw07_prb06_%02g.eps',j))
system(sprintf('epstopdf andy_hw07_prb06_%02g.eps; \\rm andy_hw07_prb06_%02g.eps',j,j));
