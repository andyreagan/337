function dv = jumperV2(t,v,params)

% params = [g,k1,k2]
if t<=2
    dv =  params(1)-v*params(2);
else
    dv =  params(1)-v*params(3);
end