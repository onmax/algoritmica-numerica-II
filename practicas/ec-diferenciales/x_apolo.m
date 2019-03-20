global Re Rm S0
global motor

Re = 6370; Rm = 1735; motor =0;


[S0, opt, T0, dT0, TF] = preparar_trayectoria();
[T1 S1]=ode45(@apolo,[0 T0],S0,opt);T1=T1';S1=S1';
motor=1;
[T2 S2]=ode45(@apolo,[T0 T0+dT0],S1(:,end),opt);T2=T2';S2=S2';
motor=0;
[T3 S3]=ode45(@apolo,[T0+dT0 TF],S2(:,end),opt);T3=T3';S3=S3';
%trayectoria_nT(S);
%altura_nT(S);
[d h m sT] = calcular_tiempo(T1(end) + T2(end) + T3(end));

fi = phi(S3(:,end));
%%%%%%%%%%%%%%%%%%%   FIN DEL SCRIP PRINCIPAL  %%%%%%%%%%%%%
 

%%%%%%%%%%%%%%%%%%%%   FUNCIONES AUXILIARES %%%%%%%%%%%%%%%%% 
function sp = apolo(t,s)
    % s = vector estado con posici�n s(1:2) y velocidad s(7:8) de la nave
    %        (12x1)         posici�n s(3:4) y velocidad s(9:10) de la LUNA
    %                       posici�n s(5:6) y velocidad s(11:12) de la TIERRA

    global motor

    GM1 = 3.99e+005; GM2 = 4.90e+003;

    % Extraer del vector de entrada s la posici�n y velocidad de la nave
    rn=s(1:2); rL=s(3:4); rT=s(5:6);
    vn=s(7:8); vL=s(9:10); vT=s(11:12);
    m=s(13);
    
    % Vector posicion tierra y luna respecto a nave.
    r1 = rn - rT; r2 = rn- rL; 
    % distancia entre luna y tierra
    rTL = rL - rT; rLT = -rTL;
    
    % Reservamos el espacio de sp
    sp=0*s;
    
    % Establecemos velocidades
    sp(1:6) = s(7:12);

    % Calculo aceleraciones nave
    sp(7:8) = -GM1 * r1/norm(r1)^3 - GM2 * r2 / norm(r2)^3;
    
    % Calculo aceleracion Luna 
    sp(9:10) = (-(GM1 * rTL)/norm(rTL)^3);
    
    % Calculo aceleracion Tierra 
    sp(11:12) = (-(GM2 * rLT)/norm(rLT)^3);
    
    % Calculamos el valor de la masa si el motor esta encendido.
    % Si el motor esta encendido, estara quemando combustible y por
    % lo tanto perdiendo masa
    if motor == 1
        F = 1000;
        sp(7:8) = sp(7:8) + (F/m)*((vn-vT)/(norm(vn-vT)));
        sp(13) = -240;
    else
        sp(13) = 0;
    end
    
    % Devolver en sp las velocidades y aceleraciones de las variables de estado
end


function fi=phi(S)
    xn = S(1);yn=S(2);
    vx = S(7); vy=S(8);
    cos = (xn*vy - yn*vx)/(norm([xn -yn]) * norm(S(7:8)));
    fi = acosd(cos);
end


function f=opt_reentrada(x)
    global S0
    global Re Rm 
    global motor

    T0=x(1); dT=x(2);

end


% Funci�n de eventos para detectar reentrada @ 120 km
function [val,term,dir] = vuelta(t,s)
    global Re
    % val = valor que se anula si se cumple la condicion deseada (altura llega a 120 km)
    rn=s(1:2); rT=s(5:6); h = norm(rn-rT)-Re; val=h-120;
    term =  1;   % Detiene la iteracion si se cumple condicion
    dir  = -1;   % Activar si cruce por cero es en sentido negativo (bajando)
end 

% Funcion a ejecutarse en cada paso. Regenera gr�ficos
function status=graf(t,s,flag)
persistent plt_nave tray plt_moon plt_line plt_tierra
persistent cc ss
global Re

