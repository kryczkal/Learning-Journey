function test_composite_nodes_basic()
pause
disp('Test: Basic functionality - Start');

% Defining the interval and number of subintervals
a = 0; b = 3; n = 3;
disp(['Testing for the interval [', num2str(a), ', ', num2str(b), ...
    '] with the number of subintervals n = ', num2str(n)]);

% Expected result calculated manually
expected_output = [1 1];
fprintf('Expected result:\n');
disp(expected_output);
fprintf('\n');

% Getting the actual result from the function
actual_output = get_composite_nodes(a, b, n);
fprintf('Actual result:\n');
disp(actual_output);
fprintf('\n');

% Checking if the actual result matches the expected result
% Tolerance is set to account for floating-point arithmetic errors
difference = abs(actual_output - expected_output);
fprintf('Difference: [');
fprintf(' %.2e ', difference);
fprintf(']\n');
fprintf('Test: Basic functionality - End\n');
end