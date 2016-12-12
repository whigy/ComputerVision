%% part 3 Mean shift
%% Test different spatial and color bandwidths
clc
clear

scale_factor = 0.5;                      % image downscale factor
spatial_bandwidth = [3.0, 4.0, 6.0];     % spatial bandwidth
colour_bandwidth = [3.0, 4.0, 6.0];      % colour bandwidth
spatial_bandwidth = [3.0, 8.0, 13.0];     % spatial bandwidth
colour_bandwidth = [3.0, 8.0, 13.0];      % colour bandwidth
num_iterations = 40;                     % number of mean-shift iterations
image_sigma = 1.0;                       % image preblurring scale
images = {'orange.jpg', 'tiger1.jpg', 'tiger2.jpg', 'tiger3.jpg'};
images = {'tiger1.jpg'};

for u = 1 : length(images)
    tic
    figure(15 + u)
    I = imread(images{u});
    I = imresize(I, scale_factor);
    Iback = I;
    d = 2*ceil(image_sigma*2) + 1;
    h = fspecial('gaussian', [d d], image_sigma);
    I = imfilter(I, h);
    for i = 1 : length(spatial_bandwidth)
        for j = 1 : length(colour_bandwidth)
            subplot(length(colour_bandwidth), length(spatial_bandwidth), (j-1)*length(spatial_bandwidth) + i)
            segm = mean_shift_segm(I, spatial_bandwidth(i), colour_bandwidth(j), num_iterations);
            Inew = mean_segments(Iback, segm);
            I = overlay_bounds(Iback, segm);
            %imshow(I)
            imshow(Inew)
            title(['SpatialBandwidth = ', num2str(spatial_bandwidth(i)), ', ColorBandwidth = ', num2str(colour_bandwidth(j))]);
        end
    end
    toc
end