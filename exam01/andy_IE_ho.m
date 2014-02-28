function yvec = andy_IE_ho(func,tspan,y0,h,params)
% implicit Euler
%
% solves the 2D harmonic oscillator

omega = params(1);
t = tspan(1);

yvec =  [];
yvec = [yvec y0];
for i=2:length(tspan)
    y1up = (yvec(1,i-1)+h*yvec(2,i-1))/(1+h^2*omega^2);
    y2up = yvec(2,i-1)-h*omega^2*y1up;
    yvec = [yvec [y1up;y2up]];
    t = t+h;
end