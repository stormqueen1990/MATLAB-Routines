function sol = cramer(A, x)
% Autores: Fernando Melo e Mauren Berti
% Soluciona um sistema linear pelo método de Cramer, sendo que o parâmetro
% A são os coeficientes das equações e o parâmetro x são os termos
% independentes.
% Retorno: sol - um vetor com a solução do sistema.

if det(A) == 0
    disp('A matriz A tem determinante 0.');
    disp('Não será possível calcular a solução pelo método de Cramer.');
    return
end

sol = [];
sizeA = size(A);
cols = sizeA(2);

for i = 1:cols
    B = A;
    B(:,i) = x;
    sol = [sol; det(B)/det(A)];
end