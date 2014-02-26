% make a really quick plot of
% the stable region of the cRK method

% create figure instance
figure;
h = 1;
x = linspace(-4,1,100);
lambda = -1i.*linspace(-4,1,100);
y = zeros(1,100);
% build the sum
% non vectorized but works
for k=0:5
    y = y+h^k.*lambda.^k./factorial(k);
end
% this won't matter, but just in case
y = abs(y);
% make the plot
plot(x,y);
hold on;
% plot a red line at 1
plot(x,ones(size(x)),'r');
xlabel('h \lambda _R','FontSize',24);
ylabel('error growth rate of cRK','FontSize',16);
saveas(hf,'andy_hw05_prb02_01.png');
% close(hf);

% find the stable region
stable_region = find(y < 1);
minstable =  x(min(stable_region)); % 2.78
% this should be zero
% for small number of x,y points, less than 0
maxstable =  x(max(stable_region));
% write out the latex
fprintf('the stable region is $%f \\leq h\\lambda \\leq %f$\n',minstable,maxstable);