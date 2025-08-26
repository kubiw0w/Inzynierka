function tex = checkerboardTex(width, height, freq)
    % checkerboardTex - generowanie szachownicy
    % width, height - rozmiar tekstury
    % freq          - liczba pól wzdłuż osi (np. 8 -> szachownica 8x8)

    [xx, yy] = meshgrid(1:width, 1:height);

    % częstotliwość
    sx = sin(xx/width * freq * pi);
    sy = sin(yy/height * freq * pi);

    tex = sx .* sy;

    % normalizacja do [0,1]
    tex = tex > 0;  % zamieniamy na czarno-białe pola
end
