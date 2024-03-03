function  steps = time_test_heun(A, B, Y0, Span, N, Corr_N, tp, corr_first, time_max)
a = Span(1); b = Span(2); h = (b-a) / N; 
x = (a:h:b)'; y(1, :) = Y0; D = zeros(size(y));

i = 1; time = 0;
while(time < time_max)
    tic;
    D(2, :) = f(x, y(i, :), A, B);
    y(i+1, :) = heun_next_step(@f, D, x(i), y(i, :), A, B, h);
    tmp_time = toc; time = time + tmp_time; i = i+1;
end
steps = i;
