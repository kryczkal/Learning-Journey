function corr_step = M_corr_step(f, D, x, y, A, B, h, Corr_N)
% x = x(i+1), y = y(i:i+1, :)
corr_step = y(2, :);
for c = 1:Corr_N % Applying correction Corr_N times
        DD = f(x, y(2, :), A, B);
        corr_step = y(1, :) + (h/2)*(DD + D(2, :));
end
