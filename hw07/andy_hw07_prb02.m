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
shot1 = andy_ME(@andy_hw07_prb02_ODE,tvec,[y0;0;0],h,[]);
shot2 = andy_ME(@andy_hw07_prb02_ODEh,tvec,[0;1;0],h,[]);
shot3 = andy_ME(@andy_hw07_prb02_ODEh,tvec,[0;0;1],h,[]);

% construct z
z = [shot1(:,end) shot2(:,end) shot3(:,end)];
% take just the bottom two
z = z(2:3,:);

% solve for theta,psi. call them both theta
theta = z(:,2:3)\[yfp-z(1,1);yfpp-z(2,1)];

soln = shot1+theta(1).*shot2+theta(2).*shot3;
plot(tvec,soln);
legend('y','y','ypp')
xlabel('x','FontSize',20);
ylabel('y','FontSize',20);
set(gcf, 'units', 'inches', 'position', [1 1 10 10])
set(gcf,'PaperPositionMode','auto')
print('-depsc2','-zbuffer','-r200',sprintf('andy_hw07_prb02_%02g.eps',i))
system(sprintf('epstopdf andy_hw07_prb02_%02g.eps',i));