%% part 2 K-means
%% Results of K-means
clc
clear
kmeans_example

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
