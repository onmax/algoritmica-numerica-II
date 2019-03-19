intervalo = [0 6];
y0 = [0 2]';
tol = 10^-4;
[T,S] = rk4(@fun, intervalo, y0, 5.5);

S2 = sin(2 * T) .* (exp(1) .^ (-T));

plot(T,S,'b');