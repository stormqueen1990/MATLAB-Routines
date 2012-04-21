function [res, M, voltas, errox, erroy] = pos_falsa(funcao, a, b, tol, it, tipo)
% Autores: Fernando Castilhos Melo e Mauren Ribeiro Berti
% Encontra o valor aproximado da raiz da função representada por 'funcao',
% através do método da posição falsa.
% 'a' e 'b' denotam o intervalo em que o 0 da função se encontra.
% Tipo é o critério de parada. Pode ser: 'tol' - tolerância, 'ite' - número de
% iterações ou 'amb' - ambos os critérios.
M = []; voltas = 0; erroy = 1;
x = a;
fa = eval(funcao);
x = b;
fb = eval(funcao);

switch tipo
    case 'tol'
        while erroy >= tol
            c = b - fb * (b - a)/(fb - fa);
            errox = abs(x - c);
            x = c;
            fc = eval(funcao);
            voltas = voltas + 1;
            M = [M; c];

            if fa * fc < 0
                b = c;
                fb = fc;
            else
                a = c;
                fa = fc;
            end
            
            erroy = abs(fc);
        end
    case 'ite'
        while voltas < it
            c = b - fb * (b - a)/(fb - fa);
            errox = abs(x - c);
            x = c;
            fc = eval(funcao);
            voltas = voltas + 1;
            M = [M; c];

            if fa * fc < 0
                b = c;
                fb = fc;
            else
                a = c;
                fa = fc;
            end
            
            erroy = abs(fc);
        end
    case 'amb'
        while erroy >= tol & voltas < it
            c = b - fb * (b - a)/(fb - fa);
            errox = abs(x - c);
            x = c;
            fc = eval(funcao);
            voltas = voltas + 1;
            M = [M; c];

            if fa * fc < 0
                b = c;
                fb = fc;
            else
                a = c;
                fa = fc;
            end
            
            erroy = abs(fc);
        end
end
res = c;