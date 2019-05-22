G = [
    [0 1 0 1 1];
    [1 0 0 1 0];
    [1 0 1 1 1];
    [1 0 0 1 0];
    [0 0 0 1 0];
    [0 1 0 1 1];
    [1 1 0 1 0];
    ];
C = zeros(7,5);

for i=1:7
    for j=1:5
        C(i,j) = G(i,j) - mean(G(i,:));
    end
end
limit = 20;
A1 = C * C';
[lambda1,x1,res1] = pot_basico(A1, limit, (ones(7,1)/norm(ones(7,1))));
A2 = A1 - lambda1 * x1 * x1';
[lambda2,x2,res2] = pot_basico(A2, limit, (ones(7,1)/norm(ones(7,1))));
A3 = A2 - lambda2 * x2 * x2';
[lambda3,x3,res3] = pot_basico(A3, limit, (ones(7,1)/norm(ones(7,1))));

subplot(1,2,1);
semilogy(1:limit, res1, '*', 1:limit, abs(lambda2/lambda1).^[1:limit],'o');
subplot(1,2,2);
semilogy(1:limit, res2, '*', 1:limit, abs(1.1/lambda2).^[1:limit],'o');
