function sen = calc_sen(x, n)
% Autora: Mauren Berti
% Calcula o seno de x utilizando o número de termos especificado por n
% Ex.: sen = calc_sen(PI/4, 100);

sen = 0;
i = 1;

for ct = 0:n-1
    sen = sen + ((-1)^ct * (x^i/factorial(i)));
    i = i + 2;
end
