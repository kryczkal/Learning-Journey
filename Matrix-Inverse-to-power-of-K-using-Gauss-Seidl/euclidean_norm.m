function y = euclidean_norm(v)
% Author: Łukasz Kryczka
% Function to calculate the Euclidean norm of a vector

y  = 0;
for i = 1:length(v)
    y = y + v(i)*v(i);
end
y = sqrt(y);