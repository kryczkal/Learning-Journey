function [Q, err, num_rows, bottom_row] = smartRM(g, a, b, tol, M0, Kmin, Kmax)
    % Author: Łukasz Kryczka
    % Function to calculate the integral of function g, on the interval a,b, with error tolerance tol,
    % using an adaptive approach with M0 intervals, with a minimum of Kmin extrapolation steps
    % and a maximum of Kmax extrapolation steps.

    H = (b-a)/(M0+1); % calculate composite trapezoidal integral for M0+1 intervals
    top_row = H*(sum(g(a+H:H:b-H))+(g(a)+g(b))/2);

    err = tol+1; % initialize the initial error value
    num_rows = 2; % start extrapolation from the 2nd row
    while (err > tol || num_rows-1 <= Kmin) && num_rows-1 < Kmax+1
        % calculate the first values of the new row T(i,0)
        bottom_row = zeros(1,num_rows);    
        H = (b-a)/((M0+1)*2^(num_rows-1)); 
        bottom_row(1) = H*(sum(g(a+H:H:b-H))+(g(a)+g(b))/2);
        
        % extrapolate the next values T(i,k)
        for k = 2:num_rows 
            bottom_row(k) = (4^(k-1)*bottom_row(k-1) ...
                -top_row(k-1))/(4^(k-1)-1);  
        end
        % calculate the error and update the algorithm values
        err = my_error(top_row(end),bottom_row(end));
        top_row = bottom_row;
        num_rows = 1 + num_rows;
    end
    Q = bottom_row(end); % the most accurate value is the last one in the row
    num_rows = num_rows-2; % the number of extrapolations is num_rows-2
