function [T, S]=adapta12(fun,Tspan,y0,tol)
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

     % Calcular K1, K2 y a partir de ellos la estimaci�n de Euler (s1) 
     % y de Heun s2
     K1 = fun(t, y);
     K2 = fun(t + h, y + h * K1);
     s1 = K1;
     s2 = (K1 + K2) / 2;
    
     % Calcular estimacion del error E
     E = norm(s2 - s1);

     % Calcular ratio r entre E y tol 
     ratio = E / tol;

     if ratio<=1   % Paso aceptado, a�adir los nuevos valores a T y S
         T = [T t+h]; S=[S s2];
     end
     % Actualizar h usando la formula optima con un factor adicional 0.8
     % Comprobad que no nos salimos del intervalo en el siguiente salto
     % Recortad h si se da el caso.
     h = (h*0.8 / ratio^0.5);
     
     if T(end)+h > Tfin
         h = Tfin - T(end);
     end
    end
return
 

