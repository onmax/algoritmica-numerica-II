function [T,S]=euler(fun,Tspan,y0,h)
    t0=Tspan(1); tfin=Tspan(2);
    T=[t0:h:tfin]; N = length(T); % Tiempos {Tk}
    n = length(y0); % n = tamaño y0 = dimensión problema.
    S=NaN*zeros(n,N); % Reservo matriz n x N de soluciones
    S(:,1) = y0; % Vector condición inicial -> 1ª columna de S
    for k=1:N-1, % Iteracion de Euler
    f_k = fun(T(k),S(:,k)); % Evaluo f(t,s)
    S(:,k+1) = S(:,k) + h*f_k; % Fórmula de Euler
    end
return