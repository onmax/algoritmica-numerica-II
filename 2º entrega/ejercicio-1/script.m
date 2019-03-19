intervalo = [0 4];
y0 = 0.84;
tol = 5e-4;
[T1,S1] = adapta23(@fun, intervalo, y0, tol);
h=0.125;
[T2,S2] = rk4(@fun, intervalo, y0, h);
plot(T1,S1,'b',T2,S2,'r');