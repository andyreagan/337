% HW07 Problem 01
%
% solve the BVP using the shooting method
% - I define the homogeneous and non-homogeneous in separate files
% - the IC are both Nuemann

% IC, BC
y0 = 1; yfp = 1/2; yfpp = 1/4;
h = 0.02;
tvec = 1:h:2;

i=1;
% solve the three IVP's
shot1 = andy_MEr(@andy_hw07_prb02_ODE,tvec,[0;yfp;yfpp],h,[]);
shot2 = andy_MEr(@andy_hw07_prb02_ODEh,tvec,[1;0;0],h,[]);

% solve for theta,psi. call them both theta
theta = (y0-shot1(1,1))/shot2(1,1);

soln = shot1+theta.*shot2;
plot(tvec,soln);
legend('y','yp','ypp')
xlabel('x','FontSize',20);
ylabel('y','FontSize',20);
set(gcf, 'units', 'inches', 'position', [1 1 10 10])
set(gcf,'PaperPositionMode','auto')
print('-depsc2','-zbuffer','-r200',sprintf('andy_hw07_prb03_%02g.eps',i))
system(sprintf('epstopdf andy_hw07_prb03_%02g.eps',i));