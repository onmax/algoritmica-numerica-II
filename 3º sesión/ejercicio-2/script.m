y0 = 2;
intervalo = [0 8];
h= 0.2;
%[T1 S1] = met_AB(@fun, intervalo, y0, h);
%[T2 S2] = met_PC(@fun, intervalo, y0, h);
opt = odeset('RelTol',10^-6,'Stats','on');
%[T3 S3] = ode23(@fun,intervalo,y0,opt);
 
%plot(T1,S1,T2,S2,T3,S3,'g');
%legend({'AB','PC','ode23'});

[T S niter]= met_PC_iter(@fun, intervalo, y0, h);

[T1 S1] = ode23(@fun,[0 8],y0, opt);

plot(T,niter);

legend({'iter'});