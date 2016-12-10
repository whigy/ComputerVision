function [ segm, centers, L ] = kmeans_segm(image, K, seed, verbose)

if nargin < 4
    verbose = 1;
end

image = im2double(image);
% %Let X be a set of pixels and V be a set of K cluster centers in 3D (R,G,B).
[m, n, d] = size(image);
X = reshape(image, m * n, d);

ind = randperm(m * n);
V = X(ind(1:K),:); % Randomly initialize the K cluster centers
D = pdist2(X, V,'euclidean');% Compute all distances between pixels and cluster centers
stop = 0;
L = 0;
while stop == 0
% %   Assign each pixel to the cluster center for which the distance is minimum
    [minD, cluster] = min(D');
    V_temp = V;
% %   Recompute each cluster center
    for k = 1 : K %calculate each center
        if size(X(cluster == k, :), 1 ) <=10
            V(k, :) = X(randi(m*n),:);            %If less than 10 participants, sample an existing pixel
        else
            V(k, :) = mean( X(cluster == k, :) ); %If more than 10 participants, take the mean of all participants
        end
    end
    
    L = L + 1;
    
    if verbose == 1
        plot(L, norm(V_temp - V), 'bo');
        hold on
    end
    
    if isequal(V,V_temp)
        stop = 1;
        disp('Number of iterations:')
        disp(L)
    end
    D = pdist2(X, V,'euclidean');
end
hold off
[minD, segm] = min(D');
segm = reshape(segm', m, n);
centers = V;

end
