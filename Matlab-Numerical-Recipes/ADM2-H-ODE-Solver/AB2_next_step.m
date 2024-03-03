function next_step = AB2_next_step(f, D, x, y, A, B, h)
next_step = y(1, :) + (h/2)*(3*D(2,:) - 1*D(1, :)); // prediction
