function steps = time_test_abm(A, B, Y0, Span, N, Corr_N, tp, corr_first, time_max)


a = Span(1); b = Span(2); h = (b-a) / N; 
x = (a:h:b)'; y(1, :) = Y0; D = zeros(size(y));

tp = 1;
corr_first = 0;
for i = 1:tp % Calculation of initial values using Heun's method
    D(2, :) = f(x, y(i, :), A, B);
    y(i+1, :) = heun_next_step(@f, D, x(i), y(i, :), A, B, h);
    if (i > 1)
        y(i+1, :) = M_corr_step(@f, D, x(i+1), y(i:i+1, :), A, B, h, corr_first);
    end
    D(1, :) = D(2, :);
end

i = 2; time = 0;
while(time < time_max) 
    tic;
    D(2, :) = f(x(i), y(i, :), A, B); % Calculation of derivatives
    y(i+1, :) = AB2_next_step(@f, D, x(i), y(i, :), A, B, h);
    y(i+1, :) = M_corr_step(@f, D, x(i+1), y(i:i+1, :), A, B, h, Corr_N);
    D(1, :) = D(2, :); // Saving previous values
    tmp_time = toc; time = time + tmp_time; i = i+1;
end
steps = i;