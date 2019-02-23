% Pregunta 1
intervalo = [0 10];
y0 = 1;

h = 0.1; 
[T1, S1]= euler( @fun, intervalo, y0, h);

h = 0.01; 
[T2, S2]= euler( @fun, intervalo, y0, h);

h = 0.001; 
[T3, S3]= euler( @fun, intervalo, y0, h);

figure
plot(T1, S1, 'b', T2, S2, 'r', T3, S3, 'g');

% Pregunta 2
intervalo = [0 10];
y0 = -1;

h = 0.1; 
[T1, S1]= euler( @fun, intervalo, y0, h);

h = 0.01; 
[T2, S2]= euler( @fun, intervalo, y0, h);

h = 0.001; 
[T3, S3]= euler( @fun, intervalo, y0, h);

figure
plot(T1, S1, 'b', T2, S2, 'r', T3, S3, 'g');