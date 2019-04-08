figure;
N=100;  % 100 soluciones
a=-3; b=3; delta=(b-a)/N;
colores=hsv(N);
for k=1:N,
  y0=-3+k*delta;  %3-k*6/100;
  [T,Y]=euler(@fun,[0 10],y0,0.001); 
  plot(T,Y,'color',colores(k,:)); hold on   
end
hold off
set(gca,'Ylim',[-3 3]);