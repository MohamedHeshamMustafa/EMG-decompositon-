function [idx, centroids] = hkMeans(X, K)

rp = randperm(size(X, 1));
centroids = X(rp(1:K), :);
serr = Inf;

while serr > 0
    C = bsxfun(@minus, X, shiftdim(centroids', -1));
    C = squeeze(sum(C.*C, 2));
    [~, idx] = min(C, [], 2);

    P = centroids;
    for k=1:K
        C = X(idx == k, :);
        if numel(C)
            centroids(k, :) = mean(C);
        end
    end

    serr = centroids(:) - P(:);
    serr = serr'*serr;
end

COLORS = {'ro','go','bo','yo','mo','co','wo','ko'};

%figure
%hold on
%for k = 1:K
%plot(find(idx == k), X(idx == k), COLORS{k}, 'markersize', 2)
%end
%plot(centroids(:), 'bx')
%hold off

end
