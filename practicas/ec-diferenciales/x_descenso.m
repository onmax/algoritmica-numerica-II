clc; clear
global Rm 
global motor 
global h_stop

Rm = 1735; motor=0;

LM_mass=14500; FUEL=8200;


% Asignar vector de condiciones iniciales 
S0 = [ ]; 


% Etapa 0: órbita inicial (solo gravedad)   


 
% Retro burn 30s @ 25% y dejarse caer hasta 15000 m


    
% Powered descent: desde 50000 pies a 7500 pies
% 100% con thrust unos 10º por encima del vector antivelocidad 


 
 
% Fase de control final: desde 7500 a 500 pies




%%%%%%%%%%%%%%%%%%  FUNCIONES AUXILIARES %%%%%%%%%%%%%%%%%%

function sp=descenso(t,s)
global motor Rm
sp=0*s;

r=s(1:2); v=s(3:4); m=s(5);

GM2 = 4.90e+003; 

% Calculo aceleracion gravitatoria


% Modificar aceleración segun estado del motor: 1,2,3


% Devolver vel, aceleración y gasto combustible en vector sp

end

function [val,term,dir]=evento_altura(t,s)
% Detecta cuando la altura sobre la Luna llega a un valor h_stop
global Rm  h_stop


val =        
term =  1;   % para la iteración si se cumple condición
dir  =  -1;   % Activar si cruce por cero es en sentido negativo (bajando)
end


