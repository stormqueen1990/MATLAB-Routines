function [s] = calc_eulerian(x, n)
% Calcula o e^x pela serie de Taylor com n termos.
% s = calc_eulerian(x, n)
s = 0;
for i = 1:n+1
    s = s + x^(i - 1)/factorial(i - 1);
end