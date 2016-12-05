function [ segm, centers ] = kmeans_segm(image, K, L, seed, verbose)

if nargin < 5
    verbose = 1;
end

image = im2double(image);
% %Let X be a set of pixels and V be a set of K cluster centers in 3D (R,G,B).
[m, n, d] = size(image);
X = reshape(image, m * n, d);
rng(seed);
V = rand(K, 3); % Randomly initialize the K cluster centers
D = pdist2(X, V,'euclidean');% Compute all distances between pixels and cluster centers

for l = 1 : L % Iterate L times
% %   Assign each pixel to the cluster center for which the distance is minimum
    [minD, cluster] = min(D');
    V_temp = V;
% %   Recompute each cluster center by taking the mean of all pixels assigned to it
    for k = 1 : K %calculate each center
        if size(X(cluster == k, :), 1 ) ==0 %!!!How to solve!! It happen that some centers don't have any data approching.
            V(k, :) = rand(1, 3);
        else
            V(k, :) = mean( X(cluster == k, :) );
        end
    end
    if verbose == 1
        plot(l, norm(V_temp - V), 'bo');
        hold on
    end
    D = pdist2(X, V,'euclidean');
end
hold off
[minD, segm] = min(D');
segm = reshape(segm', m, n);
centers = V;

end
