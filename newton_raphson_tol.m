function [res, errox, erroy, voltas] = newton_raphson_tol(f, x0, tol)
x = x0;
erroy = 1;
voltas = 0;

df = diff(f);
while erroy >= tol
    xant = x;
    x = x - eval(f)/eval(df);
    errox = abs(xant - x);
    voltas = voltas + 1;
    erroy = abs(eval(f));
end

res = x;