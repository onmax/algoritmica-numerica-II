function [lambda,x]=pot_basico(A, nmax, x0)
    % Calcula el mayor (abs) autovalor lambda de A y un autovector asociado x
    n=size(A,1);
    if nargin == 1
        x0=rand(n,1); % Vector de arranque
        nmax=100; % Numero max iteraciones
    end
    x=x0;
    for k=1:nmax
        x1=A*x;
        lambda= x'*x1; % otra opción lambda=norm(x1, p)/norm(x, p)
        x=x1/norm(x1);
    end
return
 