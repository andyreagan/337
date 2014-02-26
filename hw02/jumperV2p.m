function dv = jumperV2p(t,v)

params = [9.8000 0.2740 5.4810];

% params = [g,k1,k2]
if t<=2
    dv =  params(1)-v*params(2);
else
    dv =  params(1)-v*params(3);
end