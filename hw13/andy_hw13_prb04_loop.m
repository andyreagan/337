% HW13 Problem 4
%
% Solve the IBVP using CN

% parameters
t0 = 0;
tf = 0.5;
h = 0.1; % one at a time!
kvec = [0.1,0.05,0.025,0.01];
% domain
x = (0:h:1)';
finalSolnVec = zeros(length(x),length(kvec));
finalErrorVec = zeros(length(x),length(kvec));

% initial distribution
u0 = sin(pi.*x);

% figure(130401); % for watching solution
% plot(x,u0);
% hold on;
A = spdiags(-2.*ones(M-2,1),0,M-2,M-2)+...
    spdiags(ones(M-2,1),1,M-2,M-2)+...
    spdiags(ones(M-2,1),-1,M-2,M-2);

for j = 1:length(kvec)
    u = u0;
    k = kvec(j);
    r = k/h^2;
    M = length(x);
    t = (t0:k:tf)';
    % boundaries
    g0 = 0.*t;
    g1 = 0.*t;
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
        %plot(x,u);
        %pause(.1);
    end
    finalSolnVec(:,j) = u;
    uexact = sin(pi.*x).*exp(-pi^2*tf);
    finalErrorVec(:,j) = uexact-u;
end

figure(130402);
colors = ['b','r','g','k'];
for k=1:4
    plot(x,finalSolnVec(:,k),colors(k),'LineWidth',2);
    hold on;
end
xlabel('x','FontSize',16);
ylabel('u','FontSize',16);
hold on;
plot(x,uexact,'k--','LineWidth',2);
legend({'k=.1','k=0.05','k=0.025','k=0.01','exact'});

figure(130403);
colors = ['b','r','g','k'];
for k=1:4
    plot(x,finalErrorVec(:,k),colors(k),'LineWidth',2);
    hold on;
end
xlabel('x','FontSize',16);
ylabel('error','FontSize',16);
legend({'k=.1','k=0.05','k=0.025','k=0.01'})

%% find the error scaling

errors = finalErrorVec(6,:);

exp = log2((errors(1)-errors(2))/(errors(2)-errors(3)));
polyfit(log(kvec),log10(abs(errors)),1)