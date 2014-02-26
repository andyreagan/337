% HW07 Problem 01
%
% solve the BVP using the shooting method
% - I define the homogeneous and non-homogeneous in separate files
% - the IC are both Nuemann

% IC, BC
y0 = 1; yf = 5;
h = 0.1;
tvec = 0:h:2;

i=1;
shot1 = andy_ME(@andy_hw07_prb01_ODE,tvec,[y0;0],h,[]);
shot2 = andy_ME(@andy_hw07_prb01_ODEh,tvec,[0;1],h,[]);

theta = (yf-shot1(1,end))/shot2(1,end);

soln = shot1+theta.*shot2;
plot(tvec,soln(1,:));
xlabel('x','FontSize',20);
ylabel('y','FontSize',20);
set(gcf, 'units', 'inches', 'position', [1 1 10 10])
set(gcf,'PaperPositionMode','auto')
print('-depsc2','-zbuffer','-r200',sprintf('andy_hw07_prb01_%02g.eps',i))
system(sprintf('epstopdf andy_hw07_prb01_%02g.eps',i));