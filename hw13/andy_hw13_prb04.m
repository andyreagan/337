% HW13 Problem 4
%
% Solve the IBVP using CN

% parameters
t0 = 0;
tf = 0.5;
h = 0.1; % one at a time!
k = 0.1;
r = k/h^2;
% domain
x = (0:h:1)';
M = length(x); 
t = (t0:k:tf)';
% initial distribution
u0 = sin(pi.*x);
% boundaries
g0 = 0.*t;
g1 = 0.*t;

u = u0;
figure(130401); % for watching solution
plot(x,u0);
hold on;
A = spdiags(-2.*ones(M-2,1),0,M-2,M-2)+...
    spdiags(ones(M-2,1),1,M-2,M-2)+...
    spdiags(ones(M-2,1),-1,M-2,M-2);

for i=2:length(t)
    % set b (it doesn't change)
    b = zeros(M-2,1); b(1) = g0(i)+g0(i-1); b(end) = g1(i)+g1(i-1);
    % solve the system for U (Eq 13.9)
    unew = (eye(M-2)-r/2.*A)\((eye(M-2)+r/2.*A)*u(2:end-1)+b);
    % check minimax prinicple
    if max(unew) > max(u)
        fprintf('your solution is behaving badly\n')
        break
    end
    u = [g0(i);unew;g1(i)];
    % watch the diffusion
    plot(x,u);
    pause(.1);
end
uexact = sin(pi.*x).*exp(-pi^2*tf);

figure(130402);
plot(x,u,'b','LineWidth',2);
xlabel('x','FontSize',16);
ylabel('u','FontSize',16);
hold on;
plot(x,uexact,'r','LineWidth',2);
legend({'numerical','exact'});

figure(130403);
plot(x,abs(uexact-u),'r','LineWidth',2);
xlabel('x','FontSize',16);
ylabel('error of numerical soln','FontSize',16);