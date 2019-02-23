function sp = obus(t,s)
    r = s(1:2);
    rp = s(3:4);
    g = 9.8;
    ro = 1.2*(exp(1))^((-1 * r(2))/7000);
    K = 14000;
    rpp = [0 (-1 * g)]' - (ro/K) * norm(rp) * rp;
    
    sp = NaN * s;
    
    % Rellenamos el vector final
    sp(1) = rp(1);sp(2) = rp(2);
    sp(3) = rpp(1); sp(4) = rpp(2);
return