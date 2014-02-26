function yvec = andy_SCD(func,tspan,y0,h,params)
% implements simple-central difference

yvec = [];
% start with (5.17)
yvec = [yvec y0(1) y0(1)+h*y0(2)+func(0,y0(1),params)];
disp(yvec);
t = tspan(1);
for i=3:length(tspan)
    % equation (5.12)
    y = 2*yvec(i-1)-yvec(i-2)+h^2*func(t,yvec(i-1),params);
    yvec = [yvec y];
    t=t+h;
end