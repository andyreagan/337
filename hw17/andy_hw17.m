% HW 17 Number 1
%
% Solve 17.13,14 with scheme 17.17
%
% Andy Reagan

h = 0.05;
k = 0.05;
t0 = 0;
tf = 2;
tvec = t0:k:tf;
x = 0:h:1;
a = 1;
u0 = a.*(sin(pi.*x).^2);
colors = {'r','b','g','k','c','y'};
times = [0,0.25,0.5,0.75,1];

figure(17010101);
plot(x,u0);
hold on;

mv = 0;

for i=1:length(tvec)
    t = tvec(i);
    fprintf('t = %g\n',t);
    % shift the grid points
    x = x + u0*k;
    for j=2:length(times)
        if t == times(j)
            figure(17010101);
            % [n,m] = sort(x);
            % plot(n,u0(m),colors{j});
            for n=1:length(x)-1
                if x(n+1)<x(n)
                    mv = 1;
                    mvv = x(n+1);
                    break;
                end
            end
            if mv
               [xplot,uplot] = findmid(x,u0,mvv);
               plot(xplot,uplot,colors{j});
            else
                plot(x,u0,colors{j});
            end
        end
    end
end



figure(17010101);
legend({'t = 0','t = 0.25','t = 0.5','t = 0.75','t = 1'},'Location','NorthWest');
xlabel('x');
ylabel('y');





