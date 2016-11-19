%% DD2423 Lab1
clc
clear
%% 1.3 Basis functions
pq = cat(3, [5, 9], [9, 5], [17, 9], [17, 121], [5, 1], [125, 1]);%!Change pixel to play around!
for i = 1 : size(pq, 3);
    u = pq(1, 1, i);
    v = pq(1, 2, i);
    sz = 128;
    figure(i);
    fftwave(u, v, sz);
    % saveas(gcf,['./plot/Lab1_1.3_Q1_fig', num2str(i),'.png'],'png');
    
    figure(10+i)
    Fhat = zeros(sz);
    Fhat(u, v) = 1;
    F = ifft2(Fhat);
    Fabsmax = max(abs(F(:)));
    subplot(1,2,1)
    surf(real(F))
    title('real of F')
    subplot(1,2,2)
    surf(imag(F))
    title('imaginary of F')
    % saveas(gcf,['./plot/Lab1_1.3_Q1_fig', num2str(i),'-wave.png'],'png');
end

%% 1.3. Combination of several points
clc
clear
pq = cat(3, [5, 9], [9, 5], [17, 9], [17, 121], [5, 1], [125, 1]);
pq = cat(3, [1,1], [4, 1], [126, 1], [5, 9]);
numOfdata = [1, 2, 3, 4, 5, 6]; %!Change selected pixel to play around!
numOfdata = [1,2,3];
Fhat = zeros(128, 128);
for i = 1 : length(numOfdata)
    Fhat(pq(1, 1, numOfdata(i)), pq(1, 2, numOfdata(i))) = 1;
end
F = ifft2(Fhat);

subplot(3, 2, 1);
showgrey(Fhat);
title('Fhat')
Fabsmax = max(abs(F(:)));
subplot(3, 2, 2);
showgrey(fftshift(Fhat));
title(sprintf('centered Fhat'))
subplot(3, 2, 3);
showgrey(real(F), 64, -Fabsmax, Fabsmax);
title('real(F)')
subplot(3, 2, 4);
showgrey(imag(F), 64, -Fabsmax, Fabsmax);
title('imag(F)')
subplot(3, 2, 5);
showgrey(abs(F), 64, -Fabsmax, Fabsmax);
title(sprintf('abs(F) (amplitude)'))
subplot(3, 2, 6);
showgrey(angle(F), 64, -pi, pi);
title(sprintf('angle(F) (wavelength)'))

figure(2)
surf(real(F))

%% 1.3 illustration of fftshift
pic = deltafcn(128, 128);
t = 400;
[xsize ysize] = size(pic);
[x y] = meshgrid(-xsize/2 : xsize/2-1, -ysize/2 : ysize/2-1);
gaussf = (1 / (2 * pi * t)) * exp (- (x .* x + y .* y) ./ (2 * t));
figure(3)
subplot(1,2,1)
showgrey(fftshift(gaussf))
title('Before fftshift')

subplot(1,2,2)
showgrey(gaussf)
title('fftshift')


%% 1.4 Linearity
clc
clear

figure(1)
F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';
H = F + 2 * G;

subplot(3, 3, 1);
showgrey(F);
title('F')
subplot(3, 3, 2);
showgrey(G);
title('G')
subplot(3, 3, 3);
showgrey(H);
title('H')

Fhat = fft2(F);
Ghat = fft2(G);
Hhat = fft2(H);

subplot(3, 3, 4);
showgrey(log(1 + abs(Fhat)));
title('log absFhat')
subplot(3, 3, 5);
showgrey(log(1 + abs(Ghat)));
title('log absGhat')
subplot(3, 3, 6);
showgrey(log(1 + abs(Hhat)));
title('log absHhat')

subplot(3, 3, 7);
showgrey(log(1 + abs(fftshift(Hhat))));
title('log abs fftshiftHhat')

% Test the linearity property
Hhat2 = Fhat + 2*Ghat;

subplot(3, 3, 8);
showgrey(log(1 + abs(fftshift(Hhat2))));
title('log abs fftshiftHhat (via linearity)')

% Sum of exponentials
N = 128;
vector1 = zeros(1,N);
vv = 10;
for i=1:128
    a = cos((2*pi*(i-1)*vv)/N);
    b = -sin((2*pi*(i-1)*vv)/N);
    vector1(1,i) = complex(a,b);
end
disp(sum(vector1))

% DISPLAY THE IMAGES WITHOUT APPLYING LOG?

%% 1.5 Multiplication
clc
clear

F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';
Fhat = fft2(F)/128;
Ghat = fft2(G)/128;
convFFT = fftshift(conv2(fftshift(Fhat), fftshift(Ghat), 'same'));
FxGhat = fft2(F .* G);

figure(1)
subplot(2, 3, 1);
showgrey(F);
title('F')
subplot(2, 3, 2);
showgrey(G);
title('G')
subplot(2, 3, 3)
showgrey(F .* G);
title('FxG')
subplot(2, 3, 4)
showfs(FxGhat);
title('log abs fftshift (FxG)hat', 'FontSize', 8)
subplot(2, 3, 5)
showfs(convFFT);
title('log abs fftshift Fhat*Ghat', 'FontSize', 8)

% Multiplication in Fourier domain X convolution in spatial domain
Fext = [F, F, F; F, F, F; F, F, F];
CONVbig = conv2(Fext, G, 'same');
CONVsmall = CONVbig(129:256,129:256);
CONVhat = fft2(CONVsmall)/(128*128);
Fhat = fft2(F)/128;
Ghat = fft2(G)/128;
MULT = Fhat .* Ghat;

