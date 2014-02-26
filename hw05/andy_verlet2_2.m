function yvec = andy_verlet2_2(func,tspan,y0,h,params)
% implements Verlet-2 for 2D
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
    zwup = yvec(3:4,i-1)+h*func(t,yvec(1:2,i-1)+h/2*yvec(3:4,i-1),params);
    qrup = yvec(1:2,i-1)+h/2*(yvec(3:4,i-1)+zwup);    
    yvec = [yvec [qrup;zwup]];
    t=t+h;
end