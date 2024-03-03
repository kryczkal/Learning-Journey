function test_polynomial_degree_3()
pause
fprintf('Test for polynomial of degree 3 - Start\n');

% Defining the interval and number of subintervals
a = -1; b = 1; c = -1; d = 1; n = 1; m = 1;
fprintf(['Testing for intervals [%d, %d] and [%d, %d] with number ' ...
         'of subintervals n = %d, m = %d.\n'], a, b, c, d, n, m);

% Third degree polynomial function
A = 2; B = 3; C = -1;
fprintf('f(x, y) = %dx^3 + %dy^3 + %dx^2y\n', A, B, C);
f = @(x, y) A*x.^3 + B*y.^3 + C*x.^2.*y;

% Expected integral value
expected_value = 0;
fprintf('Expected integral value for degree 3 function: %.2f\n',...
    expected_value);

% Approximate integral value computed by the function
approx_value = double_integral_gauss_legendre(f, a, b, c, d, n, m);
fprintf('Approximate integral value: %.2f\n', approx_value);

% Absolute error
error = abs(approx_value - expected_value);
fprintf('Absolute error: %.2e\n', error);

end
