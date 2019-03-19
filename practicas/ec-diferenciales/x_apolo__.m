%%%%% SCRIPT x_apolo %%%%%%%%%%%%%%%%%%%%%%%
clc; clear

global Re Rm S0
global motor

Re = 6370; Rm = 1735; motor =0;

% Vector de estado inicial (COLUMNA)
S0 = [ ];

% Opciones para el solver
opt=odeset('RelTol',1e-8,'OutputFcn',@graf,'Refine',8);   



%%%%%%%%%%%%%%%%%%%   FIN DEL SCRIP PRINCIPAL  %%%%%%%%%%%%%
  

%%%%%%%%%%%%%%%%%%%%   FUNCIONES AUXILIARES %%%%%%%%%%%%%%%%% 
function sp = apolo(t,s)
% s = vector estado con posición s(1:2) y velocidad s(7:8) de la nave
%        (12x1)         posición s(3:4) y velocidad s(9:10) de la LUNA
%                       posición s(5:6) y velocidad s(11:12) de la TIERRA

global motor

GM1 = 3.99e+005; GM2 = 4.90e+003;
 
% Extraer del vector de entrada s la posición y velocidad de la nave
r=s(1:2); rL=s(3:4); rT=s(5:6);
vn=s(7:8); vL=s(9:10); vT=s(11:12); 

% Calculo aceleraciones nave

% Calculo aceleracion Luna 

% Calculo aceleracion Tierra 

% Devolver en sp las velocidades y aceleraciones de las variables de estado

end


function fi=phi(S)  
   
end


function f=opt_reentrada(x)
global S0
global Re Rm 
global motor

T0=x(1); dT=x(2);

end


% Función de eventos para detectar reentrada @ 120 km
function [val,term,dir] = vuelta(t,s)
global Re
% val = valor que se anula si se cumple la condicion deseada (altura llega a 120 km)
rn=s(1:2); rT=s(5:6); h = norm(rn-rT)-Re; val=h-120;
term =  1;   % Detiene la iteración si se cumple condición
dir  = -1;   % Activar si cruce por cero es en sentido negativo (bajando)
end 

% Funcion a ejecutarse en cada paso. Regenera gráficos
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
