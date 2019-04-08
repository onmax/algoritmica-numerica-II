function [T,S] = euler(fun,Tspan,y0,h)
    t0 = Tspan(1);
    tfin=Tspan(2); 
    T = t0:h:tfin;               % Tiempos
    N = length(T);
    S = NaN*zeros(1,N);          % Reservo espacio vector de soluciones
    S(1) = y0;                  % Uso la condición inicial suministrada
    for k=1:N-1                 % Iteracion de Euler
        f_k = fun(T(k), S(k));   % Evaluo fun en (Tk,Yk)
        S(k+1) = S(k) + h*f_k;  % Fórmula de euler para Y(k+1)
    end
return