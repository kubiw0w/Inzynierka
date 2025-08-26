% function plasma = fractalPlasma(sizeN, roughness)
%     % fractalPlasma - generowanie tekstury metodą diamond-square
%     % sizeN      - rozmiar tekstury (2^n + 1, np. 257, 513)
%     % roughness  - współczynnik szorstkości (np. 0.5–1.0)
% 
%     % inicjalizacja
%     plasma = zeros(sizeN, sizeN);
% 
%     % ustaw wartości w rogach
%     plasma(1,1)       = rand();
%     plasma(1,end)     = rand();
%     plasma(end,1)     = rand();
%     plasma(end,end)   = rand();
% 
%     step = sizeN - 1;
%     scale = 1.0;
% 
%     while step > 1
%         half = step/2;
% 
%         % --- Diamond step ---
%         for y = 1:step:(sizeN-1)
%             for x = 1:step:(sizeN-1)
%                 avg = mean([plasma(y,x), plasma(y+step,x), ...
%                             plasma(y,x+step), plasma(y+step,x+step)]);
%                 plasma(y+half, x+half) = avg + (rand()*2 - 1) * scale;
%             end
%         end
% 
%         % --- Square step ---
%         for y = 1:half:(sizeN)
%             for x = mod(y+half, step)+1:step:(sizeN)
%                 vals = [];
%                 if x-half >= 1,   vals(end+1) = plasma(y, x-half); end
%                 if x+half <= sizeN, vals(end+1) = plasma(y, x+half); end
%                 if y-half >= 1,   vals(end+1) = plasma(y-half, x); end
%                 if y+half <= sizeN, vals(end+1) = plasma(y+half, x); end
% 
%                 plasma(y,x) = mean(vals) + (rand()*2 - 1) * scale;
%             end
%         end
% 
%         step = half;
%         scale = scale * roughness;
%     end
% 
%     % normalizacja
%     plasma = rescale(plasma, 0, 1);
% end
