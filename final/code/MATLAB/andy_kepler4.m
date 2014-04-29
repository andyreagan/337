function dy = andy_kepler4(t,y,params)
% kepler 2-body problem in 2D
% as a system of 4 ODE's
%
% keep in mind the variable map for 2D
% [q' r' z' w'] where z' = q'' and w' = r''

dy = [y(3);y(4);-(y(1))/(y(1)^2+y(2)^2)^(3/2);-(y(2))/(y(1)^2+y(2)^2)^(3/2)];