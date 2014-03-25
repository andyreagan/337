% Exam 2 Problem 02
%
% solve the BVP using the shooting method
% - I define the homogeneous and non-homogeneous in separate files
% - the IC are both Nuemann

% IC, BC
y0p = -15/19; yf = 0;
h = 0.1;
tvec = 2:h:3;

i=1;
shot1 = andy_ME(@andy_exam02_prb02_ODE,tvec,[0;y0p],h,[]);
shot2 = andy_ME(@andy_exam02_prb02_ODEh,tvec,[1;0],h,[]);

theta = (yf-shot1(1,end))/shot2(1,end);

soln = shot1+theta.*shot2;
plot(tvec,soln(1,:),'b');
xlabel('x','FontSize',20);
ylabel('y','FontSize',20);

% the finite difference of from the LHS of the solution is
disp((soln(1,2)-soln(1,1))/h);
% which should be close to -15/19
disp(y0p);

exact = (114.*tvec - 19.*tvec.^2 - 5.*tvec.^3 - 36)./(38.*tvec);
hold on;
plot(tvec,exact,'r')
legend({'numerical','exact'});

figure;
plot(tvec,abs(soln(1,:)-exact),'r')
xlabel('x','FontSize',20);
ylabel('error in u','FontSize',20);

exactp = -19/38 - 10/38.*tvec + 36/38./(tvec.^2);
figure;
plot(tvec,abs(soln(2,:)-exactp),'r')
xlabel('x','FontSize',20);
ylabel('error in u prime','FontSize',20);