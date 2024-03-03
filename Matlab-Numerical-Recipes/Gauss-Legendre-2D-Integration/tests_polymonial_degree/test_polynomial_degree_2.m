function test_polynomial_degree_2()
pause
fprintf('Test for polynomial of degree 2 - Start\n');

% Defining the interval and number of subintervals
a = -1; b = 1; c = -2; d = 0; n = 1; m = 1;
fprintf(['Testing for intervals [%d, %d] and [%d, %d] ' ...
         'with number of subintervals n = %d, m = %d.\n'], ...
         a, b, c, d, n, m);

% Quadratic function
A = 2; B = -3; C = 5;
fprintf('f(x, y) = %dx^2 + %dy^2 + %dxy\n', ...
        A, B, C);
f = @(x, y) A*x.^2 + B*y.^2 + C*x.*y;

% Exact integral value for the quadratic function
expected_value = -40/3;
fprintf('Expected integral value for the quadratic function: %.2f\n', ...
        expected_value);

% Approximate integral value computed by the function
approx_value = double_integral_gauss_legendre(f, a, b, c, d, n, m);
fprintf('Approximate integral value: %.2f\n', approx_value);

% Absolute error
error = abs(approx_value - expected_value);
fprintf('Absolute error: %.2e\n', error);
end
