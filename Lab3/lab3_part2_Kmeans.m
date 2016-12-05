%% part 2 K-means
%% Results of K-means
clc
clear
kmeans_example

figure(11)
image = imread('orange.jpg');
image = im2double(image);
% %Let X be a set of pixels and V be a set of K cluster centers in 3D (R,G,B).
[m, n, d] = size(image);
X = reshape(image, m * n, d);
plot3( X(:, 1), X(:, 2), X(:, 3), 'y.');
hold on
plot3( centers(:, 1), centers(:, 2), centers(:, 3), 'b*');
hold off
title('centers')

figure(12)
subplot(1,3,1)
imagesc(image);
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


%%
clc
clear
figure(12)

K = [4, 8, 16];               % number of clusters used
L = [10, 20];              % number of iterations
seed = 14;           % seed used for random initialization
scale_factor = 1.0;  % image downscale factor % 1 = no scaling
image_sigma = 1.0;   % image preblurring scale

I = imread('orange.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

tic
for i = 1 : length(K)
    for j = 1 : length(L)
        size(L), size(K), (j-1)*size(K) + i
        subplot(length(L), length(K), (j-1)*length(K) + i)
        [ segm, centers ] = kmeans_segm(I, K(i), L(j), seed);
        Inew = mean_segments(Iback, segm);
        imagesc(Inew);
        title(['Cluster = ', num2str(K(i)), ' Iteration = ', num2str(L(j))]);
        axis off
    end
end
toc
