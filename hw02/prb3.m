g = 9.8;
k1 = g/35.76; % that's 80mph in m/s
k2 = g/1.788;
h = 0.2;
y0 = 0.0;

x = linspace(0,4,21); %int(4/h+1))
yAnal = linspace(0,4,21); %int(4/h+1))
disp(k2/k1);
disp(g - k2*g/k1*(-exp(-k1*2)+1));

% solve analytically
for i=1:length(x)
    t = x(i);
    if t<2
        yAnal(i) = -g/k1*(exp(-k1*t)-1);
    else
        yAnal(i) = (-exp(-k2*(t-2))*(k2/k1*exp(-2*k1)-k2/k1+1)+1)*g/k2;
    end
end

yNumRK4 = my_cRK(@jumperV2,x,y0,h,[g,k1,k2]);
yNumME = my_ME(@jumperV2,x,y0,h,[g,k1,k2]);

plot(x,yAnal,'r')
hold on;
plot(x,yNumRK4,'b')
plot(x,yNumME,'c')
legend({'analytical','RK4','ME'})
