function yvec = andy_verlet2(func,tspan,y0,h,params)
% implements Verlet-2
%
% not a particularly fast implementation
% but it works

yvec = [];
yvec = [yvec y0];
t = tspan(1);
for i=2:length(tspan)
    vup = yvec(2,i-1)+h*func(t,yvec(1,i-1)+h/2*yvec(2,i-1),params);
    yup = yvec(1,i-1)+(h/2)*(yvec(2,i-1)+vup);
    yvec = [yvec [yup;vup]];
    t=t+h;
end