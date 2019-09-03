function [Uip, Urb_plus, Urb_minus, Uop, x, y, L0, Lx2] = schlieren()

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
f_cyl = 62.5e-3;

%focal length of lenses 
f_1 = 100e-3;
f_2 = 100e-3;


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

%first lens
[Urb_minus, Lx1, Ly1] = lensPropDist(Uop, L0, L0,  X, Y, lambda, f_1, f_1);

%razor blade
[Urb_plus] = knifeEdge(Urb_minus, X/L0*Lx1, Y/L0*Ly1, 0);

%second lens
[Uip, Lx2, Ly2] = lensProp(Urb_plus, Lx1, Ly1, lambda, f_2);

end