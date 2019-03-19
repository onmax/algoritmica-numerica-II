function [T,S] = rk4(f,Tspan,y0,h)
    t0 = Tspan(1);
    tfin=Tspan(2); 
    T = t0:h:tfin; % Tiempos
    N = length(T);
    S = NaN*zeros(length(y0),N);  % Reservo espacio vector de soluciones
    S(:, 1) = y0;           % Uso la condicion inicial suministrada
    for k=1:N-1          % Iteracion para calcular y(k+1)
        tt=T(k); yy=S(:,k); % Punto de partida (tk,yk)
        K1 = f(tt,yy);
        
        delta=h/2;  % punto medio
        % Calculamos K2, en el punto medio y derivada del punto 1
        K2 = f(tt+delta,yy+delta * K1);
        
        % Calculamos K3, en el punto medio y con la derivada que calculamos
        % en el punto de K2
        K3 = f(tt + delta, yy + delta * K2);
        
        % Calculamos K4, en el punto final y con la derivada de K3
        delta=h;  % punto final
        K4 = f(tt + delta, yy + delta * K3);
        
        K = (K1 + 2 * K2 + 2 * K3 + K4)/6;
        
        % Siguiente valor y(k+1)
        S(:,k+1) = yy + h * K;
    end
return