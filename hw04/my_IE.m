function yvec = my_IE(func,tspan,y0,h,params)
% implicit Euler
%
% note that this function only works
% for problems of the form y' = ay

a = func(0,1,params);
t = tspan(1);

yvec =  [];
yvec = [yvec y0];
for i=2:length(tspan)
    yvec = [yvec yvec(i-1)/(1-a*h)];
    t = t+h;
end