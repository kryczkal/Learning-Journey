function composite_nodes = get_composite_nodes(a, b, n)
% get_composite_nodes calculates the vector of scaled nodes for a 3-point
% Gauss-Legendre composite quadrature on the interval [a, b]
%
% Input:
% a, b - integration limits, where a < b, a and b are real numbers
% n    - number of subintervals to divide the interval [a, b] into,
%        a natural number
%
% Output:
% composite_nodes - matrix of Gauss-Legendre quadrature nodes
% Each column contains the coefficients for the corresponding subinterval
%
% Description:
% The get_composite_nodes function scales and shifts the standard quadrature
% nodes for each of the n equal subintervals of the interval [a, b].
% It uses the standard nodes of a 3-point Gauss-Legendre quadrature,
% scales them to the size of each subinterval,
% and then shifts them to the appropriate location.

single_nodes=[-7.7459666924148337704e-01;
               0.0000000000000000000e+00;
               7.7459666924148337704e-01];
interval = (b-a)/(n);
% Create a base vector for scaling and shifting
base = (a+interval/2):interval:b;
% Replicate single_nodes to match the length of base
nodes_replicated = repmat(single_nodes,1,length(base));
% Scale and shift single_nodes
composite_nodes = (interval/2)*nodes_replicated+base;
end