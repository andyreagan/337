% Exam 1 problem 4
%
% integrate the simple harmonic oscillator

h = 0.1;
tmax = 20;
tvec = 0:h:tmax;
omega = 1;
y0 = [0;2];

y = andy_IE_ho(@dummy,tvec,y0,h,[omega]);

plot(y(1,:),y(2,:))
xlabel('y','FontSize',20)
ylabel('v','FontSize',20)