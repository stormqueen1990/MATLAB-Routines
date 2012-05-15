function poli = interpolacao_lagrange(x, y)
% Autores: Mauren Berti e Fernando Melo
% Encontra o polinômio interpolador para os pontos x e y recebidos através
% do método da interpolação de Lagrange. Retorna um vetor contendo os
% coeficientes deste polinômio.
    szx = size(x);
    szy = size(y);
    L = [];
    
    % Verifica se os vetores têm as mesmas dimensões
    if szx(1) ~= szy(1) || szx(2) ~= szy(2)
        disp('Os vetores x e y devem possuir as mesmas dimensões.');
        return;
    end
    
    % Monta os polinômios de Lagrange para os pontos recebidos
    for k = 1:numel(x)
        lin = 1;
        
        for i = 1:numel(x)
            if k == i
                continue;
            end;
            
            lin = conv(lin, poly(x(i)))/(x(k) - x(i));
        end
        
        % Armazena cada polinômio na matriz dos polinômios
        L = [L; lin];
    end
    
    % Calcula o polinômio interpolador
    poli = zeros(1, numel(y));
    for k = 1:numel(y)
        poli = poli + y(k) * L(k,:);
    end;
end