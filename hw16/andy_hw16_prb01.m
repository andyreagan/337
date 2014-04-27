% HW 16 Number 1
%
% Plot the d'Alembert Solution with c=1
%
% Andy Reagan

c = 1;
t0 = 0.1;
tf = 10;
k = 0.2;
tvec = t0:k:tf;
h = 0.1;
x = -10:h:10;
u = zeros(length(x),1);
width = zeros(length(tvec),1);

for i=1:length(tvec)
    t = tvec(i);
    for j=1:length(x)
        u(j) = 1/(2*c)*integral(@phi,x(j)-c*t,x(j)+c*t,'ArrayValued',true);
    end
    figure(16010101);
    plot(x,u);
    title(sprintf('t = %g',t));
    % pause;
    disp(t);
    disp(i);
    width(i) = (length(find(u>0))-1)*h;
    if t == 0.1
        figure(16010201);
        plot(321);
        plot(x,u);
        ylim([0,1]);
        ylabel('y')
        title(sprintf('t = %g',t));
    end
    if t == 0.9
        figure(16010201);
        subplot(322);
        plot(x,u);
        ylim([0,1]);
        title(sprintf('t = %g',t));
    end
    if i == 12
        figure(16010201);
        subplot(323);
        plot(x,u);
        ylim([0,1]);
        ylabel('y')
        title(sprintf('t = %g',t));
    end
    if i == 43
        figure(16010201);
        subplot(324);
        plot(x,u);
        ylim([0,1]);
        title(sprintf('t = %g',t));
    end    
    if i == 46
        figure(16010201);
        subplot(325);
        plot(x,u);
        ylim([0,1]);
        ylabel('y')
        xlabel('x')
        title(sprintf('t = %g',t));
    end    
    if t == 9.9
        figure(16010201);
        subplot(326);
        plot(x,u);
        ylim([0,1]);
        xlabel('x')
        title(sprintf('t = %g',t));
    end    
end

figure(16010301);
plot(tvec,width)


