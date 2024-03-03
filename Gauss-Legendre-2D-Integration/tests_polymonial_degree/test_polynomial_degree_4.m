function test_polynomial_degree_4()
pause
fprintf('Test dla wielomianu stopnia 4 - Start\n');

% Definiowanie przedziału i liczby podprzedziałów
a = -1; b = 1; c = -1; d = 1; n = 1; m = 1;
fprintf(['Testowanie dla przedziałów [%d, %d] i [%d, %d] z liczbą ' ...
         'podprzedziałów n = %d, m = %d.\n'], a, b, c, d, n, m);

% Funkcja czwartego stopnia
f = @(x, y) x.^4 - y.^4 + 0.5*x.^3.*y;
fprintf('f(x, y) = x.^4 - y.^4 + 0.5*x.^3.*y\n');

% Oczekiwana wartość całki
expected_value = 0;  % Tutaj wstaw oczekiwaną wartość
fprintf('Oczekiwana wartość całki dla funkcji rzędu 4: %.2f\n',...
    expected_value);

% Przybliżona wartość całki obliczona przez funkcję
approx_value = double_integral_gauss_legendre(f, a, b, c, d, n, m);
fprintf('Przybliżona wartość całki: %.2f\n', approx_value);

% Błąd bezwzględny
error = abs(approx_value - expected_value);
fprintf('Błąd bezwzględny: %.2e\n', error);

end
