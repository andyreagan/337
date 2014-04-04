% homework 13 - Problem 5:

% analyzing the effect of smoothness of the initial data on
%  the order of the error in the simple explicit method for the Heat equation
%   u_t = u_xx  with the boundary conditions  u(0)=u(1)=0.

% Setting up the color table for the lines (needed for plotting below):
line_color(1,:)=[1 0 0];   % red
line_color(2,:)=[0 0 0];   % black
line_color(3,:)=[0 0 1];   % blue
line_style=char('-','--','-.');

theta=1/2;          % 0.5 => Crank-Nicolson method
% theta=1; %  => implicit Euler method

p=0;                % parameter characterizing the order of the lowest derivative that
%  is discontinuous in the initial condition

coeff_r=input(' r = 1/(coeff_r*h); thus, enter 3 or 6: coeff_r = ');   % kappa = r*h^2

tmax=0.5;

disp(' ')
disp(['Value of p = ' int2str(p)])


for kk=1:3          % the loop changing the step size in  x
    h=0.05/2^(kk-1);
    r=1/(coeff_r*h);          %  K/h^2
    K=r*h^2;
    
    x=0:h:1;
    M=length(x);
    t=0:K:tmax;
    N=length(t);
    
    % Boundary confitions:
    clear U
    U(:,1)=zeros(N,1);
    U(:,M)=zeros(N,1);
    
    % Initial condition:
    Mo4=round((M-1)/4);  % auxiliary number = M/4 (see below)
    if p == 0
        U(1,:)=[zeros(1,Mo4)  ones(1,M-2*Mo4)  zeros(1,Mo4)];
    else
        U(1,:)=[zeros(1,Mo4)  (cos(2*pi*(x(Mo4+1:M-Mo4)-1/2))).^p   zeros(1,Mo4)];
    end
    
    % -----------------------------------------------------------------------------------------
    
    
    %     disp(t);
    %     row vector
    %     disp(x);
    %     row vector
    %     disp(U);
    %     matrix of zeros
    M = length(x);
    A = spdiags(-2.*ones(M-2,1),0,M-2,M-2)+...
        spdiags(ones(M-2,1),1,M-2,M-2)+...
        spdiags(ones(M-2,1),-1,M-2,M-2);
    b = zeros(M-2,1); % b(1) = g0(i)+g0(i-1); b(end) = g1(i)+g1(i-1);
    for i=2:length(t)
        U(i,2:end-1) = ((eye(M-2)-theta*r.*A)\((eye(M-2)+(1-theta)*r.*A)*U(i-1,2:end-1)'+b))';
    end
    
    
    
    
    %  ----------------------------------------------------------------------------------------
    
    % Save the coarsest x-grid:
    if kk==1
        xcoarse=x;
    end
    
    % Record the initial conditions and the final solution for each  h:
    %    Ubegin(kk,:)=U(1,1:2^(kk-1):end);
    Uend(kk,:)=U(end,1:2^(kk-1):end);
    % It is not used for plotting, but for the calculation of gamma.
    
    % Plot the solution at t=tmax for each step size  h.
    %  First, prepare an auxiliary index  nr  for subplots.
    %  With this index, the code can be run for two different values of  r  (and for
    %  given  p and  theta), and the results can be plotted all in one figure.
    if coeff_r == 2
        nr=1;
    elseif coeff_r == 4
        nr=2;
    else
        nr = 4444;
        disp(' ')
        disp('You entered an unspecified value of  coeff_r !  <--------------')
        disp('Rerun the code with a specified value.    <--------------')
        disp(' ')
        break
    end
    if nr <= 2
        figure(130501);
        subplot(2,1,nr);
    end
    plot(x,U(end,:),'color',line_color(kk,:),'linestyle',line_style(kk,:),'linewidth',2)
    ylabel(['r=1/(' num2str(coeff_r) '*h)'], 'fontsize', 16)
    if nr == 2
        xlabel('X', 'fontsize', 12)
    elseif nr == 1
        title(['solution at T_{max}=' num2str(tmax) '; p=' num2str(p)], 'fontsize', 14)
    end
    
    hold on
    
    % This is the same plot as in figure 11 (except for the initial condition),
    %  but it is bigger, and it is not saved when we run different values of  r.
    figure(130502);
    plot(x,U(end,:),'color',line_color(kk,:),'linestyle',line_style(kk,:),'linewidth',2)
    xlabel('X', 'fontsize', 12);
    ylabel(['U(t=end)  for  r=1/(' num2str(coeff_r) ' h)'], 'fontsize', 14)
    title('Same as fig. 130501, but bigger','fontsize',14)
    hold on
    
    % Clear the arrays whose dimensions will be changing with  h
    %  except for the last values of h (they will be needed for plotting
    %  of the initial condition):
    if kk < 3-eps
        clear('x','t','U','Uu','R','a','b','c');
    end
    
end

% Plot the initial condition:
figure(130501); subplot(2,1,nr);
plot(x,U(1,:)*max(abs(U(end,:))),'m:','linewidth',3)
% One needs to scale the amplitude of the initial condition so that it
%  could be plotted along with the solution at t=tmax. The above scaling
%  assumes that max(U0)=1, as it should be.
legend('h', 'h/2', 'h/4', '@t=0, h/4',-1)
hold off

figure(130502);
legend('h', 'h/2', 'h/4', -1)
hold off


% Compute gamma_h  (in the notations of the HW problem):
error_exponent=log((Uend(1,:)-Uend(2,:))./(Uend(2,:)-Uend(3,:)))/log(2);

% Plot the real and imaginary parts of gamma versus x:
figure(130503);
subplot(2,1,1), plot(xcoarse,real(error_exponent))
xlabel('X', 'fontsize', 14)
ylabel('Re (\gamma)', 'fontsize', 14)
subplot(2,1,2), plot(xcoarse,imag(error_exponent))
xlabel('X', 'fontsize', 14)
ylabel('Im (\gamma)', 'fontsize', 14)

maxRegamma____maxImgamma = ...
    [max(real(error_exponent)), max(imag(error_exponent))]

minRegamma____minImgamma = ...
    [min(real(error_exponent)), min(imag(error_exponent))]



