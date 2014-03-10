% HW07 Problem 07 (Bonus 1)
%
% solve the BVP using the (multiple) shooting method
% - I define the homogeneous and non-homogeneous in separate files
% - the IC are both Nuemann

% IC, BC
y0 = 1; yf = -2.24;
h = 0.01;
tvec = 0:h:1.62;
% divide the interval in half
tvec1 = 0:h:1.62/2;
tvec2 = 1.62/2:h:1.62;

% shoot on the first half
i=1;
shot1 = andy_ME(@andy_hw07_prb04_ODE,tvec1,[y0;0],h,[]);
shot11 = andy_ME(@andy_hw07_prb04_ODEh,tvec1,[0;1],h,[]);

shot2 = andy_ME(@andy_hw07_prb04_ODE,tvec2,[0;0],h,[]);
shot21 = andy_ME(@andy_hw07_prb04_ODEh,tvec2,[1;0],h,[]);
shot22 = andy_ME(@andy_hw07_prb04_ODEh,tvec2,[0;1],h,[]);

% now solve for all three thetas
r = [-shot1(1,end);-shot1(2,end);yf-shot2(1,end)];
A = [shot11(1,end),-1,0; shot11(2,end),0,-1; 0,shot21(1,end),shot22(1,end)];
% solve by elimination
thetavec = A\r;

soln = [shot1(:,1:end-1)+thetavec(1).*shot11(:,1:end-1),shot2+thetavec(2).*shot21+thetavec(3).*shot22];
plot(tvec,soln(1,:));
hold on;
truth = 1-2.*tvec;
plot(tvec,truth,'r--')
legend('numerical','exact')
xlabel('x','FontSize',20);
ylabel('y','FontSize',20);
set(gcf, 'units', 'inches', 'position', [1 1 10 10])
set(gcf,'PaperPositionMode','auto')
print('-depsc2','-zbuffer','-r200',sprintf('andy_hw07_prb07_%02g.eps',i))
system(sprintf('epstopdf andy_hw07_prb07_%02g.eps',i));