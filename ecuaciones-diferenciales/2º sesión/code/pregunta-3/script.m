intervalo = [0 4];
tol = 5e-4;
y0 = 0.84;
[T, S] = adapta12(@fun_rara, intervalo, y0, tol);
plot(T, S, 'b');