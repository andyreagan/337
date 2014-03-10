% Function for the Thomas Algorithm for solving a tridiagonal linear system.

% User inputs vectors containing the diagonal elements (b) and the
% subdiagonal elements (a - the lower, and c - the upper).
% Note that if the system is MxM, b should have length M while a and c should
% both have length M-1

function  y = thomas(a,b,c,r);

M = length(b);

% Check to make sure the arrays are of proper length
if length(a) == M-1 && length(c) == M-1 || length(r) == M
    y = zeros(1,M);
    z = zeros(1,M);
    beta = zeros(1,M);
    alpha = zeros(1,M-1);

    beta(1)=b(1);
    z(1)=r(1);

    % L U decomposition and forward substitution
    for j=2:M
        jm1 = j-1;
        alpha(jm1) = a(jm1)/beta(jm1);
        beta(j) = b(j) - alpha(jm1)*c(jm1);
        
        z(j) = r(j) - alpha(jm1)*z(jm1);
    end
    
    % Backward substitution
    y(M) = z(M)/beta(M);
    for i = M-1 :-1: 1
        y(i) = ( z(i)-c(i)*y(i+1) ) / beta(i);
    end
    
%     for i=1:M-1
%         y(M-i) = ( z(M-i)-c(M-i)*y((M+1)-i) ) / beta(M-i);
%     end
    
else
    disp('Error: nice try, but you have a problem with the length of your arrays.');
    lengths_of_a_b_c_r = [length(a) length(b) length(c) length(r)]
end
