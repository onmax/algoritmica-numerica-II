A = [
    [1,5,3,9,5];
    [1/5,1,3,5,7];
    [1/3,1/3,1,3,9];
    [1/9,1/5,1/3,1,5];
    [1/5,1/7,1/9,1/5,1]
    ];
N = length(A(1,:));
v=[0.2 .3 0.15 0.255 0.1]';
for i=1:N
    for j=1:N
        A(i,j)=v(i)/v(j);
    end
end
p = (v / norm(v,1));
[lambda,x] = pot_basico(A);
IC = (lambda - N) / (N - 1);
