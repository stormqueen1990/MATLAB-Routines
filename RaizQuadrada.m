function x = RaizQuadrada(p)
% Autores: Fernando Melo e Mauren Berti
% Função para cálculo da raiz quadrada de um número p.
if p < 0
    disp 'Número inválido! Deve ser maior ou igual a zero.'
    return
end

erro = 1;
voltas = 0;
f = 'x ^ 2 - p';
x = p;
df = diff(f);

while erro >= 1e-5 & voltas < 20
    x = x - eval(f)/eval(df);
    voltas = voltas + 1;
    erro = abs(eval(f));
end
