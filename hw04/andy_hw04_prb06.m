% make a contour plot of the stability region of modified
% implicit Euler method

% number of points in x and y
numz = 100;
numr = 3; % bound of x,y
x = linspace(-numr,numr,numz); % real
y = linspace(-numr,numr,numz); % imag
[xz,yz] = meshgrid(x,y); % make matrices
h = 1; % h just scales the axes
z = xz+1i*yz; % use this for complex math
stable_region1 = abs((1+z.*h./2));
stable_region2 = abs((1-z.*h./2));

% non-vectorized search for the boundary
% could use 'find' in a smart way to vectorize
% but this works
stable_region = zeros(numz);
for i=1:numz
    for j=1:numz
        % check if on the boundary of both
        if stable_region1(i,j) < stable_region2(i,j)
            stable_region(i,j) = 1;
        end
    end
end

% plot the second figure
% cleaner boundary from search
gf = figure;
contour(xz,yz,stable_region,[1,1],'k');
grid on;
saveas(gf,'andy_hw04_prb06_01.png')
close(gf);