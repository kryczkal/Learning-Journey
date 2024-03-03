function test_polynomial_degree_1()
pause
fprintf('Test dla wielomianu stopnia 1 - Start\n');

% Definiowanie przedziału i liczby podprzedziałów
a = -1; b = 1; c = 0; d = 2; n = 1; m = 1;
fprintf(['Testowanie dla przedziałów [%d, %d] i [%d, %d] ' ...
         'z liczbą podprzedziałów n = %d, m = %d.\n'], ...
         a, b, c, d, n, m);

% Funkcja liniowa
A = 1; B = 2; C = 3;
fprintf('f(x, y) = %dx + %dy + %d\n', A, B, C);
f = @(x, y) A*x + B*y + C;

% Dokładna wartość całki dla funkcji liniowej
expected_value = 20;
fprintf('Oczekiwana wartość całki dla funkcji liniowej: %.2f\n', ...
        expected_value);

% Przybliżona wartość całki obliczona przez funkcję
approx_value = P1Z30_LKR_CDIGL(f, a, b, c, d, n, m);
fprintf('Przybliżona wartość całki: %.2f\n', approx_value);

% Błąd bezwzględny
error = abs(approx_value - expected_value);
fprintf('Błąd bezwzględny: %.2e\n', error);

end
