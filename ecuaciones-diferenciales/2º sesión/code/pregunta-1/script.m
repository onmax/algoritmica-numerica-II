intervalo = [0 5];
h = 0.01;
y0 = 1;
[T, S] = rk4(@fun, intervalo, y0, h);

% Calculo de la ecuación correcta:
S_correcta = exp(T);

plot(T, S, 'b', T, S_correcta, 'r');


error_absoluto = abs(S_correcta - S);
error_medio = mean(error_absoluto);
