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
    dxtools = conv2(tools, eval([name_list{i},'_x']), 'same');
    showgrey(dxtools);
    title([name_list{i},'_x']);
    
    subplot(2, 4, i+4)
    dytools = conv2(tools, eval([name_list{i},'_y']), 'same');
    showgrey(dytools);
    title([name_list{i},'_y']);
end






