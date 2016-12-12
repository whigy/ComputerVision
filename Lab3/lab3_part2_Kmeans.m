%% part 2 K-means
%% Results of K-means (resize, blur, do k-means, mean_segments, overlay_bounds)
clc
clear

% Do K-means
kmeans_example

% Plot all pixels and centers
figure(11)
image = imread('orange.jpg');
image = im2double(image);
% %Let X be a set of pixels and V be a set of K cluster centers in 3D (R,G,B).
[m, n, d] = size(image);
Ximg = reshape(image, m * n, d);
Xsegm = reshape(segm, m * n, 1);
for k = 1 : K
    X = Ximg( Xsegm == k, :);
    plot3( X(:, 1), X(:, 2), X(:, 3), '.');
    hold on
end
plot3( centers(:, 1), centers(:, 2), centers(:, 3), 'k*', 'MarkerSize', 30);
hold off
title('centers')

% Plot results
figure(12)
subplot(1,3,1)
imagesc(img);
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


%% Test different K and L
clc
clear

%K = [4, 8, 16];      % number of clusters used
K = [4, 8, 25];      % number of clusters used
%L = [10, 20];        % number of iterations
L = [5, 30];        % number of iterations
seed = 14;           % seed used for random initialization
scale_factor = 1.0;  % image downscale factor % 1 = no scaling
image_sigma = 1.0;   % image preblurring scale
images = {'orange.jpg', 'tiger1.jpg', 'tiger2.jpg', 'tiger3.jpg'};

tic
for u = 1 : length(images)
    figure(15 + u)
    I = imread(images{u});
    I = imresize(I, scale_factor);
    Iback = I;
    d = 2*ceil(image_sigma*2) + 1;
    h = fspecial('gaussian', [d d], image_sigma);
    I = imfilter(I, h);
    for i = 1 : length(K)
        for j = 1 : length(L)
            subplot(length(L), length(K), (j-1)*length(K) + i)
            %[ segm, centers ] = kmeans_segm(I, K(i), L(j), seed, 0);
            [ segm, centers ] = kmeans_segm2(I, K(i), L(j), seed, 0);
            Inew = mean_segments(Iback, segm);
            imagesc(Inew);
            title(['Cluster = ', num2str(K(i)), ', Iteration = ', num2str(L(j))]);
            axis off
        end
    end
end
toc

%% Test different scale_factor and amount of pre-blurring
clc
clear


K = 8;                           % number of clusters used
L = 30;                          % number of iterations
seed = 14;                       % seed used for random initialization
scale_factor = [0.2, 0.5, 1.0]; % image downscale factor % 1 = no scaling
image_sigma = [1.0, 3.0];        % image preblurring scale
images = {'orange.jpg', 'tiger1.jpg', 'tiger2.jpg', 'tiger3.jpg'};

tic
for u = 1 : length(images)
    figure(15 + u)
    for i = 1 : length(scale_factor)
        for j = 1 : length(image_sigma)
        
            I = imread(images{u});
            I = imresize(I, scale_factor(i));
            Iback = I;
            d = 2*ceil(image_sigma(j)*2) + 1;
            h = fspecial('gaussian', [d d], image_sigma(j));
            I = imfilter(I, h);

            subplot(length(image_sigma), length(scale_factor), (j-1)*length(scale_factor) + i)
            %[ segm, centers ] = kmeans_segm(I, K, L, seed, 0);
            [ segm, centers ] = kmeans_segm2(I, K, L, seed, 0);
            Inew = mean_segments(Iback, segm);
            imagesc(Inew);
            title(['ScaleFactor = ', num2str(scale_factor(i)), ', sigma = ', num2str(image_sigma(j))]);
            axis off
        end
    end
end
toc

%% Analyze number of iterations L
clc
clear

K = 10;               % number of clusters used
seed = 14;           % seed used for random initialization
scale_factor = 1.0;  % image downscale factor % 1 = no scaling
image_sigma = 1.0;   % image preblurring scale
images = {'orange.jpg', 'tiger1.jpg', 'tiger2.jpg', 'tiger3.jpg'};
images = {'orange.jpg'};

tic
for u = 1 : length(images)
    I = imread(images{u});
    I = imresize(I, scale_factor);
    Iback = I;
    d = 2*ceil(image_sigma*2) + 1;
    h = fspecial('gaussian', [d d], image_sigma);
    I = imfilter(I, h);
    
    figure(20 + 5*u)
    [ segm, centers, L ] = kmeans_segm_stopCriterium(I, K, seed);
    title('error of centers');
    
    % Plot results
    figure(20 + 6*u)
    subplot(1,3,1)
    imagesc(im2double(Iback));
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
end
toc