figure(2)
subplot(2, 3, 1)
showfs(Fhat);
title('log abs fftshift Fhat', 'FontSize', 8)
subplot(2, 3, 2)
showfs(Ghat);
title('log abs fftshift Ghat', 'FontSize', 8)
subplot(2, 3, 3)
showfs(MULT);
title('log abs fftshift FhatxGhat', 'FontSize', 8)
subplot(2, 3, 4)
showgrey(CONVsmall);
title('F * G')
subplot(2, 3, 5)
showfs(CONVhat);
title('log abs fftshift (F * G)hat', 'FontSize', 8)
%% 1.6 Scaling
clc
clear

F = [ zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
   [ zeros(128, 48) ones(128, 32) zeros(128, 48)];

subplot(2, 2, 1);
showgrey(F);
title('Pattern 1');

subplot(2, 2, 2);
showfs(fft2(F));
title('Magnitude 1')

subplot(2, 2, 3);
P2 = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = P2';
showgrey(P2 .* G);
title('Pattern 2')

subplot(2, 2, 4);
showfs(fft2(P2 .* G));
title('Magnitude 2')

%% 1.7 Rotation
figure(17)

F = [ zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
   [ zeros(128, 48) ones(128, 32) zeros(128, 48)];
subplot( 5, 4, 1)
showgrey(F);
title('Original')

subplot( 5, 4, 2)
Fhat = fft2(F);
showgrey(log(1 + abs(Fhat)));
title('log abs Fhat');

subplot( 5, 4, 3)
Fhat = fft2(F);
showfs(Fhat);
title('shifted');

subplot( 5, 4, 4)
showfs(Fhat);
title('rotated back');

i = 1;
for alpha = [30, 45, 60, 90]
   i = i + 4;
   subplot( 5, 4, i)
   G = rot(F, alpha);
   showgrey(G)
   title(['Rotate', num2str(alpha),'degrees']);
   %axis on

   subplot( 5, 4, i+1)
   Ghat = fft2(G);
   showgrey(log(1 + abs(Ghat)));
   %title('log abs of Ghat');
   
   subplot( 5, 4, i+2)
   Fhat = fft2(G);
   showfs(Ghat);
   %title('showfs');

   Hhat = rot(fftshift(Ghat), -alpha );
   subplot( 5, 4, i+3)
   showgrey(log(1 + abs(Hhat)));
   %title('log abs of shift back');
end

%% 1.8 Information in Fourier phase and magnitude
clc
clear
img = cat(3, phonecalc128, few128, nallo128);
a = 10^(-10);

for i = 1 : size(img,3)
    F = img(:,:,i);
    figure(180+i)
    
    subplot(2, 3, 1);
    showgrey(F);
    title('Original Picture'); 
    
    Fhat = fft2(F);
    Fabsmax = max(abs(F(:)));
    subplot(2, 3, 2);
    showgrey(log(1 + abs(fftshift(Fhat))))
    %showgrey(abs(fftshift(Fhat)))
    %showgrey(abs(Fhat), 64, -Fabsmax, Fabsmax);
    %showgrey(log(1 + abs(Fhat)));
    %title(sprintf('abs(Fhat)')); 
    title(sprintf('log abs fftshift Fhat'));
    %abs(X) is the complex modulus (magnitude) of the elements of X.
    
    subplot(2, 3, 3);
    showgrey(pow2image(F, a));
    title(sprintf('pow2image')); 
    
    subplot(2, 3, 5);
    showgrey(angle(fftshift(Fhat)), 64, -pi, pi)
    %showgrey(angle(Fhat), 64, -pi, pi);
    title(sprintf('angle(Fhat)'));
    
    subplot(2, 3, 6);
    showgrey(randphaseimage(F));
    title(sprintf('randphaseimage'));
    
end

%% 1.8 Plot reconstructions
clc
clear
img = cat(3, phonecalc128, few128, nallo128);
a = 10^(-10);

for i = 1 : size(img,3)
    F = img(:,:,i);
    figure(18);
    subplot(3, 3, (i-1)*3+1);
    showgrey(F);
    title('Original Picture');
    
    subplot(3, 3, (i-1)*3+2);
    showgrey(pow2image(F, a));
    title(sprintf('pow2image')); 
    
    subplot(3, 3, (i-1)*3+3);
    showgrey(randphaseimage(F));
    title(sprintf('randphaseimage'));
    
end

%saveas(gcf,'./plot/Lab1_1-8_Q13_fig.png','png');

%% 1.8 Plot amplitude and phase
clc
clear
img = cat(3, phonecalc128, few128, nallo128);
a = 10^(-10);

for i = 1 : size(img,3)
    F = img(:,:,i);
    figure(18);
    subplot(3, 3, (i-1)*3+1);
    showgrey(F);
    title('Original Picture'); 
    
    Fhat = fft2(F)/128;
    Fabsmax = max(abs(F(:)));
    subplot(3, 3, (i-1)*3+2);
    showgrey(log(1 + abs(fftshift(Fhat))))
    title(sprintf('log Fourier spectrum'));
    
    subplot(3, 3, (i-1)*3+3);
    showgrey(angle(fftshift(Fhat)), 64, -pi, pi)
    title(sprintf('Phase angle'));
    
end

%saveas(gcf,'./Figures/Lab1_1-8.png','png');