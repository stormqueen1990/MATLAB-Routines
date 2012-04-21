function [res] = calc_pi(n)
% Autora: Mauren Berti
% Calcula o valor de pi através de uma série com o número de termos n

res = 0;
for i = 1:n
    res = res + ((-1)^(i-1) * (1/(2*i-1)));
end

res = res * 4;