function [linepar, acc] = houghedgeline(pic, scale, gradmagnthreshold, nrho, ntheta, nlines, verbose)
% verbose = 1 : plot edge
% verbose = 2 : plot accumulater space

curves = extractedge(pic, scale, gradmagnthreshold, 'same');
magnitude = Lv(pic);

[linepar, acc] = houghline(curves, magnitude, nrho, ntheta, gradmagnthreshold, nlines, verbose);

end



