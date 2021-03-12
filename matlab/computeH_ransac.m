function [ bestH2to1, inliers,opt_points,tran_locs] = computeH_ransac(locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.
%Q2.2.3
iter=3000; threshold=2;
n=size(locs1,1);
tran_locs=[];
inliers=zeros(n,1);

for i=1:iter
    rand_x1=zeros(4,2); rand_x2=zeros(4,2);
    temp_inliers=zeros(n,1);
    
    % choose four random points and calculate H
     points=randperm(n,4); 
     for idx=1:4
         rand_x1(idx,:)=locs1(points(idx),:);
         rand_x2(idx,:)=locs2(points(idx),:);
     end
     temp_H=computeH_norm(rand_x1,rand_x2);
     
   
    
    % compute corresponding locations and convert to homongeneous coordinates
    tran_locs1=[];
    for idx=1:n
        point=[locs1(idx,:) 1];
        point=point*temp_H';
        tran_locs1=[tran_locs1; point(1)/point(3) point(2)/point(3)];
        if norm(tran_locs1(idx,:)-locs2(idx,:))<threshold
            temp_inliers(idx)=1;
        end
    end
    
    % check for the max
    if sum(temp_inliers)>sum(inliers)
        inliers=temp_inliers;
        bestH2to1=temp_H;
        opt_points=points;
        tran_locs=tran_locs1;
    end
     
end

 
end
