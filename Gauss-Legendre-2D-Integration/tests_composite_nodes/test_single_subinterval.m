function test_single_subinterval()
pause
fprintf('Test: Extreme case with a single subinterval - Start\n');
% Defining the interval and setting the number of subintervals to 1
a = -1; b = 1; n = 1;
fprintf('Testing for the interval [%d, %d] with a single subinterval.\n', a, b);

% Expected output
expected_output = [-7.7459666924148337704e-01;
    0.0000000000000000000e+00;
    7.7459666924148337704e-01];
fprintf('The expected output is the standard Gauss-Legendre nodes:\n');
fprintf('[%.4f; %.4f; %.4f]\n', expected_output);

% Getting the actual output from the function
actual_output = get_composite_nodes(a, b, n);
fprintf('The actual output is:\n');
fprintf('[%.4f; %.4f; %.4f]\n', actual_output);

% Checking if the actual output matches the expected output
assert(all(abs(actual_output - expected_output) < 1e-10));

fprintf('Test: Extreme case with a single subinterval - End\n');
end