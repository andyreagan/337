[ode45t,ode45y] = ode45(@jumperV2p,[0,4],0);

plot(ode45t,ode45y);
hold on;

% solve analytically on new time grid
yAnalode45 = [];
for i=1:length(ode45t)
    t = ode45t(i);
    if t<2
        yAnalode45 = [yAnalode45 -g/k1*(exp(-k1*t)-1)];
    else
        yAnalode45 = [yAnalode45 (-exp(-k2*(t-2))*(k2/k1*exp(-2*k1)-k2/k1+1)+1)*g/k2];
    end
end

plot(ode45t,yAnalode45,'r');
legend({'ode45','analytical'});
length(ode45y)
length(yAnalode45)