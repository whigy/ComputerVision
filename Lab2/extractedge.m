function edgecurves = extractedge(inpic, scale, threshold, shape)

%Smooth the image
smooth = gaussfft(inpic, scale);

%Calculate first order derivative, used for threshold
Lvi = Lv(smooth);

%Calculate second and third order derivative, used for edge detection
Lvv = Lvvtilde(smooth, shape);
Lvvv = Lvvvtilde(smooth, shape);

%Choose the opposite sign of Lvvv as the function takes non-negative value
curves = zerocrosscurves(Lvv, -Lvvv);
edgecurves = thresholdcurves(curves, Lvi - threshold);






