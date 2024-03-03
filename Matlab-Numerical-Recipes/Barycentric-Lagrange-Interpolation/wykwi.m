function wykwi(g,a,b,n)
    % Author: Łukasz Kryczka
    % Function generating plots for the function indicator g, on the interval
    % from a to b, for n+1 nodes.

    % Generating Chebyshev nodes on the interval from a to b
    i = 0:n;
    nodes = (a + b) / 2 - ( (b-a)/2 ) .* cos( (2 .* i + 1)...
        .* pi ./ (2 * n + 2) );
    X = linspace(a,b,2000000);

    % Plotting the function
    plot(X, g(X), color="b")
    hold on
    % Plotting the interpolation of the function
    plot(X, ipbval(X, nodes, baryc(nodes), g(nodes) ), color="r");
    % Nodes marked in green
    scatter(nodes, g(nodes), 'filled', 'green')
    hold off
end