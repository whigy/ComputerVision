%% Part 3-4 Computing differential geometry descriptors

%% test 1: on what's the difference using zero paddings for masks?
clc
clear
[x, y] = meshgrid(-5:5, -5:5);

dxmask = [-0.5, 0, 0.5];
dxmask = zeros(5, 5);
dxmask(3, 2:4) = [-0.5, 0, 0.5];
dymask = dxmask';


dxxmask = zeros(5, 5);
dxxmask(3, 2:4) = [1, -2, 1];
dyymask = dxxmask';

x
filter2(dxxmask, x .^3, 'valid')
filter2(dxxmask, x .^3, 'same')
dxxmask = [1, -2, 1];
filter2(dxxmask, x .^3, 'valid')
filter2(dxxmask, x .^3, 'same')
%Seems like no difference?

%% test 2: On the correctness of Lvv and Lvvv
clc
clear
[x, y] = meshgrid(-5:5, -5:5);

dxmask = [-0.5, 0, 0.5];
dxmask = zeros(5, 5);
dxmask(3, 2:4) = [-0.5, 0, 0.5];
dymask = dxmask';

dxxmask = zeros(5, 5);
dxxmask(3, 2:4) = [1, -2, 1];
dyymask = dxxmask';

dxxxmask = conv2(dxmask, dxxmask, 'same'); %conv? filter?
dxxymask = conv2(dxxmask, dymask, 'same');
dxyymask = conv2(dxmask, dyymask, 'same');
dyyymask = conv2(dymask, dyymask, 'same');

% delta(x)(x^n) = n * n * x ^ (n-1), where n = 3
disp('delta(x)(x^n) = n * n * x ^ (n-1), where n = 3:');
a = filter2(dxmask, x .^3, 'same')
disp('n * x ^ (n-1)');
b = 2 * x .^2
disp(['error for dxmask: ']);
a - b

% delta(x^n)(x^n) = n!, where n = 3
disp('delta(x^n)(x^n) = n!, where n = 3');
a = filter2(dxxxmask, x .^3, 'valid')
disp(['n ! = ', num2str(3 * 2 * 1)]);
disp(['error for dxxxmask: ']);
a - 3 * 2 * 1

% delta(x^(n+k))(x^n) = 0, where n = 2, k =1 ,n+k = 3
disp('delta(x^(n+k))(x^n) = 0, where n = 2, k =1')
filter2(dxxxmask, x .^2, 'valid')

% delta(x^(n+k))(y^k) = 0, where n = 2, k =1
disp('filter2(dxxymask, x .^3 ) :')
filter2(dxxymask, y, 'valid')

% Conclusion: Correct

%% test 3: On what if we use fliter2 instead of conv2
figure(401)
tools = few256;
% subplot(2,3,1)
% showgrey(tools)
% title('origin')

subplot(2,2,1)
pixels = Lvvtilde(discgaussfft(tools, 20));
contour(pixels)
axis('image');
axis('ij');
title('2nd deri. with conv2')

subplot(2,2,3)
pixels = Lvvtilde_filter(discgaussfft(tools, 20));
contour(pixels)
axis('image');
axis('ij');
title('2nd deri. with filter2')

subplot(2,2,2)
pixels = Lvvvtilde(discgaussfft(tools, 20));
contour(pixels)
axis('image');
axis('ij');
title('3nd deri. with conv2')

subplot(2,2,4)
pixels = Lvvvtilde_filter(discgaussfft(tools, 20));
contour(pixels)
axis('image');
axis('ij');
title('3nd deri. with filter2')

%%
clc
clear

figure(402)
house = godthem256;
% subplot(2,3,1)
% showgrey(house)
% title('origin')

subplot(2,2,1)
pixels = Lvvtilde(discgaussfft(house, 10), 'same');
contour(pixels)
axis('image');
axis('ij');
title('2nd deri. with conv2')

subplot(2,2,3)
pixels = Lvvtilde_filter(discgaussfft(house, 10));
contour(pixels)
axis('image');
axis('ij');
title('2nd deri. with filter2')

subplot(2,2,2)
pixels = Lvvvtilde(discgaussfft(house, 10));
contour(pixels)
axis('image');
axis('ij');
title('3nd deri. with conv2')

subplot(2,2,4)
pixels = Lvvvtilde_filter(discgaussfft(house, 10));
contour(pixels)
axis('image');
axis('ij');
title('3nd deri. with filter2')

%% test 4
clc
clear
[x, y] = meshgrid(-5:5, -5:5);

dxmask = [-0.5, 0, 0.5];
%dxmask = zeros(5, 5);
%dxmask(3, 2:4) = [-0.5, 0, 0.5];
dymask = dxmask';

%dxxmask = zeros(5, 5);
%dxxmask(3, 2:4) = [1, -2, 1];
dxxmask = [1, -2, 1];
dyymask = dxxmask';

dxxxmask = conv2(dxmask, dxxmask) %conv? filter?

%% Q4
clc
clear

figure(44)
house = godthem256;

scale = [0.0001, 1.0, 4.0, 16.0 ,64.0];

for i = 1 : length(scale)
    subplot(2, 3, i)
    pixels = Lvvtilde(discgaussfft(house, scale(i)), 'same');
    contour(pixels, [0 0]); 
    axis('image');
    axis('ij');
    title(['scale = ', num2str(scale(i))]);
end

%% Q5
tools = few256;
scale = [0.0001, 1.0, 4.0, 16.0 ,64.0];

figure(45)
for i = 1 : length(scale)
    subplot(2, 3, i)
    pixels = Lvvvtilde(discgaussfft(tools, scale(i)), 'same');
    showgrey(pixels < 0); 
    axis('image');
    title(['scale = ', num2str(scale(i))]); 
end

%% Q6
clc
clear

figure(46)
house = godthem256;
house = few256;

scale = [4, 16];
for i = 1:length(scale)
    subplot(length(scale), 2, (i-1)*2+1)
    Lvvpixels = Lvvtilde(discgaussfft(house, scale(i)), 'same');
    contour(Lvvpixels, [0 0]); 
    axis('image');
    axis('ij');
    title(['2nd Deri. with scale = ', num2str(scale(i))]);

    %subplot(length(scale), 2, (i-1)*3+2)
    Lvvvpixels = Lvvvtilde(discgaussfft(house, scale(i)), 'same');
    
    %A = Lvvpixels .* real(log(1 + Lvvpixels .* double(Lvvvpixels<0)));
%     A = Lvvpixels .* real(log(1 + Lvvpixels));
%     contour(A, [0 0]); 
%     axis('image');
%     axis('ij');
%     title(['Log Transform']);

    subplot(length(scale), 2, (i-1)*2+2)
    Lvvpixels(Lvvvpixels > 0) = NaN;
    %A(Lvvvpixels >= 0) = NaN;%100000000;
    contour(Lvvpixels, [0 0]); 
    axis('image');
    axis('ij');
    title(['2nd Deri. minus 3rd Deri >0']);
end
