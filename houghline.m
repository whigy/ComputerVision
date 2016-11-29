% clc
% clear
% 
% testimage2 = houghtest256;
% %smalltest2 = binsubsample(binsubsample(testimage2));
% pic = binsubsample(testimage2);
% scale = 4;
% gradmagnthreshold = 4;
% threshold = 4;
% nrho = 500;
% ntheta = 200;
% nlines =10;
% 
% curves = extractedge(pic, scale, gradmagnthreshold, 'same');
% magnitude = Lv(pic);

%%
function [linepar, acc] = houghline(curves, magnitude, nrho, ntheta, threshold, nlines, verbose)
% verbose = 1 : plot edge
% verbose = 2 : plot accumulater space

% Check if input appear to be valid

%%%initialize accumulator space%%%
% Allocate accumulator space
acc = zeros(nrho, ntheta);

% Define a coordinate system in the accumulator space
 % theta: [-180, 180]
 % rho: according to the distance to the center of image?
maxrho = sqrt(size(magnitude, 1)^2 + size(magnitude, 2)^2);
rho_coor = linspace(-maxrho, maxrho, nrho);
theta_coor = linspace(-pi/2, pi/2, ntheta);

%%% %%%
% Loop over all the input curves (cf. pixelplotcurves)
insize = size(curves, 2);
trypointer = 1;
numcurves = 0;

while trypointer <= insize,
  polylength = curves(2, trypointer);
  numcurves = numcurves + 1;
  trypointer = trypointer + 1;

  % For each point on each curve
  for polyidx = 1:polylength
    x = curves(2, trypointer);
    y = curves(1, trypointer);
    % Check if valid point with respect to threshold]
    % Optionally, keep value from magnitude image
    magn_xy = magnitude(round(x), round(y));
    if magn_xy < threshold
        trypointer = trypointer + 1;
        continue
    end
    trypointer = trypointer + 1;
    % Loop over a set of theta values
    for ind_theta = 1 : ntheta
        theta = theta_coor(ind_theta);
        % Compute rho for each theta value
        rho_true = x * cos(theta) + y * sin(theta);
        % Compute index values in the accumulator space
        [rho, ind_rho] = min(abs(rho_coor - rho_true));
        % Update the accumulator
        %acc(ind_rho, ind_theta) = acc(ind_rho, ind_theta) + 1; %%Update the accumulator by 1 every time
        acc(ind_rho, ind_theta) = acc(ind_rho, ind_theta) + log(1 + magn_xy);%%Update by propotional to the gradient magnitude
    end
  end
end

% Extract local maxima from the accumulator
%%%Optional: Smooth histogram before calculating local maxima
acc = binsepsmoothiter(acc, 0.1, 5);
[Pos, Value, Anms] = locmax8(acc);

% Delimit the number of responses if necessary
[Value, ind] = sort(Value, 'descend');
Pos = Pos(ind, :);

maxline = min(length(Value), nlines);
linepar = zeros(2, maxline);

% Compute a line for each one of the strongest responses in the accumulator

outcurves = zeros(2, maxline);
for idx = 1 : maxline
    rho = rho_coor(Pos(idx, 1));
    theta = theta_coor(Pos(idx, 2));
    linepar(1, idx) = rho;
    linepar(2, idx) = theta;
    
    %Calculate output points, 3 for each line
    x0 = 0;
    y0 = (rho - x0 * cos(theta)) / sin(theta);
    dx = maxrho;
    dy = (rho - dx * cos(theta)) / sin(theta);
    outcurves(1, 4*(idx-1) + 1) = 0; % level, not significant
    outcurves(2, 4*(idx-1) + 1) = 3; % number of points in the curve
    outcurves(2, 4*(idx-1) + 2) = x0-dx;
    outcurves(1, 4*(idx-1) + 2) = -dy;
    outcurves(2, 4*(idx-1) + 3) = x0;
    outcurves(1, 4*(idx-1) + 3) = y0;
    outcurves(2, 4*(idx-1) + 4) = x0+dx;
    outcurves(1, 4*(idx-1) + 4) = dy;
end

% Overlay these curves on the gradient magnitude image
if verbose ==1
    overlaycurves(magnitude, outcurves);
    axis([1 size(magnitude, 1) 1 size(magnitude, 2)])
elseif verbose ==2
    showgrey(acc);
end
% Return the output data
%end