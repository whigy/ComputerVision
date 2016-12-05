function [ pixels ] = gaussfft2(pic, t)
%GUSSFFT 
%1. Generate a filter based on a sampled version of the Gaussian function.
[xsize ysize] = size(pic);
[x y] = meshgrid(-xsize/2 : xsize/2-1, -ysize/2 : ysize/2-1);
gaussf = (1 / (2 * pi * t)) * exp (- (x .* x / xsize^2 + y .* y/ysize^2) ./ (2 * t));

%2. Fourier transform the original image and the Gaussian filter.
ftransform = fft2(pic);
gtransform = fft2(fftshift(gaussf));

%3. Multiply the Fourier transforms.
Fhat = ftransform .* gtransform;

%4. Invert the resulting Fourier transform.
pixels = real(ifft2(Fhat));
end

