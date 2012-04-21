function [res, M, voltas, errox, erroy] = bisseccao(funcao, a, b, tol, it, tipo)
% Autores: Fernando Castilhos Melo e Mauren Ribeiro Berti
% Encontra o valor aproximado da raiz da função representada por 'funcao',
% respeitando a tolerância especificada em 'tol'. 'a' e 'b' denotam
% o intervalo em que o 0 da função se encontra.
% Tipos de bissecção: 'tol' é de tolerância de erro em x, 'ite' é de número de
% iterações e 'amb' utiliza ambos os critérios.
errox = 1;
voltas = 0;
M = [];

switch tipo
    case 'tol'
        while errox >= tol
            c = (a + b)/2;
            x = a; fa = eval(funcao);
            x = b; fb = eval(funcao);
            x = c; fc = eval(funcao);

            if fa * fc < 0
                b = c;
            else
                a = c;
            end

            voltas = voltas + 1;
            M = [M; c];

            errox = abs_error(a, b);
        end
    case 'ite'
        for i = 1:it
            c = (a + b)/2;
            x = a; fa = eval(funcao);
            x = b; fb = eval(funcao);
            x = c; fc = eval(funcao);

            if fa * fc < 0
                b = c;
            else
                a = c;
            end

            voltas = voltas + 1;
            M = [M; c];

            errox = abs_error(a, b);
        end
    case 'amb'
        while voltas < it && errox >= tol
            c = (a + b)/2;
            x = a; fa = eval(funcao);
            x = b; fb = eval(funcao);
            x = c; fc = eval(funcao);

            if fa * fc < 0
                b = c;
            else
                a = c;
            end

            voltas = voltas + 1;
            M = [M; c];

            errox = abs_error(a, b);
        end
end

% Coloca o valor de c de volta em x para calcular o erro em y
x = c;
erroy = abs(eval(funcao));
res = c;