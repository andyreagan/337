% HW08 Problem 02

% set A,r from our problem
A = [-2,2,0,0,0;
    1,-2,1,0,0;
    0,2,-2,0,0;
    0,0,3,-2,-1;
    0,0,0,4,2];
r = [2;0;-2;-4;4];

% solve
x = A\r;
disp(x);