function yvec = andy_verlet1(func,tspan,y0,h,params)
% implements Verlet-1
%
% not a particularly fast implementation
% but it works

yvec = [];
yvec = [yvec y0];
disp(yvec);
t = tspan(1);
for i=2:length(tspan)
    tmp = func(t,yvec(1,i-1),params);
    yup = yvec(1,i-1)+h*yvec(2,i-1)+h^2/2*tmp;
    vup = yvec(2,i-1)+h/2*(tmp+func(t,yup,params));
    yvec = [yvec [yup;vup]];
    t=t+h;
end