switch (flag)
    case 'init',
       th=(0:0.01:6.29); cc=Re*cos(th); ss=Re*sin(th);
      
       x=s(5); y=s(6);
       plt_tierra=plot(x+cc,y+ss,'b'); hold on;       % Plot Tierra
       x=s(3); y=s(4);
       plt_moon=plot(x,y,'bo','MarkerSize',2,'MarkerFaceColor','b'); %Luna      
       plt_line=plot([s(5) x],[s(6) y],'k:');    % Linea Tierra-Luna
       tray=plot(s(1),s(2),'r:','LineWidth',2);      % Trayectoria nave
       plt_nave=plot(s(1),s(2),'ks','MarkerFaceColor','k','MarkerSize',2);
       
       set(gca,'Xlim',[-5e4 s(3)+3e4],'Ylim',[-5e4 s(3)+3e4]); 
       set(gcf,'Pos',[0 0 700 700]);
                      
    case '',           
       set(plt_tierra,'Xdata',s(5)+cc,'Ydata',s(6)+ss); 
       set(plt_nave,'Xdata',s(1),'Ydata',s(2)); 
       set(plt_moon,'Xdata',s(3),'Ydata',s(4));
       set(plt_line,'Xdata',[s(5) s(3)],'Ydata',[s(6) s(4)]);
       
       xx=get(tray,'Xdata'); yy=get(tray,'Ydata');
       set(tray,'Xdata',[xx s(1)],'Ydata',[yy s(2)]);   
       
       set(gca,'Xlim',[-5e4 400000],'Ylim',[-5e4 400000]); 
       pause(0.005);      
       
    case 'done',
       title("Orbita de la nave sobre la Tierra");
       legend({'Tierra','Luna','Distancia Luna-Tierra','Trayectoria nave','Nave'});
       hold off
end      


status=0;
end

function [S0, opt, T0, dT0, TF]= preparar_trayectoria()
    %t0 = 0;
    %tf = 8*3600;
    %intervalo = [t0 tf];
    T0 = 3249.99905;
    dT0 = 310;
    TF = 8*3600*24;

    % Datos iniciales de la nave
    rn = [6555 0];vn = [0 7.789];
    % Datos iniciales de la luna
    rL = [384000 0];vL = [0 1];
    % Datos iniciales de la tierra
    rT = [0 0];vT = [0 -0.0123];
    % Masa inicial de la nave
    m = 140000;
    
    % Vector de estado inicial (COLUMNA)
    S0 = horzcat(rn,rL,rT,vn,vL,vT,m)';

    % Opciones para el solver
    opt=odeset('RelTol',1e-8,'OutputFcn',@graf,'Refine',8,'Events',@vuelta);   
end

function trayectoria_nT(S)
    global Re;
    xn = S(1,:);yn=S(2,:);
    xT = S(5,:);yT=S(6,:);
    th=(0:0.01:2*pi);
    %plot(xn,yn,'r',Re*cos(th),Re*sin(th),'b');
    %title("Orbita de la nave sobre la Tierra estática");
    plot(xn-xT,yn-yT,'r',Re*cos(th),Re*sin(th),'b');
    title("Orbita de la nave sobre la Tierra");
    legend({'Orbita nave','Tierra'})
end

function altura_nT(S)
    global Re
    xn = S(1,:);yn=S(2,:);
    xT = S(5,:);yT=S(6,:);
    plot(((xn-xT).^2 + (yn-yT).^2).^0.5 - Re);
    title("Oscilación de la nave respecto al centro de la Tierra");
    xlabel("Segundos");
    ylabel("Kilometros");
end

function [d h m sT] = calcular_tiempo(t)
    % d: dias, h:horas, m:minutos
    % sT: segundos totales
    Tdia = 24*60*60;
    sT = t;
    d = floor(t / Tdia);
    h = floor((t - d * Tdia)/3600);
    m = floor((t - d * Tdia - h * 3600)/60);
end






