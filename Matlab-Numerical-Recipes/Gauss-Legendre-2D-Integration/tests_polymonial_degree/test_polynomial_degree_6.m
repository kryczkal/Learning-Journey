function test_polynomial_degree_6()
pause
fprintf('Test dla wielomianu stopnia 6 - Start\n');

% Definiowanie przedziału i liczby podprzedziałów
a = -1; b = 1; c = -1; d = 1; n = 1; m = 1;
fprintf(['Testowanie dla przedziałów [%d, %d] i [%d, %d] z liczbą ' ...
         'podprzedziałów n = %d, m = %d.\n'], a, b, c, d, n, m);

% Funkcja szóstego stopnia
f = @(x, y) 1.2*x.^6 - y.^6 + 0.8*x.^5.*y;
fprintf('f(x, y) = 1.2*x.^6 - y.^6 + 0.8*x.^5.*y\n');

% Oczekiwana wartość całki
expected_value = 4/35;
fprintf('Oczekiwana wartość całki dla funkcji rzędu 6: %.2f\n', expected_value);
fprintf('Metoda oparta na 3 węzłach, więc błąd powinien być substancjalny\n')

% Przybliżona wartość całki obliczona przez funkcję
approx_value = P1Z30_LKR_CDIGL(f, a, b, c, d, n, m);
fprintf('Przybliżona wartość całki: %.2f\n', approx_value);

% Błąd bezwzględny
error = abs(approx_value - expected_value);
fprintf('Błąd bezwzględny: %.2e\n', error);

end
