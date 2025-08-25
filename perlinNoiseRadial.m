function noise = perlinNoiseRadial(width, height, frequency)
    % Wektoryzowana wersja Perlin Noise + radialny gradient
    
    % Gradienty na małej siatce
    gradSize = frequency + 2;
    rng('shuffle');
    gradients = 2*rand(gradSize, gradSize, 2) - 1;
    gradients = gradients ./ sqrt(sum(gradients.^2,3));
    
    % Siatka współrzędnych
    [xx, yy] = meshgrid(1:width, 1:height);
    x = xx/width * frequency;
    y = yy/height * frequency;
    
    xi = floor(x) + 1;
    yi = floor(y) + 1;
    xf = x - floor(x);
    yf = y - floor(y);

    % Indeksy narożników
    ind00 = sub2ind([gradSize gradSize], yi, xi);
    ind10 = sub2ind([gradSize gradSize], yi, xi+1);
    ind01 = sub2ind([gradSize gradSize], yi+1, xi);
    ind11 = sub2ind([gradSize gradSize], yi+1, xi+1);

    % Pobieranie gradientów (x i y osobno, ale spójnie)
    g00x = gradients(:,:,1); g00x = g00x(ind00);
    g00y = gradients(:,:,2); g00y = g00y(ind00);

    g10x = gradients(:,:,1); g10x = g10x(ind10);
    g10y = gradients(:,:,2); g10y = g10y(ind10);

    g01x = gradients(:,:,1); g01x = g01x(ind01);
    g01y = gradients(:,:,2); g01y = g01y(ind01);

    g11x = gradients(:,:,1); g11x = g11x(ind11);
    g11y = gradients(:,:,2); g11y = g11y(ind11);

    % Iloczyny skalarne
    d00 = g00x.*xf     + g00y.*yf;
    d10 = g10x.*(xf-1) + g10y.*yf;
    d01 = g01x.*xf     + g01y.*(yf-1);
    d11 = g11x.*(xf-1) + g11y.*(yf-1);

    % Fade (interpolacja)
    u = xf.^3 .* (xf .* (xf*6 - 15) + 10);
    v = yf.^3 .* (yf .* (yf*6 - 15) + 10);
    
    nx0 = d00.*(1-u) + d10.*u;
    nx1 = d01.*(1-u) + d11.*u;
    nxy = nx0.*(1-v) + nx1.*v;

    % Radialny gradient
    cx = width/2; cy = height/2;
    r = sqrt((xx-cx).^2 + (yy-cy).^2);
    r = r / max(r(:));

    % Wynik
    noise = rescale(nxy .* r, 0, 1);
end