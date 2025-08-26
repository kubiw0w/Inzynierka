function tex = gaussianNoise(width, height, meanVal, sigma)
    % gaussianNoise - generowanie 2D Gaussian Noise
    % width, height - rozmiar tekstury
    % meanVal       - wartość średnia rozkładu
    % sigma         - odchylenie standardowe

    % losowy szum Gaussa
    tex = meanVal + sigma * randn(height, width);

    % normalizacja do [0,1] żeby nadawało się do wyświetlenia
    tex = rescale(tex, 0, 1);
end
