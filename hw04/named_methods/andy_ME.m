function yvec = my_ME(func,tspan,y0,h,params)

yvec = [];
yvec = [yvec y0];
t = tspan(1);
for i=2:length(tspan)
    k1 = func(t,yvec(i-1),params);
    k2 = func(t+h,yvec(i-1)+h*k1,params);
    yvec = [yvec yvec(i-1)+h/2*(k1+k2)];
    t=t+h;
end