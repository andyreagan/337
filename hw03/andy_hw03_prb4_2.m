% prb4_2.m
% solve the ODE
%    y' = sin(y), y(0) = 1
% using a multi-step method

% IC
y0 = 1;

% define the function
dy = @(t,y,params) sin(y);

% parameters (there are none)
params = [];

% find the max of y''' on [0,pi]
x = linspace(0,pi,100);
% y'''
ytp = 5.*cos(x).^2.*sin(x)-3.*clsin(x).^3;
% take a quick look
figure;
plot(x,ytp);
hold on; plot(x(find(ytp==max(ytp),1)),max(ytp),'s','MarkerSize',5,'MarkerFaceColor','k');
xlabel('x','FontSize',16);
ylabel('y','FontSize',16);
saveas(gcf,'andy_hw03_prb4_ytp.png'); hold off;

% solve for h per equation 3.37
ytp_max = 1; % max(abs(ytp))
h = ((12e-4)/ytp_max)^(1/3);
fprintf('h is %.6f\n',h);

% set up the interval
x = 0:h:pi;
% initialize arrays
y = zeros(1,length(x)); y(1) = y0;
error = zeros(1,length(x));

% make a first guess using order O(h^2) method
% here I first chose ME for 2nd order

k1 = h*dy(x(1),y(1),params);
k2 = h*dy(x(1)+h,y(1)+k1);
y(2) = y(1)+1/2*(k1+k2);

y_p_vec(2) = y(2);

% loop over interval
for i=3:length(x)
    % grab current point
    x_i = x(i);
    % predictor
    y_p = y(i-1) + 0.5*h*(3*dy(x(i-1),y(i-1),params)-dy(x(i-2),y(i-2),params));
    % corrector
    y_c = y(i-1) + 0.5*h*(dy(x(i-1),y(i-1))+dy(x(i),y_p));
    % note the (-) sign because we subtract 3.39 from Y_c
    y(i) = 1/6*(y_p+5*y_c);
    % error estimate
    error(i) = abs(y_p- y_c)/6;
end

% make lots of plots, save them all
% first, the numerical solution

% cell of the data
yplot={y,error};
% cell of the legends
legendcell={'numerical','error estimate'};
figname={'numerical','just_error'};
for i=1:length(yplot)
    figure; hold on;
    plot(x,yplot{i},'-');
    xlabel('x','FontSize',16);
    legend(legendcell{i});
    ylabel('y','FontSize',16);
    saveas(gcf,sprintf('andy_hw03_prb4_%s.png',figname{i}));
end

% print those out
fprintf('max estimated error is %.5f\n',max(error));