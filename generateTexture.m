function generateTexture(app)
% generateTexture Generuje teksturę i wyświetla w UIAxes aplikacji
%
% Wejście:
%   app - uchwyt do aplikacji (App Designer)

    % Pobranie rozmiaru obrazu z pól tekstowych
    width  = app.SzerokoobrazuEditField.Value;
    height = app.WysokoobrazuEditField.Value;

    % Ograniczenie maksymalnego rozmiaru
    if width > 2048 || height > 2048
        uialert(app.UIFigure, 'Maksymalny rozmiar to 2048x2048!', 'Błąd rozmiaru');
        return;
    end

    tStart = tic; % start pomiaru czasu

    % Wybór algorytmu
    selectedAlg = app.AlgorytmDropDown.Value;
    switch selectedAlg
        case 'Perlin Noise + radialny gradient'
            tex = perlinNoiseRadial(width, height, 10);
        case 'Perlin Noise + sinusoidalna deformacja'
            tex = perlinNoiseSinDeform(width, height, 10, 5, 10);
        case 'Worley Noise'
            tex = worleyNoise(width, height, 10);
        case 'fBM (Fractal Brownian Motion)'
            tex = fBM(width, height, 6, 0.5, 2.0, 4);
        case 'Gaussian'
            tex = gaussianNoise(width, height, 0, 1);
        % case 'Fractal Plasma'
        %     tex = fractalPlasma(513, 0.7);
        case 'Checkerboard'
            tex = checkerboardTex(width, height, 8);
        case 'Voronoi Diagram'
            tex = voronoiTex(width, height, 50);
        otherwise
            tex = rand(height, width); % fallback
    end

    % Wyświetlenie tekstury
    imshow(tex, 'Parent', app.UIAxes);
    axis(app.UIAxes, 'image');
    app.UIAxes.XTick = [];
    app.UIAxes.YTick = [];

    % Czas w milisekundach
    elapsedMs = toc(tStart) * 1000;
    app.TimeLabel.Text = sprintf('%.1f ms', elapsedMs);

end
