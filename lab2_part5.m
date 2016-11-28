%% Part 5 Extraction of edge segments
clc
clear

%% tools 
%Nice : scale = 6 & threshold  = 4
inpic = few256;
scale = [1.0, 4.0, 16.0, 64.0];
threshold = [1, 4, 15];
scale = [6, 8];
threshold = [4];
shape = 'same';

figure(51)
for i = 1 : length(scale)
    for j = 1 : length(threshold)
        subplot(length(threshold), length(scale), (j-1)*length(scale)+i)
        edgecurves = extractedge(inpic, scale(i), threshold(j), shape);
        overlaycurves(inpic, edgecurves);
        title(['scale = ', num2str(scale(i)), ', threshold = ', num2str(threshold(j))]);
    end
end

%% house
% Nice: scale = threshold  = 5
inpic = godthem256;
scale = [5.0, 13.0, 16];
threshold = [1, 4, 5];
shape = 'same';

figure(51)
for i = 1 : length(scale)
    for j = 1 : length(threshold)
        subplot(length(threshold), length(scale), (j-1)*length(scale)+i)
        edgecurves = extractedge(inpic, scale(i), threshold(j), shape);
        overlaycurves(inpic, edgecurves);
        title(['scale = ', num2str(scale(i)), ', threshold = ', num2str(threshold(j))]);
    end
end