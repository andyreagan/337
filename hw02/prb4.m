g = 9.8;
k1 = g/35.76; % that's 80mph in m/s
k2 = g/1.788;
h = 0.2;
y0 = 0.0;
x = 0:h:4;

[tNumRKF,yNumRKF] = my_RKF(@jumperV2,x,y0,h,[g,k1,k2]);


% solve analytically on new time grid
yAnalRKF = [];
for i=1:length(tNumRKF)
    t = tNumRKF(i);
    if t<2
        yAnalRKF = [yAnalRKF -g/k1*(exp(-k1*t)-1)];
    else
        yAnalRKF = [yAnalRKF (-exp(-k2*(t-2))*(k2/k1*exp(-2*k1)-k2/k1+1)+1)*g/k2];
    end
end

plot(tNumRKF,yAnalRKF,'r');
hold on;
plot(tNumRKF,yNumRKF,'b');
legend({'analytical','RKF'});