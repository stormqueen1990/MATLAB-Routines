function [sol, triang, tipo] = eliminacao_gauss(A, x)
% Autores: Mauren Berti e Fernando Melo
% Monta uma matriz representando um sistema de equações e a triangulariza.
% Recebe 2 parâmetros: A, a matriz dos coeficientes das equações, e x, o
% vetor dos termos independentes. A partir destes dados, é montada a matriz
% [A x], que será triangularizada.
% Retorna a solução do sistema (somente quando é SPD), a matriz 
% triangularizada e o tipo de sistema.
    function res = is_triangularized(A)
    % Verifica se a matriz já está triangularizada
        sizeA = size(A);

        count_non_zeros = 0;
        for j = 1:sizeA(2)
            % Verifica o número de elementos não-nulos até a diagonal
            % principal
            for i = j + 1:sizeA(1)
                if A(i, j) ~= 0
                    count_non_zeros = count_non_zeros + 1;
                end
            end
        end

        % Se existe algum elemento não-nulo, a matriz não é triangular
        if count_non_zeros > 0
            res = 0;
        else
            res = 1;
        end
    end

    function res = is_line_done(A, num_line)
    % Verifica se todos os elementos até a diagonal principal da linha já
    % estão nulos
        count_non_zeros = 0;

        for i = 1:num_line - 1
            % Verifica o número de elementos não-nulos até o elemento
            % pertencente à diagonal principal da linha
            if A(num_line, i) ~= 0
                count_non_zeros = count_non_zeros + 1;
            end
        end

        % Se tem algum elemento não-nulo, ainda não está pronta a linha
        if count_non_zeros > 0
            res = 0;
        else
            res = 1;
        end
    end

    function res = is_line_null(v)
        % Verifica se o vetor recebido em questão já está zerado
        count_zeros = 0;
        line_size = length(v);

        for i = 1:line_size
            % Verifica o número de elementos nulos até o fim do vetor
            if v(i) == 0
                count_zeros = count_zeros + 1;
            end
        end

        % Se o número de elementos nulos for igual ao tamanho da linha,
        % então a linha está zerada
        if count_zeros == line_size
            res = 1;
        else
            res = 0;
        end
    end

    function M = triangularize(M)
    % Triangulariza a matriz recebida
        szb = size(M);
        lines = szb(1);
        curr_col = 1;
        
        % Enquanto a matriz não está triangularizada, segue o processo
        while is_triangularized(M) == 0
           lin = [];
           x = 0;
           for i = curr_col:lines
               x = i;
               % Encontra um pivô
               done = is_line_done(M, curr_col);
               pivot = M(x,curr_col);
               
               if (done == 1) & (pivot ~= 0)
                   lin = M(x,:);
                   break
               end
           end

           % Aplica a aritmética a todas as linhas, zerando a coluna abaixo
           % do pivô
           for j = x + 1:lines
               M(j,:) = M(j,:) - (lin * (M(j,curr_col)/lin(1, curr_col)));
           end

           % Incrementa a coluna para buscar o próximo pivô
           curr_col = curr_col + 1;
        end
    end

    function res = determine_system_type(M)
    % Determina o tipo de sistema de equação encontrado
        [l, c] = size(M);
        
        % Verifica se a matriz tem mais colunas que linhas
        if l < c - 1
            ct_imp = 0;
            for i1 = 1:l;
                % Verifica se é SI
                if is_line_null(M(i1, 1:c - 1)) == 1 && M(i1, c) ~= 0
                    ct_imp = 1;
                    break;
                end
            end
            
            if ct_imp == 0
                % Se não é SI, só pode ser SPI
                res = 2;
            else
                res = 1;
            end
        else
            % Se a matriz tem mais linhas que colunas (excluindo-se a 
            % coluna dos termos independentes), pode ser qualquer tipo de sistema
            if l > c - 1
                ct_imp = 0;
                for i1 = 1:l;
                    % Verifica se é SI
                    if is_line_null(M(i1, c - 1)) == 1 && M(i1, c) ~= 0
                        ct_imp = 1;
                        break;
                    end
                end
                
                if ct_imp == 0
                    % Se não é SI, pode ser SPI
                    ct_null = 0;
                    for i2 = 1:l
                        ct_null = ct_null + is_line_null(M(i2,:));
                    end
                    
                    % Se o número de linhas preenchidas é menor que o
                    % número de colunas (fora a coluna dos TI), é SPI
                    if ct_null > 0 && l - ct_null < c - 1
                        res = 2;
                    else
                        % SPD
                        res = 3;
                    end
                else
                    res = 1;
                end
            else
                % Se for quadrada (tirando a coluna dos TI), então pode ser
                % qualquer coisa também
                ct_imp = 0;
                for i1 = 1:l;
                    % Verifica se é SI
                    if is_line_null(M(i1,1:c - 1)) == 1 && M(i1, c) ~= 0
                        ct_imp = 1;
                        break;
                    end
                end
                
                if ct_imp == 0
                    ct_null = 0;
                    for i2 = 1:l
                        ct_null = ct_null + is_line_null(M(i2,:));
                    end
                    
                    if ct_null == 0
                        res = 3;
                    else
                        res = 2;
                    end
                else
                    res = 1;
                end
            end
        end
    end

    function x = retrosub_spd(A, b)
    % Soluciona a retrosubstituição sendo que A é triangular superior e b é o 
    % vetor dos termos independentes, e o sistema é possível e determinado.
        n = length(b);
        x = zeros(size(b));

        for i = n:-1:1
            x(i) = (b(i) - A(i,:) * x)/A(i,i);
        end
    end

    system_type = {'Impossível'; 'Possível e indeterminado'; 'Possível e determinado'};
    sol = [];
    triang = [];
    tipo = '';
    res = 0;

    sz = size(A);
    lines = sz(1);
    cols = sz(2);
    A = [A x];

    % Se tem mais linhas que colunas, tenta eliminar as linhas em excesso
    if lines > cols
        M = A;
        lines_removed = 0;
        % A cada linha da matriz
        for i = 1:lines
           lin = M(i,:);

           % Tenta eliminar as linhas múltiplas, uma a uma, de baixo para
           % cima
           for j = lines:-1:i + 1
               zr = M(j,:)./lin;
               zr = M(j,:) - (lin * zr(1));

               if is_line_null(zr) == 1
                   lines_removed = lines_removed + 1;
                   M(j,:) = zr;
               end
           end
        end
        
        C = [];
        % Verifica as linhas nulas e as remove, montando uma nova matriz
        % que será triangularizada
        for i = 1:lines
            l = M(i,:);
            if is_line_null(l) == 0
               C = [C; l]; 
            end
        end
        
       szc = size(C);
        
       % Se as dimensões da matriz permanecem iguais, é um SI (não havia
       % linhas múltiplas a serem eliminadas)
       if szc(1) == lines & szc(2) == cols
           res = 1;
           triang = C;
           sol = [];
       else % Senão, triangulariza a matriz
           A = triangularize(C);
           A = [A; zeros(lines_removed, szb(2))];
           triang = A;
       end
    else
        triang = triangularize(A);
    end
    
    res = determine_system_type(triang);
    tipo = system_type(res);
    
    % Encontra a solução do sistema
    if res == 3
        szt = size(triang);
        sol = retrosub_spd(triang(:,1:szt(2) - 1), triang(:,szt(2)));
    end
end