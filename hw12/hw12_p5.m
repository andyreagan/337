% Homework 12 - Problem 5:

% Analyzing the effect of smoothness of the initial data on
%  the order of the error in the simple explicit method for the Heat equation
%   u_t = u_xx  with the boundary conditions  u(0)=u(1)=0.

% Setting up the color and styles table for the lines (needed for plotting below):
line_color(1,:)=[1 0 0];   % red
line_color(2,:)=[0 0 0];   % black   %%%[0 0.8 0.2];   % greenish
line_color(3,:)=[0 0 1];   % blue
line_style=char('-','--','-.');


p=0;                % parameter characterizing the order of the lowest derivative that
                    %  is discontinuous in the initial condition
                    
r=0.1; % input('enter 0.5, 0.4, or 0.3 :   r = ') ;              %  K/h^2
tmax=0.5;

disp(' ')
disp(['Value of p = ' int2str(p)])

                    
for kk=1:3          % this loop changes the step size in  x
	h=(1/20)/2^(kk-1);
	K=r*h^2;
	
	x=0:h:1;
	M=length(x);   % THIS M = [(M+1) OF THE NOTES], i.e. M_notes = thisM - 1.
	t=0:K:tmax;
	N=length(t);   % THIS N = [(N+1) OF THE NOTES], i.e. N_notes = thisN - 1.

    % Boundary confitions:
	U(:,1)=zeros(N,1);
	U(:,M)=zeros(N,1);
    
    % Initial condition:
	Mo4=round((M-1)/4);  % auxiliary number = M/4 (see below)
    m_shift_ic=0;        % include the possibility to shift the initial condition off-center
                         %  (this option is not really needed)
    if p == 0
	    U(1,:)=[zeros(1,Mo4-0*2^(kk-1)) ones(1,M-2*Mo4) zeros(1,Mo4+0*2^(kk-1))];
    else 
        U(1,:)=[zeros(1,Mo4-m_shift_ic*2^(kk-1))  (cos(2*pi*(x(Mo4+1:M-Mo4)-1/2))).^p ...
                zeros(1,Mo4+m_shift_ic*2^(kk-1))];
    end
	
    % Advance the solution from the n-th to the (n+1)-st level
	for n=1:N-1
        for m=2:M-1
            U(n+1,m)=r*U(n,m+1)+(1-2*r)*U(n,m)+r*U(n,m-1);
        end
	end
	    
    % Save the coarsest x-grid:
    if kk==1
        xcoarse=x;
    end
    
    % Record the final solution for each  h:
    Uend(kk,:)=U(end,1:2^(kk-1):end);
    % It is not used for plotting, but for the calculation of gamma.
    

    % Plot the solution at t=tmax for each step size  h.
    %  First, prepare an auxiliary index  nr  for subplots.
    %  With this index, the code can be run for three different values of  r  (and for
    %  a given  p), and the results can be plotted all in one figure.
%     if abs(r-0.5) < 10*eps
%         nr=1;
%     elseif abs(r-0.4) < 10*eps
%         nr=2;
%     elseif abs(r-0.3) < 10*eps
%         nr=3;
%     else      % i.e. if I decide to try other values of r
%         nr=4444;
%         disp(' ')
%         disp('You entered an unspecified value of  r !  <--------------')
%         disp('Rerun the code with a specified value.    <--------------')
%         disp(' ')
%         break
%     end
%     
%     figure(120501); 
% 	subplot(3,1,nr);
% 	plot(x,U(end,:),'color',line_color(kk,:),'linestyle',line_style(kk,:),'linewidth',2)
%     ylabel(['r=' num2str(r)], 'fontsize', 14)
%     if nr == 3
%         xlabel('X', 'fontsize', 12)
%     elseif nr == 1
%         title(['solution at T_{max}=' num2str(tmax) '; p=' num2str(p)], 'fontsize', 14)
%     end
%     
% 	hold on
%     
%     % This is the same plot as in figure 11 (except for the initial condition),
%     %  but it is bigger, and it is not saved when we run different values of  r.
%     figure(120502);
%     plot(x,U(end,:),'color',line_color(kk,:),'linestyle',line_style(kk,:),'linewidth',2)
%     xlabel('X', 'fontsize', 12);
%     ylabel(['U(t=end)  for  r=' num2str(r)], 'fontsize', 14)
%     title('Same as fig. 120501, but bigger','fontsize',14)
%     hold on
    
    % Clear the arrays whose dimensions will be changing with  h
    %  except for the last values of h (they will be needed for plotting
    %  of the initial condition):
    if kk < 3-eps
        clear('x','t','U')
    end   
        
end    

% % Plot the initial condition:
% figure(120501);
% subplot(3,1,nr);
% plot(x,U(1,:)*max(abs(U(end,:))),'m:','linewidth',3)
%               % One needs to scale the amplitude of the initial condition so that it 
%               %  could be plotted along with the solution at t=tmax. The above scaling 
%               %  assumes that max(U0)=1, as it should be.
% legend('h', 'h/2', 'h/4', '@t=0, h/4',-1)
% hold off
% 
% figure(120502); 
% legend('h', 'h/2', 'h/4',-1)
% hold off


% Compute gamma_h  (in the notations of the HW problem):
error_exponent = log2( ...
                 (Uend(1,2:end-1)-Uend(2,2:end-1))./(Uend(2,2:end-1)-Uend(3,2:end-1)) ...
                      );

% % Plot the real and imaginary parts of gamma versus x:
% figure(120503);
% subplot(2,1,1), plot(xcoarse(2:end-1),real(error_exponent))
% xlabel('X', 'fontsize', 14)
% ylabel('Re (\gamma)', 'fontsize', 14)
% subplot(2,1,2), plot(xcoarse(2:end-1),imag(error_exponent))
% xlabel('X', 'fontsize', 14)
% ylabel('Im (\gamma)', 'fontsize', 14)

maxRegamma____maxImgamma = ...
[max(real(error_exponent)), max(imag(error_exponent))]

minRegamma____minImgamma = ...
 [min(real(error_exponent)), min(imag(error_exponent))]