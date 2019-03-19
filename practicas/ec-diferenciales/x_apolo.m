global Re Rm S0
global motor

Re = 6370; Rm = 1735; motor =0;

[intervalo S0, opt] = preparar_trayectoria();
[T S]=ode45(@apolo,intervalo,S0,opt);T=T';S=S';
trayectoria_nT(S,Re);
altura_nT(S, Re);
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
    
    % Vector posicion tierra y luna respecto a nave.
    r1 = rn - rT; r2 = rn- rL; 
    % distancia entre luna y tierra
    rTL = rL - rT; rLT = -rTL;
    
    % Establecemos velocidades
    sp(1:6) = s(7:12);

    % Calculo aceleraciones nave
    sp(7:8) = (-(GM1 * r1)/norm(r1)^3) - (GM2 * r2 / norm(r2)^3);
    
    % Calculo aceleracion Luna 
    sp(9:10) = (-(GM1 * rTL)/norm(rTL)^3);
    
    % Calculo aceleracion Tierra 
    sp(11:12) = (-(GM2 * rLT)/norm(rLT)^3);

    % Devolver en sp las velocidades y aceleraciones de las variables de estado
    sp = sp';
end


function fi=phi(S)  

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
term =  1;   % Detiene la iteraci�n si se cumple condici�n
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
       hold off
end      
 
status=0;
end

function [intervalo, S0, opt]= preparar_trayectoria()
    t0 = 0;
    tf = 8*3600;
    intervalo = [t0 tf];

    % Datos iniciales de la nave
    rn = [6555 0];vn = [0 7.789];
    % Datos iniciales de la luna
    rL = [384000 0];vL = [0 1];
    % Datos iniciales de la tierra
    rT = [0 0];vT = [0 -0.0123];
    
    % Vector de estado inicial (COLUMNA)
    S0 = horzcat(rn,rL,rT,vn,vL,vT)';

    % Opciones para el solver
    opt=odeset('RelTol',1e-8,'OutputFcn',@graf,'Refine',8);   
end

function trayectoria_nT(S,Re)
    xn = S(1,:);yn=S(2,:);
    xT = S(5,:);yT=S(6,:);
    th=(0:0.01:2*pi);
    plot(Re*cos(th),Re*sin(th),'b',xn-xT,yn-yT,'r');
    title("Orbita de la nave sobre la Tierra");
    legend({'Orbita nave','Tierra'})
end

function altura_nT(S, Re)
    xn = S(1,:);yn=S(2,:);
    xT = S(5,:);yT=S(6,:);
    plot(((xn-xT).^2 + (yn-yT).^2).^0.5 - Re);
    title("Oscilación de la nave respecto al centro de la Tierra");
    xlabel("Segundos");
    ylabel("Kilometros");
end
