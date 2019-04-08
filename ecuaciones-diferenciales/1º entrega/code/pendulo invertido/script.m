h = 0.00001;
intervalo = [0 10];

% Pregunta 1
[T, S]= euler( @kapitza, intervalo, [0 pi/90], h);
degrees = rad2deg(S(2,:));

x = sin(degrees);
y = cos(degrees) + 0.25 .* sin(T * 50);
plot(x, y, 'b');