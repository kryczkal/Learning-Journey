function y = romberg(g, a, b, M)
    y = zeros(1,M+1)';
    y(1) = ( g(a) + g(b) ) * (b-a)/2;
    for i = 2:M+1
        H = (b-a)/2^(i-2);
        y(i) = ( y(i-1) + sum(g(a+H/2:H:b))*H ) / 2;
    end
    for k = 2:M+1
        for i = M+1:-1:k
            y(i) = ( 4^(k-1) * y(i) - y(i-1) ) ...
                 / ( 4^(k-1) - 1 );
        end
    end
    y = y(end);
end