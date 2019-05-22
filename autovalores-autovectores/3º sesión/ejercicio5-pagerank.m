A = [
    [0 1 0 0 0 0 0];
    [1 0 0 0 0 0 0];
    [0 1 0 1 0 0 0];
    [0 0 0 0 0 0 0];
    [0 0 1 0 0 0 1];
    [0 0 0 0 1 0 0];
    [1 0 0 1 1 1 0];
    ];
S = zeros(7);
for i=1:7
    for j=1:7
        S(i,j) = A(i,j) / sum(A(:,j));
    end
end

[lambda, x1, res1] = pot_basico(S);
S2 = S - lambda * x1 * x1';
[lambda2, x2, res2] = pot_basico(S2);

a = [1 0.85 0.5 0];
G1 = a(1) * S + (1-a(1)) * (1/7) * ones(7,7);
[lambda, x, res] = pot_basico(G1);
G12 = G1 - lambda * x * x';
[lambda2, x2, res2] = pot_basico(G12);
fprintf("Lambda 1: %d          num iter: %d       lambda2: %d,       convergencia %d\n", lambda, 100, lambda2, abs(lambda2/lambda));
x'
G2 = a(2) * S + (1-a(2)) * (1/7) * ones(7,7);
[lambda, x, res] = pot_basico(G2);
G22 = G2 - lambda * x * x';
[lambda2, x2, res2] = pot_basico(G22);
fprintf("Lambda 1: %d          num iter: %d       lambda2: %d,       convergencia %d\n", lambda, 100, lambda2, abs(lambda2/lambda));
x'
G3 = a(3) * S + (1-a(3)) * (1/7) * ones(7,7);
[lambda, x, res] = pot_basico(G3);
G32 = G3 - lambda * x * x';
[lambda2, x2, res2] = pot_basico(G32);
fprintf("Lambda 1: %d          num iter: %d       lambda2: %d,       convergencia %d\n", lambda, 100, lambda2, abs(lambda2/lambda));
x'
G4 = a(4) * S + (1-a(4)) * (1/7) * ones(7,7);
[lambda, x, res] = pot_basico(G4);
G42 = G4 - lambda * x * x';
[lambda2, x2, res2] = pot_basico(G42);
fprintf("Lambda 1: %d          num iter: %d       lambda2: %d,       convergencia %d\n", lambda, 100, lambda2, abs(lambda2/lambda));
x'
