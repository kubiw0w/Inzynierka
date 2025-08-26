function noise = perlinNoise2D(width, height, frequency)
    % perlinNoise2D - czysty szum Perlina 2D (bez deformacji)
    gradSize = frequency + 2;
    rng('shuffle');
    gradients = 2*rand(gradSize, gradSize, 2) - 1;
    gradients = gradients ./ sqrt(sum(gradients.^2,3)); % normalizacja wektorów

    [xx, yy] = meshgrid(1:width, 1:height);
    x = xx/width * frequency;
    y = yy/height * frequency;

    xi = floor(x) + 1;
    yi = floor(y) + 1;
    xf = x - floor(x);
    yf = y - floor(y);

    % indeksy narożników
    ind00 = sub2ind([gradSize gradSize], yi, xi);
    ind10 = sub2ind([gradSize gradSize], yi, xi+1);
    ind01 = sub2ind([gradSize gradSize], yi+1, xi);
    ind11 = sub2ind([gradSize gradSize], yi+1, xi+1);

    % gradienty narożników
    g00 = gradients(:,:,1); gx00 = g00(ind00);
    g00 = gradients(:,:,2); gy00 = g00(ind00);

    g10 = gradients(:,:,1); gx10 = g10(ind10);
    g10 = gradients(:,:,2); gy10 = g10(ind10);

    g01 = gradients(:,:,1); gx01 = g01(ind01);
    g01 = gradients(:,:,2); gy01 = g01(ind01);

    g11 = gradients(:,:,1); gx11 = g11(ind11);
    g11 = gradients(:,:,2); gy11 = g11(ind11);

    % iloczyny skalarne
    d00 = gx00.*xf     + gy00.*yf;
    d10 = gx10.*(xf-1) + gy10.*yf;
    d01 = gx01.*xf     + gy01.*(yf-1);
    d11 = gx11.*(xf-1) + gy11.*(yf-1);

    % fade
    u = xf.^3 .* (xf .* (xf*6 - 15) + 10);
    v = yf.^3 .* (yf .* (yf*6 - 15) + 10);

    nx0 = d00.*(1-u) + d10.*u;
    nx1 = d01.*(1-u) + d11.*u;
    noise = nx0.*(1-v) + nx1.*v;

    % normalizacja do [0,1]
    noise = rescale(noise, 0, 1);
end
