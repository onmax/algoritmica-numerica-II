G = [
    [0,1,0,1,1];
    [1,0,0,1,0];
    [1,0,1,1,1];
    [1,0,0,1,0];
    [0,0,0,1,0];
    [0,1,0,1,1];
    [1,1,0,1,0]
    ];

Grows = length(G);
Gcol = length(G(1,:));

% Matriz C, filas centradas
C = zeros(Grows, Gcol);
for i=1:Grows
    for j=1:Gcol
        s = 0;
        for k=1:Gcol
            s = s + G(i,k);
        end
        C(i,j) = G(i,j) - 1/5 * s;
    end
end

% Matriz de covarianza
A = C * C';

% Metodo de la potencia
nmax = 20;
x0 = ones(Grows, 1)/norm(ones(Grows, 1));
[lambda1, x1] = pot_basico(G, nmax, x0);
[lambda2, x2] = pot_basico(A, nmax, x0);


% Vector de residuos
res1 = A * x - lambda * x;
    
