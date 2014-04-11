% HW14 Problem 1
%
% Solve the IBVP using 14.10

% parameters
t0 = 0;
tf = 2;
h = 0.02; % one at a time!
k = h/2;
r = k/h^2;
% domain
x = (0:h:1)';
M = length(x); 
t = (t0:k:tf)';
% time dependent p,q
p = ones(1,length(t));
q = pi*ones(1,length(t));
% initial distribution
u0 = sin(pi.*x);
% boundaries
g1 = 0.*t;
% store LHS bc check
dbc = 0.*t;

u = u0;
dbc(1) = u(1)+(u(2)-u(1))/h-(u(3)-2*u(2)+u(1))/(2*h);

figure(140101); % for watching solution
clf;
plot(x,u0);
hold on;
A = spdiags(ones(M-1,1)+r,0,M-1,M-1)+...
    spdiags(-r.*ones(M-1,1)./2,1,M-1,M-1)+...
    spdiags(-r.*ones(M-1,1)./2,-1,M-1,M-1);
B = spdiags(ones(M-1,1)-r,0,M-1,M-1)+...
    spdiags(r.*ones(M-1,1)./2,1,M-1,M-1)+...
    spdiags(r.*ones(M-1,1)./2,-1,M-1,M-1);

for i=2:length(t)
    % modify first row of each A,B
    A(1,1:2) = [1+r*(1-h*p(i)),-r];
    B(1,1:2) = [1-r*(1-h*p(i-1)),r];
    % set b
    b = zeros(M-1,1); b(1) = -r*h*(q(i-1)+q(i)); b(end) = r/2*(g1(i-1)+g1(i));
    % solve the system for U (Eq 13.9)
    unew = A\(B*u(1:end-1)+b);
    % check minimax prinicple
    if max(unew) > max(u0)
        fprintf('your solution is behaving badly\n')
        break
    end
    u = [unew;g1(i)];
    dbc(i) = u(1)+(u(2)-u(1))/h-(u(3)-2*u(2)+u(1))/(2*h);
    % watch the diffusion
    plot(x,u);
    % pause(.01);
end
uexact = sin(pi.*x).*exp(-pi^2*tf);

figure(140102);
clf;
plot(x,u,'b','LineWidth',2);
xlabel('x','FontSize',16);
ylabel('u','FontSize',16);
legend({'t = 2'},'Location','NorthWest');

figure(140103);
clf;
plot(t,dbc-pi,'b','LineWidth',2);
xlabel('t','FontSize',16);
ylabel('error of LHS BC','FontSize',16);
legend({'error'},'Location','NorthEast');
