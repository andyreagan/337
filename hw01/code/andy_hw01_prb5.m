% the skydiver

g = 9.8; k = g/35.76; 
jumperV = @(t,y,g,k) g-k*y;

y0 = 0;
h = 0.2;
xvec = 0:h:2;
c = -log(g)/k;

yNum = linspace(0,2,11);
yAnal = linspace(0,2,11);
% midpoint
yNum(1) = y0;
yAnal(1) = y0;
for i = 2:length(xvec) % x=xvec(2:end)
    k1 = jumperV(i,yNum(i-1),g,k);
    k2 = jumperV(i,yNum(i-1)+h*k1,g,k);
    yNum(i) = yNum(i-1)+h/2*(k1+k2);
    yAnal(i) = -g/k*(exp(-k*xvec(i))-1);
end

disp(yNum)
disp(yAnal)

figure;
plot(xvec,yNum,'b');
hold on;
plot(xvec,yAnal,'r');
legend('numerical','analytical');

figure;
plot(xvec,yAnal-yNum,'r');
title('error')