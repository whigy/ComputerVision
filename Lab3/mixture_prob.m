function prob = mixture_prob(image, K, L, mask)
%MIXTURE_PROB
%Let I be a set of pixels and V be a set of K Gaussian components in 3D (R,G,B).

image = im2double(image);
[m, n, d] = size(image);

I = reshape(image, m * n, d);
mask = reshape(mask, m * n, 1);

% Store all pixels for which mask=1 in a Nx3 matrix
Imask = I(mask == 1, :);

% Randomly initialize the K components using masked pixels
n_mask = size(Imask, 1);
disp(['size after mask: ', num2str(n_mask)]);

w = ones(1, K) /K;
%ind = randperm(n_mask); % Another way of initialization of mu
%mu = Imask( ind(1:K), :);
[ foo, mu ] = kmeans_segm3(image, K, 25, 14, 0); % Initialize with K-means center, hopefully get a faster converge
sigma = repmat( eye(3), 1, K);
sigma = reshape(sigma, 3, 3, K);
sigma = 0.04 * rand * sigma;

P = zeros( n_mask, K);

% Iterate L times
for l = 1 : L
%   Expectation: Compute probabilities P_ik using masked pixels
    for k = 1 :K
        dif = bsxfun(@minus, Imask, mu(k, :)); %size(dif) = [n_mask , 3]
        cova = sigma( :, :,k);
        
        g_k = (1 / sqrt((2 * pi)^3 * abs(det(cova)))) * exp ( -0.5 * sum(dif /cova .* dif,2)); % size(g_k) = [n_mask , 1]
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
        sigma (:, :, k) = s ./ sum(P(:, k)) + 0.0005 * diag(diag(rand(3))); %The trick is necessary, but why?
    end
end
    
%   Compute probabilities p(c_i) in Eq.(3) for all pixels I.

P = zeros( m * n, K); 
for k = 1 :K
    dif = bsxfun(@minus, I, mu(k, :));
    cova = sigma( :, :,k);

    g_k = 1 / sqrt( (2*pi)^3 * det(cova)) * exp ( -0.5 * sum(dif /cova .* dif,2));
    P(:, k) = w(k) * g_k;
end
prob = sum(P,2);
prob = reshape(prob, m, n, 1);
end

