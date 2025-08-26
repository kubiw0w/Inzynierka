function noise = fBM(width, height, octaves, persistence, lacunarity, baseFrequency)
    % fBM - Fractal Brownian Motion z bazowym szumem Perlina
    % width, height   - rozmiar tekstury
    % octaves         - liczba oktaw
    % persistence     - zanikanie amplitudy (np. 0.5)
    % lacunarity      - wzrost częstotliwości (np. 2.0)
    % baseFrequency   - początkowa częstotliwość (np. 4)

    % --- Inicjalizacja ---
    noise = zeros(height, width);
    maxAmp = 0;
    amplitude = 1.0;
    frequency = baseFrequency;

    % --- pętla po oktawach ---
    for o = 1:octaves
        layer = perlinNoise2D(width, height, frequency);
        noise = noise + layer * amplitude;

        maxAmp = maxAmp + amplitude;
        amplitude = amplitude * persistence;   % zmniejszamy amplitudę
        frequency = frequency * lacunarity;    % zwiększamy częstotliwość
    end

    % --- normalizacja do [0,1] ---
    noise = noise / maxAmp;
    noise = rescale(noise, 0, 1);
end