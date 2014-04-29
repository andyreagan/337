function yvec = andy_verlet1_2(func,tspan,y0,h,params)
% implements Verlet-1 for 2D
%
% not a particularly fast implementation
% but it works
%
% [q' r' z' w'] where z' = q'' and w' = r''
%
% the function handle returns [z',w'] from [q,r]


yvec = [];
yvec = [yvec y0];

t = tspan(1);
for i=2:length(tspan)
    tmp = func(t,yvec(1:2,i-1),params);
    % qup = yvec(1,i-1)+h*yvec(3,i-1)+h^2/2*tmp(1); % q
    % rup = yvec(2,i-1)+h*yvec(4,i-1)+h^2/2*tmp(2); % r
    qrup = yvec(1:2,i-1)+h*yvec(3:4,i-1)+h^2/2*tmp; %[q,r]
    % zup = yvec(3,i-1)+h/2*(tmp(1)+func(t,[qup;rup],params)); % z'
    zwup = yvec(3:4,i-1)+h/2*(tmp+func(t,[qrup],params)); % z',w'
    yvec = [yvec [qrup;zwup]];
    t=t+h;
end