function[Uout] = cylindricalLens(U, X, Y, k, f, r)
    cylinder = @(x,y,r) (y.^2. < r ^ 2 ) * 1.0;
    Uout = U .* exp( - 1i * k / 2 / f * Y.^2) .* cylinder(X, Y, r) + U.* (1-cylinder(X, Y, r));
end

