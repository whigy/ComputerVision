%% Part 4 - NormCut
%% Display one result
colour_bandwidth = 20.0; % color bandwidth
radius = 4;              % maximum neighbourhood distance
ncuts_thresh = 0.2;      % cutting threshold
min_area = 200;          % minimum area of segment
max_depth = 2;           % maximum splitting depth
scale_factor = 0.4;      % image downscale factor
image_sigma = 2.0;       % image preblurring scale

I = imread('tiger2.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

segm = norm_cuts_segm(I, colour_bandwidth, radius, ncuts_thresh, min_area, max_depth);
Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
figure(100)
subplot(1,2,1)
imshow(Inew)
subplot(1,2,2)
imshow(I)
imwrite(Inew,'bildat_lab3/result/normcuts1.png')
imwrite(I,'bildat_lab3/result/normcuts2.png')

%% Analyze effect of color bandwidth
colour_bandwidth = 20.0; % color bandwidth
radius = 4;              % maximum neighbourhood distance
ncuts_thresh = 0.2;      % cutting threshold
min_area = 200;          % minimum area of segment
max_depth = 2;           % maximum splitting depth
scale_factor = 0.4;      % image downscale factor
image_sigma = 2.0;       % image preblurring scale

I = imread('tiger2.jpg');
I = imresize(I, scale_factor);
Iback = I;
d = 2*ceil(image_sigma*2) + 1;
h = fspecial('gaussian', [d d], image_sigma);
I = imfilter(I, h);

segm = norm_cuts_segm(I, colour_bandwidth, radius, ncuts_thresh, min_area, max_depth);
Inew = mean_segments(Iback, segm);
I = overlay_bounds(Iback, segm);
figure(100)
subplot(1,2,1)
imshow(Inew)
subplot(1,2,2)
imshow(I)
imwrite(Inew,'bildat_lab3/result/normcuts1.png')
imwrite(I,'bildat_lab3/result/normcuts2.png')