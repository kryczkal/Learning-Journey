% Test 3: Large number of sub-intervals
function test_large_number_of_sub_intervals()
pause
fprintf('Test: Large number of sub-intervals - Start\n');

% Defining the interval and setting a large number of sub-intervals
a = 0; b = 1; n = 1000;
fprintf('Testing for the interval [%d, %d] with number of sub-intervals n = %d.\n', a, b, n);

% Getting the result from the function
actual_output = get_composite_nodes(a, b, n);
fprintf('Checking the size of the output:\n');

% Checking if the function returns the result of the correct size
expected_size = [3, n];
actual_size = size(actual_output);
fprintf('Expected size: [%d %d]\n', expected_size);
fprintf('Actual size: [%d %d]\n', actual_size);

assert(all(actual_size == expected_size));

fprintf('Checking the range of node values:\n');
fprintf('(Should not exceed the range [%d %d])\n', a, b);
fprintf('Evaluating nnz(actual_output(:, :) >= a & actual_output(:, :) <= b\n')
fprintf("Expected value \n")
disp(3000)
fprintf("Actual value\n")
disp(nnz(actual_output(:, :) >= a & actual_output(:, :) <= b))

fprintf('Test: Large number of sub-intervals - End\n');
end