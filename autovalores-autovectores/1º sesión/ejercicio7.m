
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

% Metodo de la potencia sobre A
nmax = 20;
x0 = ones(Grows, 1)/norm(ones(Grows, 1));
[lambda1, x1, res1] = pot_basico(A, nmax, x0);

% Metodo de la deflacion
A2 = A - lambda1 * x1 * x1';

% Metodo de la potencia sobre A2
[lambda2, x2, res2] = pot_basico(A2, nmax, x0);


% Graficas
lambda3 = 1.1;
range=1:20;
for k=range
    lambdas1(k)=abs(lambda2/lambda1)^k;
    lambdas2(k)=abs(lambda3/lambda2)^k;
end
subplot(1,2,1);
plot(range,lambdas1,'b',range,res1,'r');
subplot(1,2,2);
plot(range, lambdas2,'b',range,res2,'r');