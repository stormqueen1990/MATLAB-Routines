function [sol, triang, tipo] = eliminacao_gauss(A, x)
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

    function res = is_line_null(A, num_line)
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

   sol = [];
   triang = [];
   tipo = '';
   
   sz = size(A);
   lines = sz(1);
   cols = sz(2);
   A = [A x];
   
   if cols > lines
       curr_col = 1;
       while is_triangularized(A) == 0
           lin = [];
           for i = 1:lines
               if curr_col == 1
                   lin = A(i,:);
                   break
               else if is_line_done(A, curr_col) & A(i,curr_col) ~= 0
                       lin = A(i,:);
                       break
                   end
               end
           end
           
           for j = i + 1:lines
               A(j,:) = A(j,:) - (lin * A(j,curr_col));
           end
           
           curr_col = curr_col + 1;
       end
   else if lines > cols           
           for i = lines:-1:1
               lin1 = A(i,:) - 
           end
       end
   end
   
   triang = A;
end