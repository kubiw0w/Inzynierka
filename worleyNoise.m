function noise = worleyNoise(width, height, numCells)
    % worleyNoise - implementacja 2D Worley Noise (Cellular Noise)
    % width, height - rozmiar tekstury
    % numCells      - liczba komórek w jednej osi (im więcej tym drobniejszy wzór)
    
    % --- Losowe punkty w każdej komórce ---
    rng('shuffle');
    points = cell(numCells, numCells);
    for i = 1:numCells
        for j = 1:numCells
            % losowy punkt wewnątrz danej komórki
            px = (i-1 + rand()) * (width/numCells);
            py = (j-1 + rand()) * (height/numCells);
            points{i,j} = [px, py];
        end
    end
    
    % --- Siatka pikseli ---
    [xx, yy] = meshgrid(1:width, 1:height);
    
    % --- Liczenie odległości do najbliższego punktu ---
    noise = zeros(height, width);
    for y = 1:height
        for x = 1:width
            minDist = inf;
            
            % Znajdź najbliższy punkt (sprawdź tylko sąsiednie komórki)
            cellX = ceil(x / (width/numCells));
            cellY = ceil(y / (height/numCells));
            
            for i = cellX-1:cellX+1
                for j = cellY-1:cellY+1
                    if i>=1 && i<=numCells && j>=1 && j<=numCells
                        p = points{i,j};
                        d = sqrt((x - p(1))^2 + (y - p(2))^2);
                        if d < minDist
                            minDist = d;
                        end
                    end
                end
            end
            
            noise(y,x) = minDist;
        end
    end
    
    % --- Normalizacja do [0,1] ---
    noise = rescale(noise, 0, 1);
end
