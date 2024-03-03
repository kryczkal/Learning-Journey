function Y = ipbval(X, nodes, weights, values)
    % Author: Łukasz Kryczka
    % Function to calculate the value of the Lagrange interpolation polynomial
    % in barycentric form for the vector X
    
    gj = 0;
    gj_f_xj = 0;

    for j = 1:length(weights)
        gj = gj + weights(j) ./ (X-nodes(j));
        gj_f_xj = gj_f_xj + weights(j) * values(j) ./ (X-nodes(j));
    end
    Y = gj_f_xj ./ gj;

    % Replace X equal to a node with its original value
    for i = find(ismember(X, nodes))
        Y(i) = values(nodes == X(i));
    end
end