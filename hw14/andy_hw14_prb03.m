% HW14 Problem 3
%
% Plot the absolute value of the largest value of rho for all beta h, r
%
% Andy Reagan

bh = linspace(0,pi,100);
r = linspace(0,10,100);

[bhx,ry] = meshgrid(bh,r);

rho = zeros(size(bhx));

for i=1:length(bh)
    for j=1:length(r)
        p = [4*r(j)*cos(bh(i))-4*r(j)-3 4 -1];
        rho(j,i) = max(abs(roots(p)));
    end
end

figure(14030101);
clf;
mesh(bhx,ry,rho);
ylabel('r');
xlabel('\beta h');
xlim([0,pi]);
zlabel('\rho');