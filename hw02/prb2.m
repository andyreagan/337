g = 9.8;
k1 = g/35.76; % that's 80mph in m/s
h = 0.2;
y0 = 0.0;
x = linspace(0,2,11);
yAnal = linspace(0,2,11);

% use RK4
yNumRK4 = my_cRK(@jumperV,x,y0,h,[g,k1]);
% solve analytically
for t=1:length(x)
    yAnal(t) = -g/k1*(exp(-k1*x(t))-1);
end

% solve with ME    
yNumME = my_ME(@jumperV,x,y0,h,[g,k1]);

disp(yNumRK4)
disp(yAnal)
disp(yNumME)

plot(x,abs(yAnal-yNumRK4),'r')
title(sprintf('error of cRK, h = %g',h))
xlabel('time')
ylabel('magnitude of error')

error_ME = yAnal(end)-yNumME(end);
error_RK4 = yAnal(end)-yNumRK4(end);
fprintf('final error of ME is %f\n',error_ME);
fprintf('final error of cRK is %f\n',error_RK4);
fprintf('ratio of cRK/ME is %f',error_RK4/error_ME);
