function sp = pendulo(t,s)
    g=9.8; L=1;
    sp=NaN*s;      % Vector salida mismo tamaño que s
    th=s(1);
    sp(1)=s(2);           % Derivada s1’ = s2
    sp(2)= -1 * (g/L)*sin(th); % Derivada s2’ = s1’’ = ED 2º orden
return