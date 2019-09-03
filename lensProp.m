function[U2, Lx2, Ly2]=lensProp(U1, Lx1, Ly1, lambda, z);
    [N, M] = size(U1);
    dx = Lx1/M;
    dy = Ly1/N;
    Ly2 = lambda * z / dy;
    Lx2 = lambda * z / dx;
    const = 1/(1i*lambda*z);
    U2 = const * fftshift(fft2(ifftshift(U1))) * dx * dy;
end