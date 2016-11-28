function edgecurves = extractedge(inpic, scale, threshold, shape)

%Smooth the image
smooth = discgaussfft(inpic, scale);

%Calculate first order derivative, used for threshold
Lvi = Lv(smooth);
range(Lvi)

%Calculate second and third order derivative, used for edge detection
Lvv = Lvvtilde(smooth, shape);
range(Lvv)
Lvvv = Lvvvtilde(smooth, shape);
range(Lvvv)

%Choose the opposite sign of Lvvv as the function takes non-negative value
curves = zerocrosscurves(Lvv, -Lvvv);
edgecurves = thresholdcurves(curves, Lvi - threshold);






