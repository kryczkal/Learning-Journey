function test_error()
pause
fprintf('Test for a polynomial of degree 6 - Start\n');

% Defining the interval and number of subintervals
a = -1; b = 1; c = -1; d = 1; n = 1; m = 1;
fprintf(['Testing for intervals [%d, %d] and [%d, %d] with number ' ...
         'of subintervals n = %d, m = %d.\n'], a, b, c, d, n, m);

% Sixth degree function
f = @(x, y) 1.2*x.^6 - y.^6 + 0.8*x.^5.*y;
fprintf('f(x, y) = 1.2*x.^6 - y.^6 + 0.8*x.^5.*y\n');

% Expected integral value
expected_value = 4/35;
fprintf('Expected integral value for a degree 6 function: %.2f\n', expected_value);
fprintf('Method based on 3 nodes, so the error should be substantial\n')

% (d-c)d1 + (b-a)d2 (c1 + d2) / m^6
% (d-c)d1 + (b-a)d2 (c1 + d2) / 2^6
% d1 = c1/m^2n
% d2 = d1/n^2n
% Approximate integral value calculated by the function
approx_value = double_integral_gauss_legendre(f, a, b, c, d, n, m);
fprintf('Approximate integral value: %.2f\n', approx_value);
% Absolute error
error = abs(approx_value - expected_value);
error_old = error;
fprintf('Absolute error: %.2e\n', error);
n = 2; m = 2;
approx_value = P1Z30_LKR_CDIGL(f, a, b, c, d, n, m);
fprintf('Approximate integral value: %.2f\n', approx_value);

% Absolute error
error = abs(approx_value - expected_value);
fprintf('Absolute error: %.2e\n', error);

fprintf('is it equal %d %d\n', error, error_old/(2^6))
