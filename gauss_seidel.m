function [x, voltas, erro, aprox] = gauss_seidel(A, b, x0, tol, ite, tipo)
    voltas = 0;
    erro = 1;
    M = [];
    D = diag(diag(A));
    L = tril(A, -1);
    U = triu(A, 1);
    B = -(L + D)\U;
    d = (L + D)\b;
    autoval = eig(B);
    
    if max(abs(autoval)) >= 1
        disp ('A matriz de iteração não é estável.');
        return;
    end
    
    switch tipo
        case 'tol'
            while erro >= tol
                x = B * x0 + d;
                erro = norm(x - x0, inf);
                voltas = voltas + 1;
                M = [M, x];
                x0 = x;
            end
        case 'ite'
            while voltas <= ite
                x = B * x0 + d;
                erro = norm(x - x0, inf);
                voltas = voltas + 1;
                M = [M, x];
                x0 = x;
            end
        case 'amb'
            while erro >= tol & voltas <= ite
                x = B * x0 + d;
                erro = norm(x - x0, inf);
                voltas = voltas + 1;
                M = [M, x];
                x0 = x;
            end
    end
    
    aprox = M;
end