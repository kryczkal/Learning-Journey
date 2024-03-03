function y = iterative_solver(A,b)
% Author: Łukasz Kryczka
% Simple implementation of the Gauss-Seidel algorithm

% y = zeros(1,length(b));

diagonal = zeros(1,length(b));
b = b(:)';
% Set diagonal values to zero to satisfy the condition j!=i in y*A(i,:)'
for i = 1:length(A)
    diagonal(i) = A(i,i);
    A(i,i) = 0;
end
y = b./diagonal;
% In MATLAB, operations on columns (rather than on rows) are faster in loops due to how matlab caches data
% Iterate until desired accuracy is achieved
TRESHOLD = eps*length(A);
error = -1;
while(error > TRESHOLD) || error==-1
    old_y = y;
    for i = 1:length(b)
        y(i) = ( b(i) - y*A(:,i)) / diagonal(i);
    end
    error = euclidean_norm(y - old_y);
end