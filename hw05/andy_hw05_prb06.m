methodcell = {'verlet1','ME','cRK','SCD','ode45 tol .002','ode45 tol .003'};
resultscell = cell(1,length(methodcell));
analcell = cell(1,length(methodcell));

t0 = 0; tmax = 1000;

y0 = 0; dy0 = 1;

% for second order methods
h2 = 0.2;
tvec2 = t0:h2:tmax;
% for fourth order methods
h4 = 0.5;
tvec4 = t0:h4:tmax;

% tolerances for ode45
absTol1 = 0.002;
absTol2 = 1.5*absTol1;

% solve with verlet-1
i = 1; h = h2; tvec = tvec2;
methodh = str2func(sprintf('andy_%s',methodcell{i}));
resultscell{i} = methodh(@andy_SHO_1,tvec,[y0;dy0],h,[]);
analcell{i} = [sin(tvec);cos(tvec)]; % analytical

% solve with modified Euler
i = 2; h = h2; tvec = tvec2;
methodh = str2func(sprintf('andy_%s',methodcell{i}));
resultscell{i} = methodh(@andy_SHO_2,tvec,[y0;dy0],h,[]);
analcell{i} = [sin(tvec);cos(tvec)]; % analytical

% solve with cRK
i = 3; h = h4; tvec = tvec4;
methodh = str2func(sprintf('andy_%s',methodcell{i}));
resultscell{i} = methodh(@andy_SHO_2,tvec,[y0;dy0],h,[]);
analcell{i} = [sin(tvec);cos(tvec)]; % analytical

% solve with SCD
i = 4; tvec = tvec2; h = h2;
methodh = str2func(sprintf('andy_%s',methodcell{i}));
soln = zeros(2,length(tvec));
soln(1,:) = methodh(@andy_SHO_1,tvec,[y0;dy0],h2,[]);
% compute v
soln(2,2:end-1) = (soln(1,3:end)-soln(1,1:end-2))./(2*h);
soln(2,1) = dy0;
soln(2,end) = (soln(1,end)-soln(1,end-1))/h+(h/2)*(-soln(1,end));
resultscell{i} = soln;
% analytical
analcell{i} = [sin(tvec);cos(tvec)];

% solve with ode45
i = 5;
% methodh = str2func(sprintf('%s',methodcell{i}));
for abstol=[0.002,0.003]
    options = odeset('AbsTol',abstol);
    % [tvec,soln] = methodh(@andy_SHO_2,[t0,tmax],[y0;dy0],options);
    [tvec,soln] = ode45(@andy_SHO_2,[t0,tmax],[y0;dy0],options);
    resultscell{i} = soln';
    % analytical
    analcell{i} = [sin(tvec);cos(tvec)];
    i=i+1;
end

% plot all
for i=1:length(methodcell)
    soln = resultscell{i};
    anal = analcell{i};
    figure;
    subplot(121); % phase plot
    plot(anal(1,:),anal(2,:),'r')
    hold on;
    plot(soln(1,:),soln(2,:),'b')
    legend({'analytical',methodcell{i}});
    xlabel('y','FontSize',20)
    ylabel('v','FontSize',20)
    subplot(122); % error in hamiltonian
    plot(1:length(soln(1,:)),abs(1/2.*(anal(1,:).^2+anal(2,:).^2)-1/2.*(soln(1,:).^2+soln(2,:).^2)));
    % xlim([0,1000])
    xlabel('t','FontSize',20)
    ylabel('Hamiltonian error','FontSize',20)
    set(gcf, 'units', 'inches', 'position', [1 1 10 4])
    set(gcf,'PaperPositionMode','auto')
    print('-depsc2','-zbuffer','-r200',sprintf('andy_hw05_prb06_%02g.eps',i))
end

fprintf('now run\n')
fprintf('echo $(ls andy_hw05_prb06_0{1..6}*) | xargs -n 1 epstopdf\n')
