% HW13 Bonus II
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
        p = [1+2*r(j) -4*r(j)*cos(bh(i)) -1+2*r(j)];
        rho(j,i) = max(abs(roots(p)));
    end
end

figure(13070101);
clf;
mesh(bhx,ry,rho);
ylabel('r');
xlabel('\beta h');
xlim([0,pi]);
zlabel('\rho');