% make a contour plot of the stability region of ME

numz = 100;
numr = 3;
x = linspace(-numr,numr,numz); % real
y = linspace(-numr,numr,numz); % imag
[xz,yz] = meshgrid(x,y);
h = 1;
stable_region = (1+h.*xz+0.5.*((h.*xz).^2-(h.*yz).^2)).^2+(h.*yz+h^2.*yz.*xz).^2;
% or do it with a complex number
% z = xz+1i*yz;
% stable_region = abs(1+z*h+0.5*z.^2*h^2);

hf = figure;
contour(xz,yz,stable_region,[1,1],'k');
% set(gca,'XTick',1:(numz/12):numz)
% set(gca,'XTickLabel',x(1:(numz/12):end))
grid on;
xlabel('h \lambda _R','FontSize',24);
ylabel('h \lambda _I','FontSize',24);
saveas(hf,'andy_hw04_prb01.png')
% close(hf);