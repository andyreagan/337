% HW12 Problem 1
%
% Solve the IBVP using scheme (12.12)

% parameters
t0 = 0;
tf = 0.5;
h = 0.1; % one at a time!
k = 0.004;
r = k/h^2;
% domain
x = 0:h:1;
t = (t0:k:tf)';
% initial distribution
u0 = sin(pi.*x);
% boundaries
g0 = 0.*t;
g1 = 0.*t;

u = u0;
figure; % for watching solution
plot(x,u0);
hold on;
for i=2:length(t)
    unew = r*u(3:end)+(1-2*r)*u(2:end-1)+r*u(1:end-2);
    % check minimax prinicple
    if max(unew) > max(u)
        fprintf('your solution is behaving badly\n')
        break
    end
    u = [g0(i),unew,g1(i)];
    % watch the diffusion
    plot(x,u)
    pause(.1)
end
uexact = sin(pi.*x).*exp(-pi^2*tf);

figure;
plot(x,u,'b','LineWidth',2)
xlabel('x','FontSize',16)
ylabel('u','FontSize',16)
hold on;
plot(x,uexact,'r','LineWidth',2)
legend({'numerical','exact'})

figure;
plot(x,abs(uexact-u),'r','LineWidth',2)
xlabel('x','FontSize',16)
ylabel('error of numerical soln','FontSize',16)