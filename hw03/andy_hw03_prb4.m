% prb4.m
% solve the ODE
%    y' = sin(y), y(0) = 1
% using a multi-step method

% IC
y0 = 1;

% define the function
dy = @(t,y,params) sin(y);
ay = @(t,y,params) 2*acot(exp(-t)*cot(1/2));

% parameters (there are none)
params = [];

% find the max of y''' on [0,pi]
x = linspace(0,pi,100);
% y'''
ytp = -4.*sin(x).*cos(x)-2.*(sin(x).^2).*cos(x)+(cos(x).^3)-3.*sin(x).^2.*cos(x);
% take a quick look
h = figure;
plot(x,ytp);
hold on; plot(x(find(ytp==max(ytp),1)),max(ytp),'s','MarkerSize',5,'MarkerFaceColor','k');
saveas(h,'andy_hw03_prb4_ytp.png'); close(h); hold off;

methodcell = {'ME','RK3'};
for methodcount=1:2
    method = methodcell{methodcount};
    fprintf('running with initial method %s\n',method);
    % solve for h per equation 3.37
    h = ((12e-4)/max(ytp))^(1/3);
    fprintf('h is %.6f\n',h);
    
    % set up the interval
    x = 0:h:pi;
    % initialize arrays
    y = zeros(1,length(x)); y(1) = y0;
    y_p_vec = zeros(1,length(x)); y_p_vec(1) = y0;
    error = zeros(1,length(x));
    an = zeros(1,length(x)); an(1) = ay(x(1),y(1),params);
    
    % make a first guess using order O(h^2) method
    % here I first chose ME for 2nd order
    % but the modification of the method made it third order
    % so I want a third order method to begin it
    switch method
        case 'ME'
            k1 = h*dy(x(1),y(1),params);
            k2 = h*dy(x(1)+h,y(1)+k1);
            y(2) = y(1)+1/2*(k1+k2);
        case 'RK3'
            k1 = h*dy(x(1),y(1),params);
            k2 = h*dy(x(1)+0.5*h,y(1)+0.5*k1);
            k3 = h*dy(x(1)+h,y(1)-k1+2*k2);
            y(2) = y(1)+1/6*(k1+4*k2+k3);
    end
    y_p_vec(2) = y(2);
    an(2) = ay(x(2),y(2),params);
    
    % loop over interval
    for i=3:length(x)
        % grab current point
        x_i = x(i);
        % predictor
        y_p = y(i-1) + 0.5*h*(3*dy(x(i-1),y(i-1),params)-dy(x(i-2),y(i-2),params));
        % corrector
        y_c = y(i-1) + 0.5*h*(dy(x(i-1),y(i-1))+dy(x(i),y_p));
        % save the predictors
        y_p_vec(i) = y_p;
        % note the (-) sign because we subtract 3.39 from Y_c
        y(i) = 1/6*(y_p+5*y_c);
        % error estimate
        error(i) = abs(y(i) - y_p)/6;
        % analytial solution
        an(i) = ay(x_i,y(i),params);
    end
    
    % make lots of plots, save them all
    % first, the numerical solution
    
    yplot={y,y,an,error,error,abs(an-y),abs(abs(an-y)-abs(an-y_p_vec))};
    legendcell={'',{'numerical','analytical'},'','',{'estimated error','actual error'}};
    figname={'ay','both','an','error_est','error_both','error_true','improvement'};
    for i=1:length(yplot)
        h = figure; hold on;
        plot(x,yplot{i},'-');
        xlabel('x');
        ylabel('y');
        switch i
            case {2,5}
                plot(x,yplot{i+1},'--');
                legend(legendcell{i});
        end
        saveas(h,sprintf('andy_hw03_prb4_%s_%s.png',method,figname{i}));
        close(h);
    end
    
    % print those out
    fprintf('max estimated error is %.5f\n',max(error));
    fprintf('max true error is %.5f\n',max(abs(an-y)));
    
end