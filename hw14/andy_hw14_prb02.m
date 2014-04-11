% HW14 Problem 1
%
% Solve the IBVP using 14.10

%% parameters
pb = 0; % whether to plot intermediate solution
t0 = 0;
tf = 0.5;
h = 0.02; % one at a time!
k = h/8;
r = k/h^2;
% domain
x = (0:h:1)';
xmids = x(2:end-1);
M = length(x); 
t = (t0:k:tf)';
% alpha, gamma, beta
% take scalar t, vector x
% return vector of function values
a = @(t,x) 1+x;
g = @(t,x) ones(1,length(x));
be = @(t,x) -x.^2./(1+t^2);
% initial distribution
u0 = sin(pi.*x);
% boundaries
g0 = 0.*t;
g1 = 0.*t;
u = u0;

%% solving loop

if pb
    figure(130401); % for watching solution
    plot(x,u0);
    hold on;
end

for i=2:length(t)
    % reset A,B entirely (really just need the mid diagonal for this
    % alpha,beta,gamma combo though)
    A = spdiags(ones(M-2,1)-k/2*be(t(i),xmids+h/2)+r.*a(t(i),xmids+h/2)-r.*a(t(i),xmids-h/2),0,M-2,M-2)+...
        spdiags([0;-r/2.*a(t(i),xmids(1:end-1)+h/2)+r/2*a(t(i),xmids(1:end-1)-h/2)],1,M-2,M-2)+...
        spdiags(-r/2.*a(t(i),xmids+h/2)+r/2*a(t(i),xmids-h/2),-1,M-2,M-2);
    B = spdiags(ones(M-2,1)+k/2*be(t(i),xmids+h/2)-r.*a(t(i),xmids+h/2)+r.*a(t(i),xmids-h/2),0,M-2,M-2)+...
        spdiags([0;r/2.*a(t(i),xmids(1:end-1)+h/2)-r/2*a(t(i),xmids(1:end-1)-h/2)],1,M-2,M-2)+...
        spdiags(r/2.*a(t(i),xmids+h/2)-r/2*a(t(i),xmids-h/2),-1,M-2,M-2);
    % set b (zero BC so all zeros)
    b = zeros(M-2,1);
    % solve the system for U (Eq 13.9)
    unew = A\(B*u(2:end-1)+b);
    % check minimax prinicple
    if max(unew) > max(u0)
        fprintf('your solution is behaving badly\n')
        break
    end
    u = [g0(i);unew;g1(i)];
    % watch the diffusion
    if pb
        plot(x,u);
        pause(.1);
    end
end


%% plotting
figure(14020101);
clf;
plot(x,u0,'r','LineWidth',2);
hold on;
plot(x,u,'b','LineWidth',2);
xlabel('x','FontSize',16);
ylabel('u','FontSize',16);
legend({'t = 0','t = 0.5'});