function [Uout] = glasCapillary(U, X, Y, r1, r2, n, lambda)

kg = 2*pi/lambda*n;
kair = 2*pi/lambda;

Uout = U;
%this function calculates the phase shift due to a glas tube
for i = 1:size(U,1)        
        
    d1 = sqrt(r1^2-Y(i, 1)^2);
    d2 = sqrt(r2^2-Y(i, 1)^2);
    dz = d1-d2;
    if abs(Y(i, 1)) >= r1 
        Uout(i, :) = U(i,:) .* exp(1i*kair*2*r1);
    elseif abs(Y(i, 1)) >= r2
        Uout(i, :) = U(i, :) .* exp(1i*(kg*d1*2 + 2*kair*(r1-d1)));
    else
        Uout(i, :) = U(i, :) .* exp(1i*(kg*dz*2 + 2*kair*(r1-dz)));
    end
end

