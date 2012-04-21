function x = retrosub(A, b)
% Soluciona a retrosubstituição sendo que A é triangular superior e b é o 
% vetor dos termos independentes.
n = length(b);
x = zeros(size(b));

for i = n:-1:1
    x(i) = (b(i) - A(i,:) * x)/A(i,i);
end