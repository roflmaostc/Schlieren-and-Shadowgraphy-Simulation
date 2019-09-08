function [Uout] = fuzzyColumn(U, X, Y, r, n1, n2, lambda)

%n1 is of vapor
%n2 of plasma

kVapor = 2*pi/lambda*n1;
kPlasma = 2*pi/lambda*n2;
ro = r;
ri = 0.7*r;

m = (kVapor-kPlasma)/(ro-ri);
t = kPlasma - m*ri;
p = @(x,y) t*x + 0.5*m*x*sqrt(x^2+y^2)+0.5*m*y^2*log(x+sqrt(x^2+y^2));


Uout = U;
%this function calculates the phase shift due to a fuzzy column
for i = 1:size(U,1)        
    
    if abs(Y(i, 1)) >= r 
        Uout(i, :) = U(i,:) .* exp(1i*kVapor*2*r);
    
    elseif abs(Y(i,1)) >= ri
        y = abs(Y(i, 1));
        xa = sqrt(ro^2-y^2);
        xe = 0;
        
        d1 = sqrt(ro^2-Y(i, 1)^2);
        d2 = sqrt(ri^2-Y(i, 1)^2);
        deltap = p(xa,y)-p(xe,y);

        Uout(i, :) = U(i, :) .* exp(1i*(deltap*2 + kVapor*(2*r-2*d1)));
    else
        y = abs(Y(i, 1));
        xa = sqrt(ro^2-y^2);
        xe = sqrt(ri^2-y^2);
        
        if y ~= 0
            deltap = p(xa,y)-p(xe,y);
        else 
            %logarithm fail for 0^2*log(0)
            deltap = p(xa,1e-15)-p(xe,1e-15);
        end
        
        d1 = sqrt(ro^2-Y(i, 1)^2);
        d2 = sqrt(ri^2-Y(i, 1)^2);

        Uout(i, :) = U(i, :) .* exp(1i*(2*deltap + 2*d2*kPlasma + kVapor*(2*ro-2*d1)));
    end
end
