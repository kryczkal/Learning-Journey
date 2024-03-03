function test_polynomial_degree_0()
pause
fprintf('Test dla wielomianu stopnia 0 - Start\n');

% Definiowanie przedziału i liczby podprzedziałów
a = 0; b = 2; c = -1; d = 1; n = 1; m = 1;
fprintf(['Testowanie dla przedziałów [%d, %d] i ' ...
         '[%d, %d] z liczbą podprzedziałów n = %d, m = %d.\n'], ...
         a, b, c, d, n, m);

% Wyświetlanie informacji o testowanym wielomianie
fprintf('f(x, y) = 1\n');

% Funkcja stała
f = @(x, y) 1;

% Dokładna wartość całki dla funkcji stałej
expected_value = 4;
fprintf('Oczekiwana wartość całki dla funkcji stałej: %.2f\n', ...
        expected_value);

% Przybliżona wartość całki obliczona przez funkcję
approx_value = P1Z30_LKR_CDIGL(f, a, b, c, d, n, m);
fprintf('Przybliżona wartość całki: %.2f\n', approx_value);

% Sprawdzenie, czy przybliżona wartość zgadza się z oczekiwaną
error = abs(approx_value - expected_value);
fprintf('Błąd bezwzględny: %.2e\n', error);

end
