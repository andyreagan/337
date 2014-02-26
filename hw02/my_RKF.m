function [tvec,yvec] = my_RKF(func,tspan,y0,h,params)
max_error = 10^(-3)*0.44704; % 10^-3 mph in m/s
kappa = 0.8;
% accept the tspan, but use only the range of it
t = tspan(1);
disp(tspan);
% accept h, use it for the first guess
H = h;
hMin = 10^(-6);

% t -= H
% set the coefficients
a11 = 0.25;
[a21,a22] = deal(3/32,9/32);
[a31,a32,a33] = deal(1932/2197,-7200/2197,7296/2197);
[a41,a42,a43,a44] = deal(439/216,-8,3680/513,-845/4104);
[a51,a52,a53,a54,a55] = deal(-8/27,2,-3544/2565,1859/4104,-11/40);
[b41,b42,b43,b44,b45,b46] = deal(25/216,0.0,1408/2565,2197/4104,-1/5,00);
[b51,b52,b53,b54,b55,b56] = deal(16/135,0.0,6656/12825,28561/56430,-9/50,2/55);
[c1,c2,c3,c4,c5] = deal(0.25,3/8,12/13,1.0,0.5);
yvec =  []; %linspace(tspan(1),tspan(end),num=floor((tspan(end)-tspan(1))/h))
yvec = [yvec y0]; %(1) = y0
tvec =  []; %linspace(tspan(1),tspan(end),num=floor((tspan(end)-tspan(1))/h))
tvec = [tvec t]; %(1) = y0

% for i in xrange(1,len(tspan)):
while t<tspan(end)
    % disp(tvec);
    
    k1 = H*func(t,yvec(end),params);
    k2 = H*func(t+c1*H,yvec(end)+a11*k1,params);
    k3 = H*func(t+c2*H,yvec(end)+a21*k1+a22*k2,params);
    k4 = H*func(t+c3*H,yvec(end)+a31*k1+a32*k2+a33*k3,params);
    k5 = H*func(t+c4*H,yvec(end)+a41*k1+a42*k2+a43*k3+a44*k4,params);
    k6 = H*func(t+c5*H,yvec(end)+a51*k1+a52*k2+a53*k3+a54*k4+a55*k5,params);
    y4 = yvec(end) + b41*k1 + b42*k2 + b43*k3 + b44*k4 + b45*k5 + b46*k6;
    y5 = yvec(end) + b51*k1 + b52*k2 + b53*k3 + b54*k4 + b55*k5 + b56*k6;
    
    error_guess = abs(y5-y4);
    fprintf('t is %g, error guess is %f\n',t,error_guess)
    if error_guess < max_error
        % accept this solution
        t = t + H;
        tvec = [tvec t];
        yvec = [yvec y5];
    else
        % do not accept
        if H < hMin
            % well, if h is too small, still accept
            t = t + H;
            tvec = [tvec t];
            yvec = [yvec y5];
        else
            % decrease h
            H = H*kappa*((max_error/error_guess)^(1/(4+1)));
        end
    end
end
