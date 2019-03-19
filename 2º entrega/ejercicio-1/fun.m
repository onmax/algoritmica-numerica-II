function yp=fun(t,y)
    yp = y/5;
    if ((t>1)&(t<3))
        T=(t-1)/2; T=T*(1-T)*4; TT=1-T;
        temp = T*cos(2*(t-1)*pi*y)/(abs(y)+0.1);
        yp = (y/5)*TT + temp;
    end
return
