% Exam 02 Problem 01
%
% make some plots

% inside of cos,sin
a = sqrt(10);
% particular solution
p = 1/10;
% solve for the coeffecients
c1 = -p;
c2 = (-p-c1*cos(a))/sin(a);

% find part a
x = linspace(0,1,100);
y1 = c1*cos(a*x)+c2*sin(a*x)+1/10;

%% part b
a = sqrt(9.9);
% particular solution
p = 1/9.9;
% solve for the coeffecients
c1 = -p;
c2 = (-p-c1*cos(a))/sin(a);
y2 = c1*cos(a*x)+c2*sin(a*x)+p;

% plot them in this order so the legend entries
% are stacked the same as the lines
plot(x,y2,'b','LineWidth',3)
hold on;
plot(x,y1,'r','LineWidth',3)
xlabel('x')
ylabel('y')
legend({'part (b)','part (a)'})