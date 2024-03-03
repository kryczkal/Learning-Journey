function [x, y] = ABM2_H(A, B, Y0, Span, N, Corr_N, tp, corr_first)
% Author: Łukasz Kryczka
%
% This function solves a system of ordinary differential equations of any order
% in the form: ( sum_{i=1}^m a_i y'{i} ) + a_0 y = b.
% It uses the second-order Adams-Bashforth-Moulton predictor-corrector method
% with the first step using the Heun's method.
% 
% Input:
% A      - cell array of handles to functions a_0, a_1, ..., a_m 
%          in the form {@a0, @a1, ..., @am}.
% B      - handle to function b in the form @b, accepting arguments:
%          x - the value of the independent variable,
%          y - vector of values of the dependent variable and its derivatives,
%          in the form: [y, y', y'', ..., y^{m-1}], where y^{(i)} is 
%          the i-th derivative of y.
% Y0     - vector of initial conditions, in the form 
%          [y(a), y'(a), ..., y^{m-1}(a)].
% Span   - integration range [a, b], where a < b. a and b are real numbers.
% N      - number of integration steps. N is a natural number.
% Corr_N - number of corrections, Corr_N is an integer >= 0.
% Output:
% x      - vector of integration points.
% y      - matrix, where each row is a vector of approximations of the values 
%          of the function y(x), y'(x), ..., y^{(m-1)}(x) at the integration points.
% Remarks:
% Functions a_0, a_1, ..., a_m and b must accept real values 
% on the interval 'Span'.

a = Span(1); b = Span(2); h = (b-a) / N; 
x = (a:h:b)'; y(1, :) = Y0; D = zeros(size(y));

tp = N;
corr_first = 0;
for i = 1:tp % Calculation of the first values using Heun's method
    D(2, :) = f(x, y(i, :), A, B);
    y(i+1, :) = heun_next_step(@f, D, x(i), y(i, :), A, B, h);
    if (i > 1)
        y(i+1, :) = M_corr_step(@f, D, x(i+1), y(i:i+1, :), A, B, h, corr_first);
    end
    D(1, :) = D(2, :);
end

for i = tp+1:N
    D(2, :) = f(x(i), y(i, :), A, B); % calculation of derivatives
    y(i+1, :) = AB2_next_step(@f, D, x(i), y(i, :), A, B, h);
    y(i+1, :) = M_corr_step(@f, D, x(i+1), y(i:i+1, :), A, B, h, Corr_N);
    D(1, :) = D(2, :); % storing previous values
end