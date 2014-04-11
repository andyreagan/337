% HW14 Problem 4
%
% Solve the IBVP using a semi-implicit scheme

%% parameters
pb = 1; % whether to plot intermediate solution
t0 = 0;
tf = 3;
h = 0.02; % one at a time!
r = 1;
k = r*h^2;
% domain
x = (-5:h:5)';
xmids = x(2:end-1);
M = length(x); 
t = (t0:k:tf)';
% alpha, gamma, beta
% take scalar t, vector x
% return vector of function values
a = @(t,x) 1+x;
g = @(t,x) ones(1,length(x));
be = @(t,x) -x.^2./(1+t^2);
ga = 0.125;
m = 1;
% initial distribution
u0 = (4/pi).*atan(exp(7.*x));
% boundaries
g0 = 0.*ones(length(t),1);
g1 = 2.*ones(length(t),1);
% error over time
max_error = 0.*ones(length(t),1);
uexact = 1+tanh((x)./(2*ga));

u = u0;
%% solving loop

if pb
    figure(14040101); % for watching solution
    clf;
    plot(x,u0);
    hold on;
end

% use an approximation for starting the method
% uhalf = uold; % just have no change
% here, use an explicit scheme, ignoring the nonlinearity        
uold = u;
% with the u-1
unew = u(2:end-1)+k/(2*h).*(u(2:end-1)-m).*(u(3:end)-u(1:end-2))+ ...
       ga*k/h^2.*(u(3:end)-2.*u(2:end-1)+u(1:end-2));
u = [g0(2);unew;g1(2)];

% figure;
% plot(x,uold,'b')
% hold on;
% plot(x,u,'r')

max(abs(u-uold))

max_error(1:2) = [max(abs(uexact-uold)),max(abs(uexact-u))];

for i=3:length(t)
    % precompute the half step (it will be used in each matrix)
    uhalf = (3/2).*u-(1/2).*uold;
    
    % save a step back
    uold = u;
    
    % reset A entirely 
    % here A is built for the RHS
    A = spdiags(-ga*k/h^2.*ones(M-2,1),0,M-2,M-2)+...
        spdiags(ga*k/(2*h^2)+(uhalf(1:end-2)-m).*k/(4*h),1,M-2,M-2)+...
        spdiags(ga*k/(2*h^2)-(uhalf(3:end)-m).*k/(4*h),-1,M-2,M-2);
    % break; % check that A,B look okay
    % set b 
    b = zeros(M-2,1); b(1) = 0; 
    b(end) = g1(i-1)*(ga*k/(2*h^2)+(uhalf(end)-m).*k/(4*h))...
             +g1(i)*(ga*k/(2*h^2)+(uhalf(end)-m).*k/(4*h));
    % solve the system for U (Eq 13.9)
    unew = (speye(M-2)-A)\((speye(M-2)+A)*u(2:end-1)+b);
    u = [g0(i);unew;g1(i)];
    % watch the diffusion
    if pb
        if mod(t(i),0.5) == 0 
            figure(14040101); % for watching solution
            plot(x,u);
        end
        % pause(.1);
    end
    
    max_error(i) = max(abs(uexact-u));
end


%% plotting
figure(14040201);
clf;
plot(x,u0,'r','LineWidth',2);
hold on;
plot(x,u,'b','LineWidth',2);
xlabel('x','FontSize',16);
ylabel('u','FontSize',16);
legend({'t = 0','t = 3'});

figure(14040301);
clf;
plot(x,uexact,'r','LineWidth',2);
hold on;
plot(x,u,'b','LineWidth',2);
xlabel('x','FontSize',16);
ylabel('u','FontSize',16);
legend({'asymptotically exact','numerical'});

figure(14040401);
clf;
plot(x,uexact-u,'r','LineWidth',2);
xlabel('x','FontSize',16);
ylabel('error','FontSize',16);
legend({'error of numerical solution'});

figure(14040501);
clf;
plot(t,max_error,'r','LineWidth',2);
xlabel('t','FontSize',16);
ylabel('max error over time','FontSize',16);
legend({'max error of numerical solution'});




