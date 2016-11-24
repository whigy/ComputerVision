%% Part 1. Different operators
clc
clear

tools = few256;

sdo_x = [-1, 0, 1];
sdo_y = sdo_x';

cdo_x = sdo_x ./2;
cdo_y = sdo_y ./2;

robert_x = [-1, 0;
             0, 1];
robert_y = [0, -1;
            1, 0];
        
sobel_x = [
    -1 0 1
    -2 0 2
    -1 0 1];
sobel_y = sobel_x';

name_list = {'sdo', 'cdo', 'robert', 'sobel'};
%threshold = [400, 150, 250, 900];

figure(11)
for i = 1 : length(name_list)
    subplot(2, 4, i)
    dxtools = conv2(tools, eval([name_list{i},'_x']), 'valid');
    size(dxtools)
    showgrey(dxtools);
    title([name_list{i},'_x']);
    
    subplot(2, 4, i+4)
    dytools = conv2(tools, eval([name_list{i},'_y']), 'valid');
    showgrey(dytools);
    title([name_list{i},'_y']);
end

%% Part 2. Point-wise thresholding of gradient magnitudes
% Magnitude using different operators
clc
clear

tools = few256;
figure(21)
name_list = {'sdo', 'cdo', 'robert', 'sobel'};
for i = 1 : length(name_list)
    subplot(2, 4, i)
    pixels  = Lv(tools, name_list{i});
    threshold = 0.1 * max(max(pixels));
    showgrey((pixels - threshold) > 0);
    %showgrey((gradmagntools - threshold(i)) > 0)
    title([name_list{i},' threshold = ', num2str(threshold)]);
    
    subplot(2, 4, i+4)
    threshold = 0.15 * max(max(pixels));
    showgrey((pixels - threshold) > 0);
    %showgrey((gradmagntools - threshold(i)) > 0)
    title([name_list{i},' threshold = ', num2str(threshold)]);
end
    
%% Sobel Magnitude

sobel_x = [
    -1 0 1
    -2 0 2
    -1 0 1];
sobel_y = sobel_x';


figure(22)

subplot(2, 3, 1)
dxtools = conv2(tools, sobel_x, 'valid');
showgrey(dxtools);
title('sobel_x');

subplot(2, 3, 2)
dytools = conv2(tools, sobel_y, 'valid');
showgrey(dytools);
title('sobel_y');

gradmagntools = sqrt(dxtools .^2 + dytools .^2);
subplot(2, 3, 3)
showgrey(gradmagntools);
title('magnitude');

threshold_list = [0.05, 0.1, 0.15];
for j = 4:6
    subplot(2, 3, j)
    threshold = threshold_list(j-3) * max(max(gradmagntools))
    showgrey((gradmagntools - threshold) > 0)
    title(['threshold = ', num2str(threshold)]);
end

%% sobel magnitue for godthem256, with smooth
clc
clear
figure(23)
tools = godthem256;
pixels  = Lv(tools, 'sobel');

subplot(2, 4, 1)
showgrey(pixels);
title('magnitude')

threshold_list = [0.1, 0.15, 0.2];
for j = 2:4
    subplot(2, 4, j)
    threshold = threshold_list(j-1) * max(max(pixels))
    showgrey((pixels - threshold) > 0)
    title(['threshold = ', num2str(threshold)]);
    
    subplot(2, 4, j+4)
    smooth = gaussfft(pixels, 0.5);
    showgrey((smooth - threshold) > 0)
    title('smooth with var = 0.5');
end





