%% DD2423 Lab1, part 1
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

%% Test of combination of 2 points
clc
clear
pq = cat(3,  [5, 9], [9, 5], [17, 9], [17, 121], [5, 1], [125, 1]);
figure(1)
pairOfdata = [1, 2]; %!Change pair to play around!
Fhat = zeros(128, 128);
Fhat(pq(1, 1, pairOfdata(1)), pq(1, 2, pairOfdata(1))) = 1;
Fhat(pq(1, 1, pairOfdata(2)), pq(1, 2, pairOfdata(2))) = 1;
F = ifft2(Fhat);

Fhat1 = zeros(128, 128);
Fhat1(pq(1, 1, pairOfdata(1)), pq(1, 2, pairOfdata(1))) = 1;
F1 = ifft2(Fhat1);
Fhat2 = zeros(128, 128);
Fhat2(pq(1, 1, pairOfdata(2)), pq(1, 2, pairOfdata(2))) = 1;
F2 = ifft2(Fhat2);

Fabsmax = max(abs(F(:)));
subplot(3,3,1);
showgrey(Fhat);
title(['pair of pixel']);
subplot(3,3,2);
showgrey(Fhat1);
title(['original1: pixel', num2str(pq(1, 1:2, pairOfdata(1)))]);
subplot(3,3,3);
showgrey(Fhat);
title(['original2: pixel', num2str(pq(1, 1:2, pairOfdata(2)))]);
subplot(3,3,4);
showgrey(real(F), 64, -Fabsmax, Fabsmax)
title('real');
subplot(3,3,5);
showgrey(real(F1), 64, -Fabsmax, Fabsmax)
title('real1');
subplot(3,3,6);
showgrey(real(F2), 64, -Fabsmax, Fabsmax)
title('real2');
subplot(3,3,7);
showgrey(imag(F), 64, -Fabsmax, Fabsmax)
title('imaginary');
subplot(3,3,8);
showgrey(imag(F1), 64, -Fabsmax, Fabsmax)
title('imaginary1');
subplot(3,3,9);
showgrey(imag(F2), 64, -Fabsmax, Fabsmax)
title('imaginary2');

figure(2)
subplot(2, 2, 1);
showgrey(abs(F), 64, -Fabsmax, Fabsmax);
%showgrey(log(1 + abs(F)));
title(sprintf('abs(F) (amplitude)-magnitude?')); 
%abs(X) is the complex modulus (magnitude) of the elements of X.
subplot(2, 2, 2);
showgrey(angle(F), 64, -pi, pi);
title(sprintf('angle(F) (wavelength)-phase?'));
subplot(2, 2, 3);
showgrey(abs(Fhat), 64, -Fabsmax, Fabsmax);
%showgrey(log(1 + abs(F)));
title(sprintf('abs(Fhat) (amplitude)-magnitude?')); 
%abs(X) is the complex modulus (magnitude) of the elements of X.
subplot(2, 2, 4);
showgrey(angle(Fhat), 64, -pi, pi);
title(sprintf('angle(Fhat) (wavelength)-phase?'));

figure(3)
subplot(3,2,1)
surf(real(F1))
title('real of F1')
subplot(3,2,2)
surf(real(F2))
title('real of F2')
subplot(3,2,3)
surf(imag(F1))
title('imaginary of F1')
subplot(3,2,4)
surf(imag(F2))
title('imaginary of F2')
subplot(3,2,5)
surf(real(F))
title('real of F')
subplot(3,2,6)
surf(imag(F))
title('imaginary of F')

figure(4)
subplot(1,2,1)
surf(real(F))
title('real of F')
subplot(1,2,2)
surf(imag(F))
title('imaginary of F')

%% combination of several points
clc
clear
pq = cat(3, [1,1], [5, 9], [9, 5], [17, 9], [17, 121], [5, 1], [125, 1]);
numOfdata = [1, 2, 3, 4, 5, 6]; %!Change selected pixel to play around!
numOfdata = [1, 2, 3];
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
title('logFhat')
subplot(3, 3, 5);
showgrey(log(1 + abs(Ghat)));
title('logGhat')
subplot(3, 3, 6);
showgrey(log(1 + abs(Hhat)));
title('logHhat')

subplot(3, 3, 7);
showgrey(log(1 + abs(fftshift(Hhat))));
title('log fft shift')

