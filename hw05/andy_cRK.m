function yvec = andy_cRK(func,tspan,y0,h,params)
% classical Runge-Kutta 4-th order

% set the coefficients
[a11,a21,a22,a31,a32,a33] = deal(0.5,0.0,0.5,0.0,0.0,1.0);
[b1,b2,b3,b4] = deal(1/6,1/3,1/3,1/6);
[c1,c2,c3] = deal(0.5,0.5,1);
t = tspan(1);

yvec =  []; %linspace(tspan[0],tspan[-1],num=floor((tspan[-1]-tspan[0])/h))
yvec = [yvec y0]; %[0] = y0
for i=2:length(tspan)
    k1 = h*func(t,yvec(:,i-1),params);
    k2 = h*func(t+c1*h,yvec(:,i-1)+a11*k1,params);
    k3 = h*func(t+c2*h,yvec(:,i-1)+a21*k1+a22*k2,params);
    k4 = h*func(t+c3*h,yvec(:,i-1)+a31*k1+a32*k2+a33*k3,params);
    yvec = [yvec yvec(:,i-1)+b1*k1+b2*k2+b3*k3+b4*k4]; %[i] = yvec[i-1] + b1*k1 + b2*k2 + b3*k3 + b4*k4
    t = t+h;
end