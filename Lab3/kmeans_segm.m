function [ segm, centers ] = kmeans_segm(image, K, L, seed, verbose)

if nargin < 5
    verbose = 1;
end

image = im2double(image);
% %Let X be a set of pixels and V be a set of K cluster centers in 3D (R,G,B).
[m, n, d] = size(image);
X = reshape(image, m * n, d);

ind = randperm(m * n);
V = X(ind(1:K),:); % Randomly initialize the K cluster centers
D = pdist2(X, V,'euclidean');% Compute all distances between pixels and cluster centers

for l = 1 : L % Iterate L times
% %   Assign each pixel to the cluster center for which the distance is minimum
    [minD, cluster] = min(D');
    V_temp = V;
% %   Recompute each cluster center by taking the mean of all pixels assigned to it
    for k = 1 : K %calculate each center
        V(k, :) = mean( X(cluster == k, :) );
    end
    if verbose == 1
        plot(l, norm(V_temp - V), 'bo');
        disp(['L = ', num2str(l), ' Change of center:', num2str(norm(V_temp - V))]);
        hold on
    end
    D = pdist2(X, V,'euclidean');
end
hold off
[minD, segm] = min(D');
segm = reshape(segm', m, n);
centers = V;

end
