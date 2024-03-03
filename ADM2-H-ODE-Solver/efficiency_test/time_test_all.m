function time_test_all(A, B, Y0, Span, N, tmax)
disp("new test")
Corr_N = 0; tp = 0;
heun_steps = time_test_heun_no_corr(A,B,Y0,Span,N,Corr_N, tp, 0, tmax);
heun_steps_corr = time_test_heun_corr(A, B, Y0, Span, N, Corr_N, tp, 1, tmax);
ab_steps = time_test_ab(A, B, Y0, Span, N, Corr_N, tp, 0, tmax);
abm_steps = time_test_abm(A, B, Y0, Span, N, Corr_N, tp, 0, tmax);
disp("no corr")
disp(heun_steps)
disp(ab_steps)

disp("with corr")
disp(heun_steps_corr)
disp(abm_steps)