function tex = voronoiTex(width, height, numPoints)
    % voronoiTexture - generowanie tekstury Voronoi
    % width, height - rozmiar obrazu
    % numPoints     - liczba losowych punktów (komórek)

    % losowe punkty (feature points)
    rng('shuffle');
    pointsX = randi([1 width], 1, numPoints);
    pointsY = randi([1 height], 1, numPoints);

    % siatka pikseli
    [xx, yy] = meshgrid(1:width, 1:height);

    tex = zeros(height, width);

    % dla każdego piksela znajdź najbliższy punkt
    for i = 1:numPoints
        dist = sqrt((xx - pointsX(i)).^2 + (yy - pointsY(i)).^2);
        if i == 1
            minDist = dist;
            tex(:,:) = i;
        else
            mask = dist < minDist;
            tex(mask) = i;
            minDist(mask) = dist(mask);
        end
    end

    % normalizacja etykiet do [0,1]
    tex = rescale(tex, 0, 1);
end
