h = 5 * 10^-5;
intervalo = [0 1];
[T,Y] = euler(@motorDC, intervalo, [0 0], h);

plot(T,Y,'b');