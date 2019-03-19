y0 = 2;
intervalo = [0 8];
h= 0.2;
[T1 S1] = met_AB(@fun, intervalo, y0, h);

h= 0.02;
[T2 S2] = met_AB(@fun, intervalo, y0, h);

plot(T1,S1,T2,S2);
legend({'h=0.2', 'h=0.02'});