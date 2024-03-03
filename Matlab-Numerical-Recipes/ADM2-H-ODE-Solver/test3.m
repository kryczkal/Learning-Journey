clearvars;
k = -1; % Stała dla testowego równania różniczkowego
y0 = 1; % Warunek początkowy
t_end = 1; % Czas końcowy całkowania
exact_solution = @(t) y0 * exp(k * t); % Dokładne rozwiązanie funkcji
disp('Test wpływu wykonania większej ilości korekt, na rząd metody')
disp('Testowanie na równaniu różniczkowym: y'' = k*y');
disp(['Stała k: ', num2str(k)]);

len = 8;
i = 1:len;
divisors = 2*ones(1,len); 
divisors = divisors.^i;
init_step = 1;
hs = ones.*init_step./divisors; 

errors = zeros(size(hs)); % Inicjalizacja tablicy błędów
error_ratios = zeros(size(hs)-1); % Inicjalizacja tablicy stosunków błędów

for i = 1:length(hs)
    h = hs(i);
    Span = [0, t_end]; % Zakres całkowania
    N = t_end / h; % Liczba kroków
    A = {@(x) -k, @(x) 1};
    B = @(x, y) 0;
    Y0 = [y0];
    Corr_N = 10; % Liczba korekcji
    [x, y] = ABM2_H(A, B, Y0, Span, N, Corr_N);
    
    numerical_solution = y(end, 1); % Rozwiązanie numeryczne
    exact_val = exact_solution(t_end); % Rozwiązanie dokładne
    errors(i) = abs(numerical_solution - exact_val); % Obliczanie błędu
end

% Obliczanie stosunków błędów
for i = 2:length(hs)
    error_ratios(i-1) = errors(i-1) / errors(i);
end

% Tworzenie tabeli
% Wyświetlanie informacji o korekcji
disp(['Liczba kroków korekcyjnych: ', num2str(Corr_N)]);


T = array2table([divisors', hs', errors', [nan; error_ratios']], 'VariableNames', {'Dzielnik kroku całkowania','Krok całkowania', 'Błąd', 'Stosunek błędów'});
disp(T);

clearvars;
omega = 1.35*pi; % Częstotliwość oscylacji
y0 = 1; % Warunek początkowy y(0) = 1
dy0 = 0; % Warunek początkowy y'(0) = 0
t_end = 2; % Czas końcowy całkowania
exact_solution = @(t) cos(omega * t); % Dokładne rozwiązanie
disp("Testowanie na równaniu różniczkowym: y'' + omega^2*y = 0");
disp(['Częstotliwość omega: ', num2str(omega)]);

len = 8;
divisors = 2.^((1:len));
init_step = 0.1; 
hs = ones.*init_step./divisors; 

errors = zeros(size(hs)); % Inicjalizacja tablicy błędów
error_ratios = zeros(size(hs)-1); % Inicjalizacja tablicy stosunków błędów

for i = 1:length(hs)
    h = hs(i);
    Span = [0, t_end]; % Zakres całkowania
    N = t_end / h; % Liczba kroków
    A = {@(x) omega^2, @(x) 0, @(x) 1};
    B = @(x, y) 0;
    Y0 = [y0, dy0];
    Corr_N = 10; % Liczba korekcji
    [x, y] = ABM2_H(A, B, Y0, Span, N, Corr_N);
    
    numerical_solution = y(end, 1); % Rozwiązanie numeryczne
    exact_val = exact_solution(t_end); % Rozwiązanie dokładne
    errors(i) = abs(numerical_solution - exact_val); % Obliczanie błędu
end

% Obliczanie stosunków błędów
for i = 2:length(hs)
    error_ratios(i-1) = errors(i-1) / errors(i);
end

% Wyświetlanie informacji o korekcji
disp(['Liczba kroków korekcyjnych: ', num2str(Corr_N)]);

T = array2table([divisors', hs', errors', [nan; error_ratios']], 'VariableNames', {'Dzielnik kroku całkowania','Krok całkowania', 'Błąd', 'Stosunek błędów'});
disp(T);