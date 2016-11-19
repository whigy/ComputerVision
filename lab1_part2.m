%% DD2423 Lab1, part 2 & 3
clc
clear

%% 2.3 Filtering procedure
variance_t = [0.1, 0.3, 1.0, 10.0, 100.0]; %test correspond to Q14 & Q15
%variance_t = [1.0, 4.0, 16.0, 64.0, 256.0]; %test correspond to Q16
%variance_t = [256.0, 500, 1000];
s_t = length(variance_t);

figure(23)
subplot(2 , 3 , 1);
showgrey(deltafcn(128, 128));
title('original :deltafcn');
j = 2;
for t = variance_t
    disp(['variance = ', num2str(t)]);
    psf = gaussfft(deltafcn(128, 128), t);
    psf = discgaussfft(deltafcn(128, 128), t); % Method of the first one.
    %What's the difference???
    subplot(2 , 3, j);
    j  = j + 1;
    variance(psf)
    showgrey(psf)
    title(['variance = ', num2str(t)]);
end

saveas(gcf,'./plot/Lab1_2-1_Q14_fig.png','png')

%% plot gaussian
variance_t = [0.1, 0.3, 1.0, 10.0, 100.0]; %test correspond to Q14 & Q15
variance_t = [1.0, 4.0, 16.0, 64.0, 256.0]; %test correspond to Q16
figure(230)
i = 1;
for t = variance_t
    subplot(2 , 3 , i);
    i = i +1;
    xsize = 128;
    ysize = 128;
    [x y] = meshgrid(-xsize/2 : xsize/2-1, -ysize/2 : ysize/2-1);
    gaussf = (1 / (2 * pi * t)) * exp (-(x .* x + y .* y) ./ (2 * t));
    surf(gaussf);
    colormap;
    title(['variance = ', num2str(t)]);
end
saveas(gcf,'./plot/Lab1_2-1_Q15_fig.png','png')


%%
t = 256
xsize = 128;
ysize = 128;
[x y] = meshgrid(-xsize/2 : xsize/2-1, -ysize/2 : ysize/2-1);
gaussf = (1 / (2 * pi * t)) * exp (-(x .* x + y .* y) ./ (2 * t));
gaussf = rawsubsample(gaussf);
subplot(2,2,1)
showgrey(gaussf);
colormap;
title(['variance = ', num2str(t)]);

subplot(2,2,2)
gFhat = fft2(gaussf);
surf(fftshift(gFhat));

subplot(2,2,3)
gaussf_ide = ideal(gaussf, 10);
gaussf_ide = rawsubsample(gaussf_ide)
showgrey(gaussf_ide);

subplot(2,2,4)
gFhat_ide = fft2(gaussf_ide);
surf(fftshift(gFhat_ide));


