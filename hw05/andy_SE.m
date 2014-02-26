function yvec = andy_SE(func,tspan,y0,h,params)
% simple Euler
%
% not much else to say

t = tspan(1);

yvec =  [];
yvec = [yvec y0];
disp(yvec);
for i=2:length(tspan)
    yvec = [yvec yvec(:,i-1)+h*func(t,yvec(:,i-1),params)];
    t = t+h;
end