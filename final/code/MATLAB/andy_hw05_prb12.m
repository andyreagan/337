% keep in mind variable map
% [q' r' z' w'] where z' = q'' and w' = r''
pb = 0;

methodcell = {'verlet1_2','verlet2_2'};
resultscell = cell(1,length(methodcell));
analcell = cell(1,length(methodcell));

t0 = 0; tmax = 500;

ecc = 0.6;
y0 = [1-ecc;0;0;-sqrt((1+ecc)/(1-ecc))];

h = 0.001;
tvec = t0:h:tmax;

% solve with verlet-1
for i=1:1
    methodh = str2func(sprintf('andy_%s',methodcell{i}));
    resultscell{i} = methodh(@andy_kepler2,tvec,y0,h,[]);
    % analcell{i} = [sin(tvec);cos(tvec)]; % analytical
    
    
    
    if pb
        [q,r,Q,R]=deal(resultscell{1}(1,:),resultscell{1}(2,:),resultscell{1}(3,:),resultscell{1}(4,:));
        figure;
        subplot(224);
        plot(q,r)
        xlabel('q','FontSize',20)
        ylabel('r','FontSize',20)
        
        subplot(221);
        H = 0.5.*(Q.^2+R.^2)-1./(sqrt(q.^2+r.^2));
        plot(tvec,H);
        xlabel('t','FontSize',20)
        ylabel('H','FontSize',20)
        
        subplot(222);
        A = q.*R-r.*Q;
        plot(tvec,A);
        xlabel('t','FontSize',20)
        ylabel('A','FontSize',20)
        
        subplot(223);
        
        Li = R.*(q.*R-r.*Q)-(q)./sqrt(q.^2+r.^2);
        Lj = -Q.*(q.*R-r.*Q)-(r)./sqrt(q.^2+r.^2);
        plot(tvec,Li,'b');
        hold on;
        plot(tvec,Lj,'r');
        hold off;
        legend({'RL i','RL j'});
        xlabel('t','FontSize',20);
        ylabel('L','FontSize',20);
        
        set(gcf, 'units', 'inches', 'position', [1 1 10 10])
        set(gcf,'PaperPositionMode','auto')
        print('-depsc2','-zbuffer','-r200',sprintf('andy_hw05_prb12_%02g.eps',i))
    end
end