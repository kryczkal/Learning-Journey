function y = exp2(X)
% Function to calculate the value of exp2 for each X
% Near 0, we use the Taylor expansion (1/n!) * x^(n-1) * 2 up to the 4th term
% Author: Łukasz Kryczka

col = iscolumn(X);
% Set the precision of the Taylor expansion to 4 every other value
precision = 4;
coefficients = 0:2:(precision*2)-1;
factorials = [1 (2:2:(2*precision)-1).*(3:2:(2*(precision)))];
factorials = cumprod(factorials)./2;

% Calculate the values of x separately for x in the vicinity of 0
border_val = 0.05;
normal_idx = (X >= -25) & (X <= -border_val) | (X >= border_val) & (X <= 25);
taylor_idx = (X > -border_val) & (X < border_val);

if col
    X = X';
end

y(normal_idx) = (exp(X(normal_idx))-exp(-X(normal_idx)))./X(normal_idx);
if any(taylor_idx)
    y(taylor_idx) = sum((X(taylor_idx).^(coefficients'))./(factorials'));
end

if col
    y = y';
end