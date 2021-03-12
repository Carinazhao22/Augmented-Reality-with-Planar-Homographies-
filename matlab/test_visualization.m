clear all;
close all;

cv_img = imread('../data/cv_cover.jpg');
desk_img = imread('../data/cv_desk.png');
hp_img = imread('../data/hp_cover.jpg');

%% Extract features and match
[locs1, locs2] = matchPics(cv_img, desk_img);
%% Compute homography
H2to1 = computeH(locs1, locs2);
visualize_results(cv_img,desk_img,locs1,H2to1);
%% Compute homography_normal
bestH2to1 = computeH_norm(locs1, locs2);
visualize_results(cv_img,desk_img,locs1,bestH2to1);
%% Compute homography usng RANSAC
[bestH2to1,inliers,points,tran_locs1] = computeH_ransac(locs1, locs2);

%% visualization RANSAC
random_point=[]; tran_random=[];
satis_point=[]; tran_satif=[];

for i =1:size(inliers,1)
    if inliers(i)==1
        if ismember(i,points)
            random_point=[random_point;locs1(i,:)];
            tran_random=[tran_random;tran_locs1(i,:)];
        else
            satis_point=[satis_point; locs1(i,:)];
            tran_satif=[tran_satif; tran_locs1(i,:)];
        end
    end
end

figure; ax=axes;
showMatchedFeatures(cv_img,desk_img,random_point,tran_random,'montage','Parent',ax);
title(ax,"Four Points Pairs (Create Most inliers)");
legend(ax, 'Matched points 1','Matched points 2');

figure;ax=axes;
showMatchedFeatures(cv_img,desk_img,satis_point,tran_satif,'montage','Parent',ax);
title(ax,"Pair Points Selected by RANSAC");
legend(ax, 'Matched points 1','Matched points 2');
