clc; clear
global Rm 
global motor 
global h_stop

Rm = 1735; motor=0;


LM_mass=14500; FUEL=8200; nFUEL = LM_mass - FUEL;


% Asignar vector de condiciones iniciales 
LM_x = 0; LM_y= Rm+110;
LM_vx = 1.63; LM_vy = 0;
S0 = [LM_x LM_y LM_vx LM_vy LM_mass]';
opt=odeset('RelTol',1e-8,'Refine',8);

% Orbita luna
% Etapa 0: �rbita inicial (solo gravedad) 
[T1 S1]=ode45(@descenso,[0 3600*3],S0, opt);S1=S1';T=T1';

% Enciende motor para descender a 15km
% Retro burn 30s @ 25% y dejarse caer hasta 15000 m
motor=1;
[T2 S2]=ode45(@descenso,[0 30],S1(:,end), opt);S2=S2';T=horzcat(T,T(end)+T2');

% Apaga motor y empieza a caer hasta los 15km
% Powered descent: desde 50000 pies a 7500 pies
motor=0;
h_stop = 15;
opt=odeset('RelTol',1e-8,'Refine',8,'events',@evento_altura);
[T3 S3]=ode45(@descenso,[0 10000],S2(:,end), opt);S3=S3';T=horzcat(T,T(end)+T3');
%calcular_datos(T3,S3);
%altura_nL(T3,S3);


% Enciende motor hasta llegar a los 2.25km
% 100% con thrust unos 10grados por encima del vector antivelocidad 
motor=2;
h_stop=2.25;
[T4 S4]=ode45(@descenso,[0 10000],S3(:,end), opt);S4=S4';T=horzcat(T,T(end)+T4');
%calcular_datos(T4,S4);
%altura_nL(T4,S4);
%cantidad_fuel(LM_mass, FUEL, S4(end,end));

% Ultima fase automatica
% Fase de control final: desde 7500 a 500 pies
motor = 3;
h_stop = .15;
opt=odeset('RelTol',1e-8,'Refine',8,'events',@evento_altura);
[T5 S5]=ode45(@descenso,[0 10000],S4(:,end), opt);S5=S5';T=horzcat(T,T(end)+T5');
calcular_datos(T5,S5);
altura_nL(T5,S5);
cantidad_fuel(LM_mass, FUEL, S5(end,end));


S = horzcat(S1,S2,S3,S4,S5);
altura_nL(T,S);
%cantidad_fuel(LM_mass, FUEL, S5(end,end));
%%%%%%%%%%%%%%%%%%  FUNCIONES AUXILIARES %%%%%%%%%%%%%%%%%%

function sp=descenso(t,s)
    global motor Rm
    sp=0*s;

    r= s(1:2); v=s(3:4); m=s(5);

    GM2 = 4.90e+003; 

    % Calculo aceleracion gravitatoria
    sp(1:2) = v;
    sp(3:4) = -GM2 * r ./ (norm(r))^3;
    sp(5) = 0;
    
    % Modificar aceleraci�n segun estado del motor: 1,2,3
    switch(motor)
        case 1
            p = .25;
            E = p * 45;
            G = -15*p;
            
            % Se resta porque el motor hace fuerza justo al sentido
            % contrario a la velocidad
            sp(3:4) = sp(3:4) - (E/m)*(v/(norm(v)));
            
            %Gasto del motor
            sp(5) = G;
        case 2
            p=1;
            E = p * 45;
            G = -15 * p;
            up = r/norm(r);
            d = v + 0.14 * up;
            sp(3:4) = sp(3:4) - (45/m) * (d/norm(d));
            sp(5) = G;
        case 3
            vd = -r/norm(r);
            h = sqrt(sp(1)^2 + sp(2)^2) - Rm;
            a = -sp(3:4) - 2 .* vd/h .* v;
            E = m * norm(a);
            p = E/45;
            a = a/p;
            G = -15;
            sp(5) = G;
    end
    

    % Devolver vel, aceleraci�n y gasto combustible en vector sp

end

function [val,term,dir]=evento_altura(t,s)
    % Detecta cuando la altura sobre la Luna llega a un valor h_stop
    global Rm h_stop
    val = norm(s(1:2)) - Rm - h_stop; % negativo si llegamos al limite
    term =  1;   % para la iteraci�n si se cumple condici�n
    dir  =  -1;   % Activar si cruce por cero es en sentido negativo (bajando)
end


function altura_nL(T,S)
    global Rm;
    distancias_nL = abs((S(1,:).^2 + S(2,:).^2).^0.5) - Rm;
    plot(T,distancias_nL);
    title('Altura de la nave sobre la superficie de la Luna');
    legend({'km sobre la superficie'})
end


function cantidad_fuel(LM_mass_t0,FUEL_t0,m)
    diff = LM_mass_t0 - m;
    FUEL_quemado = FUEL_t0 - diff;
    p = FUEL_quemado * 100 / FUEL_t0;
    fprintf("Cantidad de fuel restante es %d\n", FUEL_t0 - diff);
    fprintf("Fuel restante %d %%\n", round(p));
end

function calcular_datos(T,S)
    global h_stop
    fprintf("La nave tarda %d segundos en alcanzar los %d km\n", round(T(end)), round(h_stop,2));
    v = sqrt(S(1,end)^2 + S(2,end)^2);
    fprintf("La velocidad de la nave es %d km/s o %d km/h\n", round(v),round(v)*3600);
    fprintf("Velocidad horizontal: %d km/s\n", S(1,end));
    fprintf("Velocidad vertical: %d km/s\n", S(2,end));
end
