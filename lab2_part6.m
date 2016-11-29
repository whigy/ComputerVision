%% Part 6 Hough transform
clc
clear

%% Test 1
figure(600)
x0 = 5;
y0 = 4;
dx = 1;
dy = 2;
idx = [1:3];
subplot(2, 2, 1)
outcurves(1, 4*(idx-1) + 1) = 0; % level, not significant
outcurves(2, 4*(idx-1) + 1) = 3; % number of points in the curve
plot(outcurves(1, :), outcurves(2, :));

subplot(2, 2, 2)
outcurves(2, 4*(idx-1) + 2) = x0-dx;
outcurves(1, 4*(idx-1) + 2) = y0-dy;
plot(outcurves(1, :), outcurves(2, :));

subplot(2, 2, 3)
outcurves(2, 4*(idx-1) + 3) = x0;
outcurves(1, 4*(idx-1) + 3) = y0;
plot(outcurves(1, :), outcurves(2, :));

subplot(2, 2, 4)
outcurves(2, 4*(idx-1) + 4) = x0+dx;
outcurves(1, 4*(idx-1) + 4) = y0+dy;
plot(outcurves(1, :), outcurves(2, :));

%%%%%%%This is a mode of output!!!!!!!!!
figure(601)
overlay(outcurves)

%% Test 2
figure(602)
t = triangle128;

subplot(2, 2, 1)
showgrey(t)

subplot(2, 2, 2)
c = zerocrosscurves(t-128);
showgrey(c)

subplot(2, 2, 3)
overlaycurves(t, c)

subplot(2, 2, 4) %%%%%%%%%What's this???? Totally doesn't work!
pixelplotcurves(t, c, -128)
showgrey(pixelplotcurves(t, c, -128));


%% Test 3
figure(603)
subplot(2, 2, 1)
testimage1 = triangle128;
showgrey(testimage1);

subplot(2, 2, 2)
smalltest1 = binsubsample(testimage1);
showgrey(smalltest1);
size(smalltest1)

subplot(2, 2, 3)
testimage2 = houghtest256;
showgrey(testimage2);

subplot(2, 2, 4)
smalltest2 = binsubsample(binsubsample(testimage2));
showgrey(smalltest2);
size(smalltest2)

%% Main
clc
clear
testimage1 = triangle128;
smalltest1 = binsubsample(testimage1);
testimage2 = houghtest256;
smalltest2 = binsubsample(binsubsample(testimage2));

scale = 4;
gradmagnthreshold = 4;
nrho = 500;
ntheta = 200;
nlines =10;

figure(61)
piclist = {'testimage1', 'smalltest1', 'testimage2', 'smalltest2'};
for i = 1: length(piclist)
%     if i == 1 || i ==3
%         continue
%     end
    subplot(2, 2, i)
    pic = eval(piclist{i});
    [linepar acc] = houghedgeline(pic, scale, gradmagnthreshold, nrho, ntheta, nlines);
end

