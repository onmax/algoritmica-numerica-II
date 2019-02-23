function [T,S]=euler(fun,Tspan,y0,h)
    t0=Tspan(1); tfin=Tspan(2);
    T=[t0:h:tfin]; N = length(T); % Tiempos {Tk}
    n = length(y0); % n = tama�o y0 = dimensi�n problema.
    S=NaN*zeros(n,N); % Reservo matriz n x N de soluciones
    S(:,1) = y0; % Vector condici�n inicial -> 1� columna de S
    for k=1:N-1, % Iteracion de Euler
    f_k = fun(T(k),S(:,k)); % Evaluo f(t,s)
    S(:,k+1) = S(:,k) + h*f_k; % F�rmula de Euler
    end
return