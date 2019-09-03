function [Uout] = plasmaColumn(U, X, Y, r, n1, n2, lambda)

%n1 is of vapor
%n2 of plasma

kVapor = 2*pi/lambda*n1;
kPlasma = 2*pi/lambda*n2;

Uout = U;
%this function calculates the phase shift due to a column
parfor i = 1:size(U,1)        
        
    if abs(Y(i, 1)) >= r 
        Uout(i, :) = U(i,:) .* exp(1i*kVapor*2*r);
    else
        d = 2*sqrt(r^2-Y(i, 1)^2);
        Uout(i, :) = U(i, :) .* exp(1i*(kPlasma*d + kVapor*(2*r-d)));
    end
end

