function [T, S]=adapta23(fun,Tspan,y0,tol)
    %Metodo adaptativo basado en Heun + Euler
    % fun   -> funcion con la ec. diferencial
    % Tspan -> intervalo [a,b] donde resolver
    % y0    -> vector columna de condiciones iniciales
    % tol   -> cota del error relativo (p.e 1e-3 o 1e-5)


    % Ptos inicial y final del intervalo a resolver 
    T0 = Tspan(1);
    Tfin = Tspan(2);

    % Inicializar el primer valor para h
    h = (Tfin - T0) / 20;

    % Inicializar las salidas T y S con sus valores iniciales 
    T = T0;
    S = y0;
    
    while(T(end)<Tfin)

        % Parto del ultimo punto conocido de la soluci�n     
        t=T(end); y=S(:,end);  

        % Calcular K1, K2, K3
        K1 = fun(t, y);
     
        delta = h/2;
        K2 = fun(t + delta, y + delta * K1);
     
        delta = 3*h/4;
        K3 = fun(t+delta, y+delta*K2);
        
        % Estimacion orden 3
        s3 = y + (h/9) * (2*K1 + 3*K2 + 4*K3);
        K4 = fun(t+h, s3);
     
        % Estimacion orden 2
        s2 = y +(h/24)*(7*K1 + 6*K2 + 8*K3 + 3*K4);
     
    
        % Calcular estimacion del error E
        E = norm(abs(s2-s3));

         % Calcular ratio r entre E y tol 
         ratio = E / tol;

         if ratio<=1   % Paso aceptado, a�adir los nuevos valores a T y S
             T = [T t+h]; S=[S s2];
         end
         % Actualizar h usando la formula optima con un factor adicional 0.8
         % Comprobad que no nos salimos del intervalo en el siguiente salto
         % Recortad h si se da el caso.
         h = (h / ratio^(1/3)) * 0.8;

         if T(end)+h > Tfin
             h = Tfin - T(end);
         end
    end
return