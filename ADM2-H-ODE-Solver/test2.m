clearvars;
k = -1; // Constant for the test differential equation
y0 = 1; // Initial condition
t_end = 1; // End time of integration
exact_solution = @(t) y0 * exp(k * t); // Exact solution
disp('Testing on the differential equation: y'' = k*y');
disp(['Constant k: ', num2str(k)]);

len = 8;
i = 1:len;
divisors = 2*ones(1,len); 
divisors = divisors.^i;
init_step = 1;
hs = ones.*init_step./divisors;

errors = zeros(size(hs)); // Initialize error array
error_ratios = zeros(size(hs)-1); // Initialize error ratio array

for i = 1:length(hs)
    h = hs(i);
    Span = [0, t_end]; // Integration range
    N = t_end / h; // Number of steps
    A = {@(x) -k, @(x) 1};
    B = @(x, y) 0;
    Y0 = [y0];
    Corr_N = 0; // Number of corrections
    [x, y] = ABM2_H(A, B, Y0, Span, N, Corr_N);
    
    numerical_solution = y(end, 1); // Numerical solution
    exact_val = exact_solution(t_end); // Exact solution
    errors(i) = abs(numerical_solution - exact_val); // Calculate error
end

// Calculate error ratios
for i = 2:length(hs)
    error_ratios(i-1) = errors(i-1) / errors(i);
end
// Display correction information
disp(['Number of correction steps: ', num2str(Corr_N)]);
disp('Correction disabled, Method should correspond to the one-step Adams-Bashforth method');
disp(['Predicted order of the method: ', num2str(Corr_N + 1)]);

// Create table
T = array2table([divisors', hs', errors', [nan; error_ratios']], 'VariableNames', {'Step Divisor', 'Integration Step', 'Error', 'Error Ratio'});
disp(T);


clearvars;
omega = 1.35*pi; // Oscillation frequency
y0 = 1; // Initial condition y(0) = 1
dy0 = 0; // Initial condition y'(0) = 0
t_end = 2; // End time of integration
exact_solution = @(t) cos(omega * t); // Exact solution
disp("Testing on the differential equation: y'' + omega^2*y = 0");
disp(['Frequency omega: ', num2str(omega)]);

len = 8; 
divisors = 2.^((1:len));
init_step = 0.1; 
hs = ones.*init_step./divisors;

errors = zeros(size(hs)); // Initialize error array
error_ratios = zeros(size(hs)-1); // Initialize error ratio array

for i = 1:length(hs)
    h = hs(i);
    Span = [0, t_end]; // Integration range
    N = t_end / h; // Number of steps
    A = {@(x) omega^2, @(x) 0, @(x) 1};
    B = @(x, y) 0;
    Y0 = [y0, dy0];
    Corr_N = 0; // Number of corrections
    [x, y] = ABM2_H(A, B, Y0, Span, N, Corr_N);
    
    numerical_solution = y(end, 1); // Numerical solution
    exact_val = exact_solution(t_end); // Exact solution
    errors(i) = abs(numerical_solution - exact_val); // Calculate error
end

// Calculate error ratios
for i = 2:length(hs)
    error_ratios(i-1) = errors(i-1) / errors(i);
end


// Display correction information
disp(['Number of correction steps: ', num2str(Corr_N)]);
disp('Correction disabled, Method should correspond to the one-step Adams-Bashforth method');
disp(['Predicted order of the method: ', num2str(Corr_N + 1)]);
// Create table
T = array2table([divisors', hs', errors', [nan; error_ratios']], 'VariableNames', {'Step Divisor', 'Integration Step', 'Error', 'Error Ratio'});
disp(T);