subplot(3, 3, 8);
showgrey(log(1 + abs(fftshift(Fhat + 2 * Ghat))));
title('linearity: Fhat + 2 * Ghat')

% log figure
subplot(3, 3, 9);
plot(0:200, log([0:200]+1));
title('log(1+x)')

%surf(real(Ghat))
%% 1.5 Multiplication
clc
clear
figure(15)

F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';
subplot(2, 3, 1);
showgrey(F);
title('F')
subplot(2, 3, 2);
showgrey(G);
title('G')
subplot(2, 3, 4);
showgrey(F .* G);
title('pointwise multiplication')
subplot(2, 3, 5);
showfs(fft2(F .* G));%/128);
title('FFT of multiplication')

subplot(2, 3, 6)
Fhat = fft2(F)/128;
Ghat = fft2(G)/128;
Cs = conv2(fftshift(Fhat),fftshift(Ghat), 'same');
showfs(fftshift(Cs));
title('Conv in Fourier Domain')

% subplot(2,3,3)
% x = fftshift(Fhat);
% showfs(Fhat);

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
F = [ zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
    [ zeros(128, 48) ones(128, 32) zeros(128, 48)];
figure(16)
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
%saveas(gcf,'./plot/Lab1_1-6_Q11_fig.png','png');

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
title('log abs');

subplot( 5, 4, 3)
Fhat = fft2(F);
showfs(Fhat);
title('shifted');

subplot( 5, 4, 4)
showfs(Fhat);
title('log abs of rotate back');

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
%saveas(gcf,'./plot/Lab1_1-7_Q12_fig.png','png');

%% 1.7 plot
figure(17)

F = [ zeros(60, 128); ones(8, 128); zeros(60, 128)] .* ...
    [ zeros(128, 48) ones(128, 32) zeros(128, 48)];
subplot( 2, 3, 1)
showgrey(F);
title('Original')

% subplot( 5, 3, 2)
% Fhat = fft2(F);
% showgrey(log(1 + abs(Fhat)));
% title('log abs');

subplot( 2, 3, 2)
Fhat = fft2(F);
showfs(Fhat);
title('Frequency Domain');

subplot( 2, 3, 3)
showfs(Fhat);
title('log abs of rotating back');

i = 1;
for alpha = 30
    i = i + 3;
    subplot( 2, 3, i)
    G = rot(F, alpha);
    showgrey(G)
    title(['Rotate', num2str(alpha),'degrees']);
    %axis on

%     subplot( 5, 3, i+1)
     Ghat = fft2(G);
%     showgrey(log(1 + abs(Ghat)));
%     %title('log abs of Ghat');
    
    subplot( 2, 3, i+1)
    Fhat = fft2(G);
    showfs(Ghat);
    %title('showfs');

    Hhat = rot(fftshift(Ghat), -alpha );
    subplot( 2, 3, i+2)
    showgrey(log(1 + abs(Hhat)));
    %title('log abs of shift back');
end
%saveas(gcf,'./plot/Lab1_1-7_Q12_fig2.png','png');

%% 1.8 Information in Fourier phase and magnitude
clc
clear
img = cat(3, phonecalc128, few128, nallo128);
a = 10^-10;

for i = 1 : size(img,3)
    F = img(:,:,i);
    figure(180+i)
    subplot(2, 3, 1);
    showgrey(F);
    title('Original Picture'); 
    
    Fhat = fft2(F);
    Fabsmax = max(abs(F(:)));
    subplot(2, 3, 2);
    showgrey(abs(Fhat), 64, -Fabsmax, Fabsmax);
    showgrey(log(1 + abs(Fhat)));
    title(sprintf('abs(Fhat)')); 
    %abs(X) is the complex modulus (magnitude) of the elements of X.
    
    subplot(2, 3, 3);
    showgrey(pow2image(F, a));
    title(sprintf('pow2image')); 
    
    subplot(2, 3, 5);
    showgrey(angle(Fhat), 64, -pi, pi);
    title(sprintf('angle(Fhat)'));
    
    subplot(2, 3, 6);
    showgrey(randphaseimage(F));
    title(sprintf('randphaseimage'));
    
end

%% 1.8 Plot
clc
clear
img = cat(3, phonecalc128, few128, nallo128);
a = 10^-10;

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

saveas(gcf,'./plot/Lab1_1-8_Q13_fig.png','png');

