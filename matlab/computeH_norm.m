function [H2to1] = computeH_norm1(x1, x2)
%% Compute centroids of the points
centroid1 =mean(x1);
centroid2 =mean(x2);

%% Shift the origin of the points to the centroid
norm_x1=x1-centroid1;
norm_x2=x2-centroid2;
scale1=1; scale2=1;

%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
n=size(x1,1);avg1=0; avg2=0;
% calcuate average distance
for i =1:n
    avg1=avg1+norm(norm_x1(i,:));
    avg2=avg2+norm(norm_x2(i,:));
end
if avg1 ~=0
    scale1=sqrt(2)/(avg1/n);
end
if avg2~=0
    scale2=sqrt(2)/(avg2/n);
end

norm_x1=norm_x1*scale1;
norm_x2=norm_x2*scale2;

%% similarity transform 1
T1 = [scale1,0, -centroid1(1)*scale1;
      0,scale1, -centroid1(2)*scale1;
      0,0,1];
%% similarity transform 2
T2 = [scale2 0     -centroid2(1)*scale2;
       0   scale2  -centroid2(2)*scale2;
       0     0        1 ];
%% Compute Homography
H2to1=computeH(norm_x1,norm_x2);
%% Denormalization
H2to1 =T2\H2to1*T1;
end