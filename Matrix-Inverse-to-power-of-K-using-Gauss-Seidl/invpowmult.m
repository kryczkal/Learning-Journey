function y = invpowmult(A,k,x)
% Author: Łukasz Kryczka
% Function to calculate the approximate value of x in the equation A^(-k) * x
% by solving the equation A^(-k) * x = b <==> A^(k) * b = x
% for the value of b.
% AAb = x <==> Ay = x, Ab = y, etc...
y = x;
A = A';
for i = 1:k
    y = iterative_solver(A,y);
end
y = y(:);