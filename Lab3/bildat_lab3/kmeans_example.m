K = 8;               % number of clusters used
L = 10;              % number of iterations
seed = 14;           % seed used for random initialization
scale_factor = 1.0;  % image downscale factor
image_sigma = 1.0;   % image preblurring scale

I = imread('orange.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

tic
[ segm, centers ] = kmeans_segm(I, K, L, seed);
toc

figure(11)
subplot(1,3,1)
imagesc(I);
title('Original Picture');
axis off

subplot(1,3,2)
Inew = mean_segments(Iback, segm);
imagesc(Inew);
title(['Cluster = ', num2str(K), ' Iteration = ', num2str(L)]);
axis off

subplot(1,3,3)
I = overlay_bounds(Iback, segm);
imagesc(I);
title('Overlay');
axis off

imwrite(Inew,'bildat_lab3/result/kmeans1.png')
imwrite(I,'bildat_lab3/result/kmeans2.png')

