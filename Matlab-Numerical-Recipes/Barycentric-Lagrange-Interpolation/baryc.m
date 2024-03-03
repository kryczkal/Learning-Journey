function weights = baryc(nodes)
    % Author: Łukasz Kryczka
    % Function to calculate weights for barycentric Lagrange interpolation
    
    weights = zeros(size(nodes));
    if iscolumn(nodes)
        nodes = nodes';
    end

    j = 0;
    for xj = nodes
        coefficient = 1;
        for xi = nodes
            if (xj == xi)
                continue
            end
            coefficient = coefficient * (xj - xi);
        end
        j = j + 1;
        weights(j) = 1 ./ coefficient;
    end
}
