clc
clear

scale_factor = 0.5;          % image downscale factor
area = [ 80, 110, 570, 300 ]; % image region to train foreground with
K = 16;                      % number of mixture components
alpha = 8;                 % maximum edge cost
sigma = 10;                % edge cost decay factor

I = imread('tiger1.jpg'); % 340*616*3
I = imresize(I, scale_factor); % 170*308*3
Iback = I;
area = int16(area*scale_factor); % rescale area to downsampled image
[ segm, prior ] = graphcut_segm(I, area, K, alpha, sigma);

Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
imwrite(Inew,'bildat_lab3/result/graphcut1.png')
imwrite(I,'bildat_lab3/result/graphcut2.png')
imwrite(prior,'bildat_lab3/result/graphcut3.png')
subplot(2,2,1); imshow(Inew);
subplot(2,2,2); imshow(I);
subplot(2,2,3); imshow(prior);
