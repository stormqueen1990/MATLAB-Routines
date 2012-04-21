function [res, M, voltas, erro] = nr_modificado(f, x0, tol, it, tipo)
% Autores: Fernando Melo e Mauren Berti
% Encontra o valor aproximado da raiz da função representada por 'funcao',
% a partir do método de Newton-Raphson modificado para calcular a derivada
% somente para o ponto inicial, utilizando um dos critérios de parada:
% 'tol' - somente tolerância, 'ite' - somente iterações ou 'amb' para os
% dois critérios de parada.
M = []; voltas = 0; erro = 1;
x = x0; M = [x0];
df = diff(f);
d = eval(df);

switch tipo
    case 'tol'
        while erro >= tol
            x = x - eval(f)/d;
            M = [M; x];
            voltas = voltas + 1;
            erro = abs(eval(f));
        end
    case 'ite'
        while voltas < it
            x = x - eval(f)/eval(df);
            M = [M; x];
            voltas = voltas + 1;
            erro = abs(eval(f));
        end
    case 'amb'
        while erro >= tol & voltas < it
            x = x - eval(f)/d;
            M = [M; x];
            voltas = voltas + 1;
            erro = abs(eval(f));
        end
end

res = x;