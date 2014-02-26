function dv =  jumperV(t,v,params)
% params = [g,k]
dv = params(1)-v*params(2);