function [T S] = met_PC(fun, Tspan, y0, h)
    t0 = Tspan(1);
    tfin = Tspan(2);
    
    T = t0:h:tfin;
    N = length(T);
    
    % Como es de orden 2, necesitamos al menos tener dos elementos en S y F
    S = NaN * zeros(1, N);
    S(1) = y0;
    K1=fun(T(1),S(1)); K2=fun(T(2),S(1)+h*K1); K=(K1+K2)/2; S(2)=S(1)+K*h;
    
    
    % Vector con el historico de las evaluaciones de F
    F = NaN * zeros(1, N);
    F(1) = K1;
    F(2) = fun(T(2), S(2));
    
    for k=2:N-1
        % solucion del predictor
        P = S(k) + (h/2)*(3*F(k) - F(k - 1));
        delta = 99;
        while delta>10^-5
            Pnew = S(k) + (h/2)*(fun(T(k+1), P) + F(k));
            F(k + 1) = fun(T(k+1), S(k+1));
            delta = abs(Pnew - P);
            P = Pnew;
        end
        S(k+1) = P;
        F(k+1) = fun(T(k+1), S(k+1));
    end 
return