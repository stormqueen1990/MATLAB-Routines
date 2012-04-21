function [s] = calc_cos(x, n)
s = 0;
vlr = 0;
for i = 1:n
    s = s + ((-1)^(i - 1) * ((x^vlr)/factorial(vlr)));
    vlr = vlr + 2;
end;