
function [x2 y2 Uout] = fresnelPropagation(Uin, x, y, wvl, Dz)
 

[N, M] = size(Uin);
Lx1 = x(end)*2;
Ly1 = y(end)*2;
dx = Lx1/M;
dy = Ly1/N;
Ly2 = wvl * Dz / dy;
Lx2 = wvl * Dz / dx;

% assume square grid
k = 2*pi/wvl;
% optical wavevector
% source-plane coordinates
[x1 y1] = meshgrid(x, y);
% observation-plane coordinates
[x2 y2] = meshgrid(x*Lx2/Lx1, y*Ly2/Ly1);

% evaluate the Fresnel-Kirchhoff integral
Uout = 1 / (1i*wvl*Dz) ...
    .* exp(1i * k/(2*Dz) * (x2.^2 + y2.^2)) ...
    .* ft2(Uin .* exp(1i * k/(2*Dz) ...
    * (x1.^2 + y1.^2)), sqrt(Lx1/M*Ly1/N));
