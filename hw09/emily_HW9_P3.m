M=10;

%define x and h
x=linspace(0,1,M+2);
h=x(2)-x(1);

%preallocate r
r=zeros(1,M);

for k = 1:M
    
    %xmid = middle of the interval over which phi_j*phi_k is nonzero
    xmidr=x(k+1);
    %create r
    r(k)=h*((2*xmidr-4)./((1+xmidr)^2));
    
    %create A for the linear system (9.8)
    xmidsub=mean([x(k+1),x(k+2)]);
    Qmidsub = -2/(1+xmidsub)^2;
    A1(k)=(1/h+(Qmidsub*h/6));
    
    xmiddiag = x(k+1);
    Qmiddiag = -2/(1+xmiddiag)^2;
    A2(k)=(-2/h+(Qmiddiag*2*h/3));
    
    xmidsuper=mean([x(k),x(k+1)]);
    Qmidsuper = -2/(1+xmidsuper)^2;
    A3(k)=(1/h+(Qmidsuper*h/6));
    
end
A=spdiags(A1',-1,M,M)+spdiags(A2',0,M,M)+spdiags(A3',1,M,M);

%determine coefficients
c=A\r';

Z=zeros(M,1);
%solve for the solution Z (9.3)
for k = 1:M
    for j=1:M
        Z(k)=Z(k)+c(j)*emily_HW9_P3_hatF(j,k,h,x);
        
    end
end

%solve for the solution Y
Y = zeros(M+1,1);
Y(2:M+1)=Z+x(2:end-1)';
Y(M+2)=1;

%exact soln
y=2.*x./(1+x);

%error
error=abs(Y-y');

%max error
maxError = max(abs(error));

figure(1);
subplot(1,2,1)
plot(x,Y); hold on; plot(x,y,'r')
set(gca,'FontSize',14)
legend('FEM','Exact')
title(sprintf('M = %g',M));

subplot(1,2,2)
plot(x,error)
set(gca,'FontSize',14)
title(sprintf('Max Error = %f',maxError));
