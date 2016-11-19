% DD2423 Lab1, part 2 & 3
%% 2.3 Filtering procedure - Display convolutions
clc
clear

variance_t = [0.1, 0.3, 1.0, 10.0, 100.0]; %test correspond to Q14 & Q15
variance_t = [1.0, 4.0, 16.0, 64.0, 256.0]; %test correspond to Q16

s_t = length(variance_t);

figure(23)
subplot(2 , 3 , 1);
showgrey(deltafcn(128, 128));
title('original :deltafcn');
j = 2;
for t = variance_t
    disp(['variance = ', num2str(t)]);
    psf = lab1_gaussfft(deltafcn(128, 128), t);
    %psf = discgaussfft(deltafcn(128, 128), t); % Method of the first one.
    %What's the difference???
    subplot(2 , 3, j);
    j  = j + 1;
    variance(psf)
    showgrey(psf)
    title(['variance = ', num2str(t)]);
end

saveas(gcf,'./Figures/Lab1_2-1_Q14_fig.png','png')

%% 2.3 Filtering procedure - Compare discrete kernel, convolution and discgaussfft
clc
clear

variance_t = [0.1, 0.3, 1.0, 10.0, 100.0]; %test correspond to Q14 & Q15
%variance_t = [1.0, 4.0, 16.0, 64.0, 256.0]; %test correspond to Q16

s_t = length(variance_t);

figure(23)
%subplot(2 , 3 , 1);
%showgrey(deltafcn(128, 128));
%title('original :deltafcn');
%j = 2;
for i = 1:size(variance_t,2)
    % Plot discrete kernel
    subplot(5, 3, (i-1)*3+1);
    [x y] = meshgrid(-128/2 : 128/2-1, -128/2 : 128/2-1);
    gaussf = (1 / (2 * pi * variance_t(i))) * exp (- (x .* x + y .* y) ./ (2 * variance_t(i)));
    showgrey(gaussf)
    title('disc kernel')
    
    subplot(5, 3, (i-1)*3+2);
    psf = lab1_gaussfft(deltafcn(128, 128), variance_t(i));
    showgrey(psf)
    title('conv with impulse')
    
    subplot(5, 3, (i-1)*3+3);
    psf2 = discgaussfft(deltafcn(128, 128), variance_t(i));
    showgrey(psf2)
    title('conv with impulse (discgaussfft)')
end

saveas(gcf,'./Figures/Lab1_2-1_Q14_figcomp.png','png')

%% 2.3. Plot gaussian kernels
clc
clear

variance_t = [0.1, 0.3, 1.0, 10.0, 100.0]; %test correspond to Q14 & Q15
%variance_t = [1.0, 4.0, 16.0, 64.0, 256.0]; %test correspond to Q16
figure(230)
i = 1;
for t = variance_t
    subplot(2 , 3 , i);
    i = i +1;
    xsize = 128;
    ysize = 128;
    [x y] = meshgrid(-xsize/2 : xsize/2-1, -ysize/2 : ysize/2-1);
    gaussf = (1 / (2 * pi * t)) * exp (- (x .* x + y .* y) ./ (2 * t));
    surf(gaussf);
    colormap;
    title(['variance = ', num2str(t)]);
end
saveas(gcf,'./Figures/Lab1_2-1_Q15_fig.png','png')

%% 2.3 Blur images with Gaussian filter
clc
clear
img = cat(3, phonecalc128, few128, nallo128);
variance_t = [1.0, 4.0, 16.0, 64.0, 256.0];

for i = 1:size(img,3) 
figure(23+i)
F = img(:,:,i);
subplot(2, 3, 1);
showgrey(F);
title('Original Picture'); 
j = 2;
for t = variance_t
    disp(['variance = ', num2str(t)]);
    psf = lab1_gaussfft(F, t);
    %psf = discgaussfft(F, t); % Method of the first one.
    subplot(2 , 3, j);
    j  = j + 1;
    variance(psf)
    showgrey(psf)
    title(['variance = ', num2str(t)]);
end
end
