% compare the simple Euler,
% cRK, and implicit Euler methods

% include my_ME.m and my_cRK.m from hw02
try
    addpath('../shared_methods');
catch
    fprintf('this code will not work ');
    fprintf('without my_cRK and my_ME in path\n');
end

% define h, methods to use
h = 0.125;
methods = {'my_SE','my_cRK','my_IE'};
x = 0:h:1.5;
% store the solutions as rows in a matrix
sol_mat = zeros(length(methods)+1,length(x));
% our ODE
dy = @(t,y,params) -20*y;
% our IC
y0 = 1;

% analytical solution
for i=1:length(x)
    t=x(i); sol_mat(1,i) = exp(-20*t);
end
    
% solve for each method
for i=1:length(methods)
    fprintf('solving with %s\n',methods{i});
    method = str2func(methods{i});
    sol_mat(i+1,:) = method(dy,x,y0,h,[]);
end

% make plots
figure;
plot(x,sol_mat(2,:));
xlabel('x','FontSize',24);
ylabel('y','FontSize',24);
saveas(gcf,'andy_hw04_prb07_01.png');
% close(fh);

figure;
plot(x,sol_mat(1,:),x,sol_mat(3,:),x,sol_mat(4,:));
legend('analytical','cRK','implict Euler');
xlabel('x','FontSize',24);
ylabel('y','FontSize',24);
saveas(gcf,'andy_hw04_prb07_02.png');
% close(fh);