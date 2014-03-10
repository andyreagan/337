% HW08 Problem 4

clear all;

Mvec=[100,1000,5000,10000,50000];
for i=1:length(Mvec)
    M = Mvec(i);
    a = -ones(M-1,1);
    b = 2.*ones(M,1);
    c = -ones(M-1,1);
    r = ones(M,1);
    r(2:2:M) = -ones(floor(M/2),1);
    
    tic;
    y = thomas(a,b,c,r);
    tom_t(i) = toc;
    

    
    % too slow for the bigger problem
    if i<5
        A = diag(a,-1) + diag(b) + diag(c,1);
        % check this is correct
        % A(1:10,1:10)
        tic;
        y = A\r;
        mat_t(i) = toc;
    end
    
    % make sparse
    a = -ones(M,1);
    c = -ones(M,1);
    A = spdiags(a,-1,M,M) + spdiags(b,0,M,M) + spdiags(c,1,M,M);
    % verify sparse storage
    % A(1:10,1:10)
    
    tic;
    y = A\r;
    mat_t_sp(i) = toc;
end


figure;
plot(Mvec,tom_t)
hold on;
plot(Mvec,mat_t_sp,'r')
legend('thomas algorithm','matlab sparse solver')
xlabel('M','FontSize',20)
ylabel('time','FontSize',20)

figure;
plot(Mvec(1:end-1),mat_t)
xlabel('M','FontSize',20)
ylabel('time','FontSize',20)