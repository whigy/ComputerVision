%% part 2 K-means
%% Results of changing area of background
clc
clear

scale_factor = 0.5;          % image downscale factor
area = [ 80, 110, 570, 300 ;... % image region to train foreground with
         20,  30, 600, 320 ;... % Too many background
         120,170, 400, 200]     % Too little background
K = 16;                      % number of mixture components
alpha = 8.0;                 % maximum edge cost
sigma = 10.0;                % edge cost decay factor

I = imread('tiger1.jpg'); % 340*616*3
I = imresize(I, scale_factor); % 170*308*3
Iback = I;
area = int16(area*scale_factor); % rescale area to downsampled image

figure(51)
for i = 1 : size(area, 1)
    a = area(i, :)
    [ segm, prior ] = graphcut_segm(I, a, K, alpha, sigma);
    
    [h,w,c] = size(I);
    dw = a(3) - a(1) + 1;
    dh = a(4) - a(2) + 1;
    mask = uint8([zeros(a(2)-1,w); zeros(dh,a(1)-1), ones(dh,dw), ...
	zeros(dh,w-a(3)); zeros(h-a(4),w)]); 
    
    subplot(3,3,i); imagesc(mask); axis off
    title(['initial mask :area = ', num2str(a(1)), ' ', num2str(a(2)), ' ', num2str(a(3)), ' ', num2str(a(4))]);
    Inew = mean_segments(Iback, segm);
    Iover = overlay_bounds(Iback, segm);

    subplot(3,3,i+3); imshow(Inew);
    subplot(3,3,i+6); imshow(Iover);
    %subplot(2,2,3); imshow(prior);
end

%% Results of changing alpha and sigma
clc
clear

scale_factor = 0.5;          % image downscale factor
area = [ 80, 110, 570, 300 ] % image region to train foreground with
K = 16;                      % number of mixture components
alpha = [4, 8, 15];                 % maximum edge cost
sigma = [5, 10.0, 15];                % edge cost decay factor

I = imread('tiger1.jpg'); % 340*616*3
I = imresize(I, scale_factor); % 170*308*3
Iback = I;
area = int16(area*scale_factor); % rescale area to downsampled image

figure(52)
for i = 1 : length(alpha)
    for j = 1 : length(sigma)
        [ segm, prior ] = graphcut_segm(I, area, K, alpha(i), sigma(j));
        Ilay = overlay_bounds(Iback, segm);
        subplot(length(alpha),length(sigma),j + (i-1) * length(sigma)); imshow(Ilay);
        title(['alpha = ', num2str(alpha(i)), ' sigma = ', num2str(sigma(j))]);
    end
end

%% Results of changing K
clc
clear

scale_factor = 0.5;          % image downscale factor
area = [ 80, 110, 570, 300 ]; % image region to train foreground with
K = [2, 3, 4, 5, 6, 8];                      % number of mixture components
alpha = 8.0;                 % maximum edge cost
sigma = 10.0;                % edge cost decay factor

I = imread('tiger1.jpg'); % 340*616*3
I = imresize(I, scale_factor); % 170*308*3
Iback = I;
area = int16(area*scale_factor); % rescale area to downsampled image

figure(53)
for i = 1 : length(K)
    [ segm, prior ] = graphcut_segm(I, area, K(i), alpha, sigma);
    Ilay = overlay_bounds(Iback, segm);
    subplot(3, 2, i); imshow(Ilay);
    title(['K = ', num2str(K(i))]);
end

