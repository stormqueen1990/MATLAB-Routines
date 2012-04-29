function [x, voltas, erro, aprox] = metodo_jacobi(A, b, x0, tol, ite, tipo)
    % Autores: Mauren Berti e Fernando Melo
    % Soluciona um sistema de equações lineares pelo método de Jacobi.
    % Parâmetros: A é a matriz que representa o sistema, b é o vetor dos termos
    % independentes, x0 é o inicializador, tol é a tolerância utilizada para o
    % cálculo, ite é o número de iterações utilizadas para o cálculo e tipo
    % pode ser: 'tol' - utiliza somente a tolerância para o cálculo, 'ite' -
    % utiliza somente o número de iterações para o cálculo e 'amb' utiliza
    % ambos os critérios.

    voltas = 0;
    erro = 1;
    aprox = [];
    D = diag(diag(A));
    L = tril(A, -1);
    U = triu(A, 1);
    B = -D\(L + U);
    d = D\b;
    autoval = eig(B);

    if max(abs(autoval)) >= 1
        disp('A matriz de iteração não é estável.');
        return
    end

    switch tipo
        case 'tol'
            while erro >= tol
                x = B * x0 + d;
                erro = norm(x - x0, inf);
                voltas = voltas + 1;
                aprox = [aprox,x];
                x0 = x;
            end
        case 'ite'
            while voltas <= ite
                x = B * x0 + d;
                erro = norm(x - x0, inf);
                voltas = voltas + 1;
                aprox = [aprox,x];
                x0 = x;
            end
        case 'amb'
            while erro >= tol & voltas <= ite
                x = B * x0 + d;
                erro = norm(x - x0, inf);
                voltas = voltas + 1;
                aprox = [aprox,x];
                x0 = x;
            end
    end
end