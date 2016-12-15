%% Part 4 - NormCut
%% Display one result
colour_bandwidth = 20.0; % color bandwidth
radius = 3;              % maximum neighbourhood distance
ncuts_thresh = 0.2;      %%% cutting threshold
min_area = 50;            %%% minimum area of segment
max_depth = 6;           %%% maximum splitting depth
scale_factor = 0.4;      % image downscale factor
image_sigma = 2.0;       % image preblurring scale

I = imread('tiger1.jpg');
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

%% Analyze effect of ncuts_thresh (freeze other parameters and vary the analyzed parameter)
colour_bandwidth = 20.0; % color bandwidth
radius = 3;              % maximum neighbourhood distance
ncuts_thresh = [0.01, 0.2];      % cutting threshold
min_area = 200;          % minimum area of segment
max_depth = 8;           % maximum splitting depth
scale_factor = 0.4;      % image downscale factor
image_sigma = 2.0;       % image preblurring scale

% Pick two images
images = {'tiger1.jpg', 'tiger2.jpg'};
figure(75)
for u = 1 : length(images)
    tic
    for j = 1: length(ncuts_thresh)
        I = imread(images{u});
        I = imresize(I, scale_factor);
        Iback = I;
        d = 2*ceil(image_sigma*2) + 1;
        h = fspecial('gaussian', [d d], image_sigma);
        I = imfilter(I, h);
        
        segm = norm_cuts_segm(I, colour_bandwidth, radius, ncuts_thresh(j), min_area, max_depth);
        Inew = mean_segments(Iback, segm);
        I = overlay_bounds(Iback, segm);
        subplot(length(images), length(ncuts_thresh), (u-1)*length(ncuts_thresh) + j)
        %imshow(Inew)
        imshow(I)
        title(['Image = ', images{u}, ' , ncuts thresh = ', num2str(ncuts_thresh(j))]);
        
        %imwrite(Inew,'bildat_lab3/result/normcuts1.png')
        %imwrite(I,'bildat_lab3/result/normcuts2.png')
    end
    toc
end

%% Analyze effect of min_area (freeze other parameters and vary the analyzed parameter)
colour_bandwidth = 20.0; % color bandwidth
radius = 3;              % maximum neighbourhood distance
ncuts_thresh = 0.2;      % cutting threshold
min_area = [20, 200];          % minimum area of segment
max_depth = 8;           % maximum splitting depth
scale_factor = 0.4;      % image downscale factor
image_sigma = 2.0;       % image preblurring scale

% Pick two images
images = {'tiger1.jpg', 'tiger2.jpg'};
figure(75)
for u = 1 : length(images)
    tic
    for j = 1: length(min_area)
        I = imread(images{u});
        I = imresize(I, scale_factor);
        Iback = I;
        d = 2*ceil(image_sigma*2) + 1;
        h = fspecial('gaussian', [d d], image_sigma);
        I = imfilter(I, h);
        
        segm = norm_cuts_segm(I, colour_bandwidth, radius, ncuts_thresh, min_area(j), max_depth);
        Inew = mean_segments(Iback, segm);
        I = overlay_bounds(Iback, segm);
        subplot(length(images), length(min_area), (u-1)*length(min_area) + j)
        %imshow(Inew)
        imshow(I)
        title(['Image = ', images{u}, ' , min area = ', num2str(min_area(j))]);
        
        %imwrite(Inew,'bildat_lab3/result/normcuts1.png')
        %imwrite(I,'bildat_lab3/result/normcuts2.png')
    end
    toc
end

%% Analyze effect of radius (freeze other parameters and vary the analyzed parameter)
colour_bandwidth = 20.0; % color bandwidth
radius = [3, 10];              % maximum neighbourhood distance
ncuts_thresh = 0.2;      % cutting threshold
min_area = 50;          % minimum area of segment
max_depth = 6;           % maximum splitting depth
scale_factor = 0.4;      % image downscale factor
image_sigma = 2.0;       % image preblurring scale

% Pick two images
images = {'tiger1.jpg', 'tiger2.jpg'};
figure(75)
for u = 1 : length(images)
    tic
    for j = 1: length(radius)
        I = imread(images{u});
        I = imresize(I, scale_factor);
        Iback = I;
        d = 2*ceil(image_sigma*2) + 1;
        h = fspecial('gaussian', [d d], image_sigma);
        I = imfilter(I, h);
        
        segm = norm_cuts_segm(I, colour_bandwidth, radius(j), ncuts_thresh, min_area, max_depth);
        Inew = mean_segments(Iback, segm);
        I = overlay_bounds(Iback, segm);
        subplot(length(images), length(radius), (u-1)*length(radius) + j)
        %imshow(Inew)
        imshow(I)
        title(['Image = ', images{u}, ' , radius = ', num2str(radius(j))]);
        
        %imwrite(Inew,'bildat_lab3/result/normcuts1.png')
        %imwrite(I,'bildat_lab3/result/normcuts2.png')
    end
    toc
end