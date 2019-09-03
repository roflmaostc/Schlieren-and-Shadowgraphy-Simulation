function[U2, Lx2, Ly2]=lensPropDist(U1, Lx1, Ly1, x, y, lambda, f, d);
    [N, M] = size(U1);
    dx = Lx1/M;
    dy = Ly1/N;
    Ly2 = lambda * f / dy
    Lx2 = lambda * f / dx
    k = 2*pi/lambda;
    const = 1/(1i*lambda*f);

    U2 = exp(1i.*k./2./f.*(1-d/f) .* ( (x).^2 + (y).^2 )) .* const ... 
        .* fftshift(fft2(ifftshift(U1))) .* dx .* dy;
end
