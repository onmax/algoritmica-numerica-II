function yp=fun(t,y)
    yp(1) = y(2);
    yp(2) = -2 * y(2) - 5 * y(1);
return