% make a contour plot of the stability region of A-B 2nd order

% number of points in x and y
numz = 1000;
numr = 3; % bound of x,y
x = linspace(-numr,numr,numz); % real
y = linspace(-numr,numr,numz); % imag
[xz,yz] = meshgrid(x,y); % make matrices
h = 1; % h just scales the axes
z = xz+1i*yz; % use this for complex math
stable_region1 = abs(0.5.*((1+h.*z./2+(h.*z).^2)+sqrt((1+h.*z./2+(h.*z).^2).^2+2.*h.*z)));
stable_region2 = abs(0.5.*((1+h.*z./2+(h.*z).^2)-sqrt((1+h.*z./2+(h.*z).^2).^2+2.*h.*z)));

% non-vectorized search for the boundary
% could use 'find' in a smart way to vectorize
% but this works
stable_region = zeros(numz);
for i=1:numz
    for j=1:numz
        % check if on the boundary of both
        if stable_region1(i,j) <= 1 && stable_region2(i,j) <= 1
            stable_region(i,j) = 1;
        end
    end
end

% plot the first figure
% looks like that in notes
hf = figure;
contour(xz,yz,stable_region1,[1,1],'k');
hold on;
contour(xz,yz,stable_region2,[1,1],'k');
% set(gca,'XTick',1:(numz/12):numz)
% set(gca,'XTickLabel',x(1:(numz/12):end))
grid on;
xlabel('h \lambda _R','FontSize',24);
ylabel('h \lambda _I','FontSize',24);
saveas(hf,'andy_hw04_prb08_01.png')
% close(hf);

% plot the second figure
% cleaner boundary from search
gf = figure;
contour(xz,yz,stable_region,[1,1],'k');
grid on;
xlabel('h \lambda _R','FontSize',24);
ylabel('h \lambda _I','FontSize',24);
saveas(gf,'andy_hw04_prb08_02.png')
% close(gf);