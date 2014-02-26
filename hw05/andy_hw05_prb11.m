% make a contour plot of the stability region of RK 5th order

% number of points in x and y
numz = 1000;
numr = 4; % bound of x,y
x = linspace(-numr,numr,numz); % real
y = linspace(-numr,numr,numz); % imag
[xz,yz] = meshgrid(x,y); % make matrices
h = 1; % h just scales the axes
z = xz+1i*yz; % use this for complex math
y = zeros(1,100);
% build the sum
% non vectorized but works
stable_region1 = ones(size(z));
for k=1:5
    stable_region1 = stable_region1+h^k.*z.^k./factorial(k);
end
stable_region1 = abs(stable_region1);


% plot the first figure
figure;
contour(xz,yz,stable_region1,[1,1],'k');
grid on;
xlabel('h \lambda _R','FontSize',24);
ylabel('h \lambda _I','FontSize',24);
saveas(gcf,'andy_hw05_prb11_01.png')