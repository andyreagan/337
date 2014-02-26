methodcell = {'SE','symE3'};
resultscell = cell(1,length(methodcell));
analcell = cell(1,length(methodcell));
colorcell = {'r','b'};

t0 = 0; tmax = 50;
y0 = 0; dy0 = 1;

gamma = 0.015;
w0 = 1;
params = {gamma,w0}; % gamma, omega_0

for h=.01:.02:.05
    tvec = t0:h:tmax;    
    figure;
    for i=1:2
        methodh = str2func(sprintf('andy_%s',methodcell{i}));
        resultscell{i} = methodh(@andy_SHO_damped,tvec,[y0;dy0],h,params);
        analcell{i} = [(1/w0)*exp(-gamma.*tvec).*sin(w0.*tvec);...
            exp(-gamma.*tvec).*cos(w0.*tvec)-...
            (gamma/w0)*exp(-gamma.*tvec).*sin(w0.*tvec)]; % analytical        
        subplot(130+i); % phase plot of SE
        soln = resultscell{i};
        anal = analcell{i};
        plot(anal(1,:),anal(2,:),'r')
        hold on;
        plot(soln(1,:),soln(2,:),'b')
        legend({'analytical',methodcell{i}});
        xlabel('y','FontSize',20)
        ylabel('v','FontSize',20)
    end
    subplot(133); % error in total energy of each
    energy_anal = (exp(-2*gamma.*tvec))./(2*w0^2).*(w0^2-gamma^2.*cos(2*w0.*tvec)-w0*gamma.*sin(2*w0.*tvec));
    for i=1:2
        soln = resultscell{i};
        energy_soln = 0.5.*(soln(2,:).^2+w0^2.*soln(1,:).^2);
        plot(tvec,abs(energy_soln-energy_anal),colorcell{i});
        hold on;
    end
    legend(methodcell);
    xlabel('t','FontSize',20)
    ylabel('Total Energy error','FontSize',20)
    set(gcf, 'units', 'inches', 'position', [1 1 10 4])
    set(gcf,'PaperPositionMode','auto')
    print('-depsc2','-zbuffer','-r200',sprintf('andy_hw05_prb08_%0.02d.eps',100*h))
end