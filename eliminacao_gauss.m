function [sol, triang, tipo] = eliminacao_gauss(A, x)
    % Autores: Fernando Melo e Mauren Berti
    % Soluciona o sistema utilizando o método da eliminação de Gauss.
    % O parâmetro A é a matriz dos coeficientes da equação e o parâmetro x é
    % o vetor dos termos independentes.
    % Retornos: sol - um vetor contendo a solução do sistema; triang - a
    % matriz triangularizada, tipo - uma mensagem com o tipo do sistema.
    
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

    function res = is_line_zeroed(A, num_line)
        % Verifica se a linha em questão já está zerada
        count_zeros = 0;
        line_size = length(A(num_line,:)) - 1;

        for i = 1:line_size
            % Verifica o número de elementos nulos até o fim da linha,
            % tirando a coluna referente aos elementos independentes
            if A(num_line,i) == 0
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

    
    % Inicializa as variáveis
    sol = [];
    triang = [];
    tipo = '';

    % Junta a matriz recebida com o vetor dos elementos independentes
    A = [A x];
    
    % Obtém o tamanho da matriz para uso posterior
    sizeA = size(A);

    % Controla a coluna corrente
    curr_col = 1;
    while is_triangularized(A) == 0
        lin = [];
        for i = 1:sizeA(1)
            % Busca a linha do pivô
            if curr_col ~= 1 & is_line_done(A, i) == 0
                continue;
            end

            if A(i,curr_col) ~= 0
                lin = A(i,:);
                break
            end
        end

        % Se não for a linha corrente, troca elas
        if i > curr_col
            old_col = A(curr_col,:);
            A(curr_col,:) = lin;
            A(i,:) = old_col;
        end

        % Zera o elemento referente à coluna corrente
        for i = curr_col + 1:sizeA(1)
            A(i,:) = A(i,:) - (A(curr_col,:) * A(i, curr_col));
        end

        curr_col = curr_col + 1;
    end

    % Transforma os pivôs em unitários
    for i = 1:sizeA(1)
        if A(i,i) ~= 1
            A(i,:) = A(i,:) * (1./A(i,i));
        end
    end

    spi = 0;
    si = 0;
    % Verifica se é sistema impossível
    for i = 1:sizeA(1)
        % Se a linha está zerada e o termo independente não, então é um
        % sistema impossível
        if is_line_zeroed(A, i) == 1 & A(i, sizeA(2)) ~= 0
            si = 1
            break;
        end
    end

    if si == 0
        % Se não é um sistema impossível, verifica se é indeterminado
        for i = 1:sizeA(1)
            % Se a linha toda está zerada (incluindo o termo independente),
            % então é um sistema indeterminado
            if is_line_zeroed(A, i) == 1 & A(i, sizeA(2)) == 0
                spi = 1;
                break;
            end
        end
    end

    % Armazena uma mensagem com o tipo do sistema
    if si == 1
        tipo = 'É um sistema impossível';
        return
    else if spi == 1
            tipo = 'É um sistema possível e indeterminado';
        else
            tipo = 'É um sistema possível e determinado';
        end
    end

    % Atribui a matriz triangularizada e prepara variáveis para fazer a
    % retrosubstituição
    triang = A;
    B = A(:,1:(sizeA(2) - 1));
    b = A(:,sizeA(2));
    sol = zeros(size(b));
    n = length(b);

    % Efetua a retrosubstituição
    for i = n:-1:1
        sol(i) = (b(i) - B(i,:) * sol)/B(i,i);
    end
end