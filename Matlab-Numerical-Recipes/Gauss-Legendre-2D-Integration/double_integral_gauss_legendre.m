function ival = double_integral_gauss_legendre(f, a, b, c, d, n, m)
% Author: Łukasz Kryczka
%
% Function approximating the value of a double integral of function f(x, y) 
% over a two-dimensional region D using Gauss-Legendre quadrature.
% 
% Input:
% f    - handle to the function f(x, y), taking real values and returning 
%        finite real values. Input values can be vectors.
% a, b - limits of integration for x, a < b, a and b are real numbers
% c, d - limits of integration for y, c < d, c and d are real numbers
% n, m - number of subintervals for [a, b] and [c, d], integers, > 0
%
% Output:
% ival - approximate value of the double integral of function f over region D
%
% Notes:
% Values a, b, c, d, n, m must be within the range of numerical representation,
% and the subintervals [a, b], [c, d] must be sufficient for Gauss-Legendre 
% quadrature; avoid using very small subintervals
% It is the user's responsibility to choose the correct task parameters, i.e. 
% such that the node selection on the subintervals is numerically correct

Coeffs=[5.5555555555555555556e-01;
        8.8888888888888888889e-01;
        5.5555555555555555556e-01]'; 
% Coefficients for 3-point Gauss-Legendre quadrature
% Calculated using the Golub-Welsh algorithm 

x = get_composite_nodes(a,b,n);
y = get_composite_nodes(c,d,m);
ival = 0;
for i = 1:3
    for j = 1:3
        ival = ival+Coeffs(i)*Coeffs(j)*sum(f(x(i,:),y(j,:)'),"all");
    end
end
ival = ival*((b-a)/n)/2*((d-c)/m)/2;
end