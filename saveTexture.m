function saveTexture(ax)
% saveTexture Zapisuje obraz wyświetlony w osi (np. UIAxes) do pliku
    
    % Pobierz obraz z osi
    img = getimage(ax);

    % Okno wyboru pliku
    [file, path] = uiputfile({'*.png';'*.jpg';'*.bmp'}, 'Zapisz teksturę jako');
    
    if isequal(file,0) || isequal(path,0)
        % Użytkownik anulował
        disp('Anulowano zapis.');
        return;
    end
    
    % Zapis do wybranego pliku
    fullpath = fullfile(path, file);
    imwrite(img, fullpath);
    
    % Komunikat
    msgbox(sprintf('Tekstura została zapisana do:\n%s', fullpath), 'Sukces');

end
