function D = f(x, y, A, B)
% f - Computes the derivatives of the function y at point x
%
% This function calculates the values of the derivatives of the function y at point x
% using the Adams-Bashforth-Moulton method. It returns a vector of derivatives, where
% each element corresponds to the successive derivatives of the function y.
%
% Input:
% x      - The value of the independent variable for which the derivatives are computed.
% y      - Vector of values of y and its derivatives up to order m-1, in the form
%          [y, y', y'', ..., y^{(m-1)}].
% A      - Cell array of functions a_0, a_1, ..., a_{m-1} in the form
%          {@a0, @a1, ..., @am-1}.
% B      - Function handle for the right-hand side of the differential equation,
%          taking x and y as arguments.
%
% Output:
% D      - Vector of derivatives of y at x. It contains derivatives up to order m,
%          where y^{m} is calculated from the equation: y^{(m)} = (-a_0 y - ... -
%          a_{m-1} y^{(m-1)} + B) / a_m.
%
% Notes:
% The values of derivatives y', ..., y^{(m-1)} are passed as elements of y.
% The derivative y^{(m)} is calculated from the differential equation and
% the functions a_i and B.

D = zeros(size(y));
D(1:end-1) = y(2:end);
D(end) = (-sum(cellfun(@(f) f(x), A(1:end-1)) .* y(1:end), "all") + B(x, y))...
     / cellfun(@(f) f(x), A(end));