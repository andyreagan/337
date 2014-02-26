function dy = andy_kepler2(t,y,params)
% kepler 2-body problem in 2D
% as a system of 2 second order eq's
%
% keep in mind the variable map for 2D
% [q' r' z' w'] where z' = q'' and w' = r''
% but i only care about z', w' here

dy = [-(y(1))/(y(1)^2+y(2)^2)^(3/2);-(y(2))/(y(1)^2+y(2)^2)^(3/2)];