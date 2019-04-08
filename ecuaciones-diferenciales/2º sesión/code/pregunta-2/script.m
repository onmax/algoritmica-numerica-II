r = [0 0];

v0 = 470;
alpha = 45;
rp = NaN * zeros(2);
rp(1)=v0 * cosd(alpha);
rp(2)=v0 * sind(alpha);

r0 = [r(1) r(2) rp(1) rp(2)]';
h = 0.1;

intervalo = [0 70];

[T, S] = rk4(@obus, intervalo, r0, h);

yy = v0 * sind(alpha) * T - 9.8 * (T.^2)/2;
xx = v0 * cosd(alpha) * T;


plot(S(1,:), S(2,:), intervalo,[0 0],'r:'); 
