%% Part 2. Point-wise thresholding of gradient magnitudes
% Magnitude using different operators
clc
clear

tools = few256;
figure(21)
name_list = {'sdo', 'cdo', 'robert', 'sobel'};
for i = 1 : length(name_list)
    subplot(2, 4, i)
    pixels= Lv(tools, name_list{i});
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
    subplot(1, 3, j)
    threshold = threshold_list(j-3) * max(max(gradmagntools))
    showgrey((gradmagntools - threshold) > 0)
    title(['threshold = ', num2str(threshold)]);
end

%% sobel magnitude for godthem256, with smooth
%smooth the gradient
clc
clear
figure(23)
tools = godthem256;
pixels  = Lv(tools, 'sobel');
pixels2 = Lv(discgaussfft(tools, 0.5), 'sobel');

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
    threshold2 = threshold_list(j-1) * max(max(pixels2))
    showgrey((pixels2 - threshold2) > 0)
    title('smooth with var = 0.5');
end

%% sobel magnitue for godthem256, with smooth (more detailed experiment)
clc
clear
figure(23)
tools = godthem256;

subplot(2, 4, 1)
showgrey(tools)
title('ORIGINAL (1)')

pixels  = Lv(tools, 'sobel');
var = 0.8;
smooth = discgaussfft(tools, var);
pixels2 = Lv(smooth, 'sobel');

subplot(2, 4, 2)
showgrey(pixels);
title('gradient magn (1)')

subplot(2, 4, 5)
showgrey(smooth);
title(['SMOOTHED var = ', num2str(var), ' (2)'])

subplot(2, 4, 6)
showgrey(pixels2);
title('gradient magn (2)')

threshold_list = [0.15, 0.17];
threshold_list2 = [0.1, 0.12];
for j = 3:4
    subplot(2, 4, j)
    threshold = threshold_list(j-2) * max(max(pixels))
    showgrey((pixels - threshold) > 0)
    title(['threshold = ', num2str(threshold), ' (1)']);
    
    subplot(2, 4, j+4)
    threshold2 = threshold_list2(j-2) * max(max(pixels2))
    showgrey((pixels2 - threshold2) > 0)
    title(['threshold = ', num2str(threshold2), ' (2)']);
end