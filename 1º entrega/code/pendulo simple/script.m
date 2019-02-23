h = 0.001;
intervalo = [0 5];

% Pregunta 1
[T, S]= euler( @pendulo, intervalo, [0 (57.3 * pi/180)], h);
degrees = rad2deg(S(2,:));

deg = (57.3 * pi/180) .* cos((9.8)^0.5 .* T);
degr = rad2deg(deg);

plot(T, degrees, 'b', T, degr, 'r');


K = 0.5 .* (S(2,:)).^2;
U = 9.8 * (1 - cos(S(1,:)));

ET = K + U;

seg = 0;
for k=0:1:9999
    seg = seg + ((factorial(2*k)/(2^(2*k)*(factorial(k)^2)))^2 *sin((57.3 * pi/180)/2)^(2*k));
end
periodo = 2.01 * seg;
disp(periodo)
plot(T, periodo, 'b');