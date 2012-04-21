function [res, M, voltas, errox, erroy] = newton_raphson(f, x0, tol, it, tipo)
% Autores: Fernando Castilhos Melo e Mauren Ribeiro Berti
% Encontra o valor aproximado da raiz da função representada por 'funcao'.
% 'x0' denota um ponto próximo do 0 da função para iniciar o cálculo.
% Tipo é o critério de parada. Pode ser: 'tol' - tolerância, 'ite' - número de
% iterações ou 'amb' - ambos os critérios.
M = []; voltas = 0; erroy = 1;
x = x0; M = [x0];
df = diff(f);

switch tipo
    case 'tol'
        while erroy >= tol
            xant = x;
            x = x - eval(f)/eval(df);
            errox = abs(xant - x);
            M = [M; x];
            voltas = voltas + 1;
            erroy = abs(eval(f));
        end
    case 'ite'
        while voltas < it
            xant = x;
            x = x - eval(f)/eval(df);
            errox = abs(xant - x);
            M = [M; x];
            voltas = voltas + 1;
            erroy = abs(eval(f));
        end
    case 'amb'
        while erroy >= tol & voltas < it
            xant = x;
            x = x - eval(f)/eval(df);
            errox = abs(xant - x);
            M = [M; x];
            voltas = voltas + 1;
            erroy = abs(eval(f));
        end
end

res = x;