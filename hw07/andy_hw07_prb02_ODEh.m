function dy = andy_hw07_prb02_ODEh(t,y,params)
% [y1';y2';y3']
% where y1 = y, y2 = y', y3 = y''

dy = [y(2);y(3);(y(1)-t*y(2))/t^3];