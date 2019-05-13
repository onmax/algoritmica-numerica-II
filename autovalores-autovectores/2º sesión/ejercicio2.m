[A, im] = obtenermatriz('photpress16.jpg');
valoressingulares(A);

[U10, S10, V10, im10] = kfunction(A, 10);
[U20, S20, V20, im20] = kfunction(A, 20);
[U30, S30, V30, im30] = kfunction(A, 30);

dibujarimg(im, im10, im20, im30);

[err10, gan10] = error_ganancia(A, U10 * S10 * V10', 10);
[err20, gan20] = error_ganancia(A, U20 * S20 * V20', 20);
[err30, gan30] = error_ganancia(A, U30 * S30 * V30', 30);

%subplot(1,1,1);
%plot([1, 2, 3], [err10, err20, err30], 'b', [1, 2, 3], [gan10, gan20, gan30], 'r');

function [A, im] = obtenermatriz(path)
    im = imread(path);
    imagesc(im);colormap(gray);
    A = double(im);
end

function valoressingulares(A)
    [U,S,V] = svd(A);
    s = diag(S);
    subplot(2,1,1);
    
    %Primera gráfica
    plot(1:321, s);
    title('Usando plot()');
    subplot(2,1,2);
    semilogy(1:321, s);
    title('Usando semilogy()');
    
    %Segunda gráfica
    cont_inf = s/s(1);
    subplot(1,1,1);
    plot(cont_inf(1:21));
    title('Valores singulares en proporción al primer valor singular');
end

function [Uk, Sk, Vk, imk] = kfunction(A, k)
    [Uk, Sk, Vk] = svds(A, k);
    imk = Uk * Sk * Vk';
end

function dibujarimg(im1, im2, im3, im4)
    subplot(2,2,1);
    imagesc(im1);colormap(gray);
    title('IMAGEN ORIGINAL');

    subplot(2,2,3);
    imagesc(im2);colormap(gray);
    title('IMAGEN K=10');

    subplot(2,2,2);
    imagesc(im3);colormap(gray);
    title('IMAGEN K=20');

    subplot(2,2,4);
    imagesc(im4);colormap(gray);
    title('IMAGEN K=30');
end

function [err, gan] = error_ganancia(A, Ak, k)
    err = norm(A - Ak) / norm(A);
    [n, m] = size(A);
    gan = k*(n+m+1)/(n*m);
end