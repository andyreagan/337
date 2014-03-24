function phij = emily_HW9_P9_hatF(j,k,h,x)

%define phi_j: use j-1=j and j+1=j+2 since x(1)=x0;
if x(j) <= x(k+1) && x(k+1) <=x(j+2)
    phij = 1-abs(x(k+1)-x(j+1))/h;
else
    phij=0;
end