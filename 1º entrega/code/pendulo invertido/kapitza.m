function sp = kapitza(t,s)
    g=9.8; L=1;a=0.25;w=18;
    sp=NaN*s;                       % Vector salida mismo tamaño que s
    th=s(1);
    sp(1)=s(2);                     % Derivada s1’ = s2
    g2 = g - a * w^2 * sin(w * t);
    sp(2)= 1.125 * (g2/L)*sin(th);  % Derivada s2’ = s1’’ = ED 2º orden
return