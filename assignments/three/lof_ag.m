function outliers = lof_ag(data, k, threshold)
    % Use matlab builtin to do K-NN search to obtain 
    % neighbor distances and and indexes
    outliers=[];
    for j=1:size(k,2);
        % knn search over all query points in the dataset
        % using the each value of k in the k vector. 
        % distance is forced to euclidean distance - it's a default but 
        % explicitly stated
        [index, dist]=knnsearch(data,data,'k',k(j)+1, 'distance', 'euclidean');
        index=index(:,2:size(index,2));
        dist=dist(:,2:size(dist,2));
        % preallocate
        tmp_rdist=zeros(size(data,1),k(j));
        % get reachability distances for the neighbors
        for i=1:k(j)
            tmp_rdist(:,i)=dist(index(:,i),k(j));
        end
        % final reachdist is the greatest between the distances and rdists
        reachdist=max(tmp_rdist,dist);
        reachdist_sum=sum(reachdist,2);
        % reachability densities
        lrd=k(j)./reachdist_sum;
        % preallocate array
        lrd_tmp=zeros(size(data,1),k(j));
        for i=1:k(j)  
            lrd_tmp(:,i)=lrd(index(:,i));
        end
        % compute the actual LOF score over each column
        lof=sum(lrd_tmp,2)./lrd;
        lof=lof./k(j);
        % update number of outliers that are greater than the specified threshold 
        % not an expensive preallocate despite matlab's warning
        outliers = [ outliers sum(lof > threshold) ];
    end
    % plot k vs outliers
    plot(k,outliers)
    title('Number of Outliers vs k')
    xlabel('k')
    ylabel('Outliers')
end % end of lof
