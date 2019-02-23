function sp=motorDC(t,s)
    % Parametros Maxon A22 5W 6V
    L = 0.106e-3;
    J = 4.04e-7;
    R = 1.64;
    b = 1.7e-7;
    K = 5.9e-3;
    
    if t < 0.5
        va = 0;
    else
        va = 6;
    end
    
    vt = J + K + b + L + R + va;
    
    sp=0*s;    
    sp(1) = (1/J) * (K * s(2) - b * s(1));
    sp(2) = (-1/L) * (R * s(2) + K * s(1) + vt);
return
