function [Ufp, Uop, x2, y2, x, y] = shadowgraphy()

%propagation distance of fresnel
d = 625e-3;


%plasma column target
r_plasma = 0.75e-3;
n_vapor = 1 + 4*10^(-3);
n_plasma = 1;

%glas capillary
r_in = 0.744e-3;
r_out = 0.75e-3;
n_glass = 1.473;

%cylindrical lens
diameter = 1.5e-3;
f_cyl = 625e-3;


%field size and sampling
L0 = 10e-3;
Nx = 1024+1;
Ny = 60001;

x = L0 * linspace(-1,1,Nx);
y = L0 * linspace(-1,1,Ny);
[X,Y] = meshgrid(x,y);


%HeNe Laser
sigma_r = 2e-3;
lambda = 632.8e-9;
k0 = 2*pi/lambda;

%Gaussian function with a=I0, b=x-scale, c=y-scale, d=standard deviation
f_gauss2D = @(a,b,c,d) (a .* exp(-((b.^2+c.^2)/(d).^2))); 
U0 = f_gauss2D(1, X, Y, sigma_r);%.* exp(i*dphi);


%different targets
Uop = glassCapillary(U0, X, Y, r_out, r_in, n_glass, lambda);
%Uop = plasmaColumn(U0, X, Y, r_plasma, n_vapor, n_plasma, lambda);
%Uop = cylindricalLens(U0, X, Y, k0, f_cyl, diameter/2);


[x2 y2 Ufp] = fresnelPropagation(Uop, x, y, lambda, d);
x2 = x2(1,:);
y2 = y2(:,1);

end
