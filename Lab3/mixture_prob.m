function prob = mixture_prob(image, K, L, mask)
%MIXTURE_PROB
%Let I be a set of pixels and V be a set of K Gaussian components in 3D (R,G,B).
%%
% clear
% clc
% 
% scale_factor = 0.5;          % image downscale factor
% area = [ 80, 110, 570, 300 ] % image region to train foreground with
% K = 16;                      % number of mixture components
% alpha = 8.0;                 % maximum edge cost
% sigma = 10.0;                % edge cost decay factor
% L = 10;
% 
% I = imread('tiger1.jpg');
% I = imresize(I, scale_factor);
% Iback = I;
% area = int16(area*scale_factor);
% image = I ;
%%
image = im2double(image);
[m, n, d] = size(image);

% %%%%discard
% mask = ones(m, n );
% %%%%%%%%%%%%

I = reshape(image, m * n, d);
mask = reshape(mask, m * n, 1);

% %%%%discard
% ind = randperm(m * n);
% mask(ind(1 : 30000), :) = 0;
% %%%%%%%%%%%%%

% Store all pixels for which mask=1 in a Nx3 matrix
Imask = I(mask == 1, :);

% Randomly initialize the K components using masked pixels
n_mask = size(Imask, 1);
disp(['size after mask: ', num2str(n_mask)]);
%ind = randperm(n_mask);
w = ones(1, K) /K;
%mu = Imask( ind(1:K), :);
[ foo, mu ] = kmeans_segm3(image, K, 25, 14, 0); % Initialize with K-means center, hopefully get a faster converge
sigma = repmat( eye(3), 1, K);
sigma = reshape(sigma, 3, 3, K);
sigma = 0.04 * rand * sigma;

P = zeros( n_mask, K);
%%
% Iterate L times
for l = 1 : L
%   Expectation: Compute probabilities P_ik using masked pixels
    for k = 1 :K
        dif = bsxfun(@minus, Imask, mu(k, :)); %size(dif) = [n_mask , 3]
        cova = sigma( :, :,k);
        
        g_k = 1 / sqrt( (2*pi)^3 * det(cova)) * exp ( -0.5 * sum(dif /cova .* dif,2)); % size(g_k) = [n_mask , 1]
        P(:, k) = w(k) * g_k;
    end
    P = bsxfun(@rdivide, P, sum(P,2));
        
%   Maximization: Update weights, means and covariances using masked pixels
    % update weight
    w = sum(P) / n_mask;     %What is N?
    
    % update mu
    mu = P' * Imask ./ repmat(sum(P)', 1, 3);
    
    % update sigma
    for k = 1 : K
        dif = bsxfun(@minus, mu(k, :), Imask);
        s = bsxfun(@times, dif, P(:, k))' * dif;
        sigma (:, :, k) = s ./ sum(P(:, k));
    end
end
    
%   Compute probabilities p(c_i) in Eq.(3) for all pixels I.
prob = zeros( m * n, 1);
for k = 1 :K
    dif = bsxfun(@minus, Imask, mu(k, :));
    cova = sigma( :, :,k);

    g_k = 1 / sqrt( (2*pi)^3 * det(cova)) * exp ( -0.5 * sum(dif /cova .* dif,2));
    P(:, k) = w(k) * g_k;
end
prob_mask = sum(P,2);
prob(mask == 1, :) = prob_mask;
prob = reshape(prob, m, n, 1);
end

