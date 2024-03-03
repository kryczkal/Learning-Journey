function next_step = heun_next_step(f, D, x, y, A, B, h)
k1 = D(2, :);
k2 = f(x + h, y(1, :) + h * k1, A, B);
next_step = y(1, :) + (h/2) * (k1 + k2);
end