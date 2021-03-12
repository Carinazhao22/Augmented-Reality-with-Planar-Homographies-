% Your solution to Q2.1.5 goes here!
clear;
clc;
%% Read the image and convert to grayscale, if necessary
cv_img = imread('../data/cv_cover.jpg');

%% Compute the features and descriptors
match_count_brief=[];
match_count_surf=[];
degree=[];
select_idx=[1,10,27];

%% randomly select 3 rotated images to plot 
for i = 0:36
    %% Rotate image
    rotated_img=imrotate(cv_img,10*i);
    degree=[degree 10*i];
    %% Compute features and descriptors
    [locs1, locs2] = matchPics(cv_img, rotated_img);
    [locs11, locs22] = matchPics_SURF(cv_img, rotated_img);
    %% Match features
    if ismember(i,select_idx)
        %% visualize matched features
        figure; ax=axes;
        showMatchedFeatures(cv_img,rotated_img,locs1,locs2,'montage','Parent',ax);
        title(ax,"Candidate point matched for Brief")
        legend(ax, 'Matched points 1','Matched points 2');
        figure; ax=axes;
        showMatchedFeatures(cv_img,rotated_img,locs11,locs22,'montage','Parent',ax);
        title(ax,"Candidate point matched for SURF")
        legend(ax, 'Matched points 1','Matched points 2');
    end
    %% Update histogram
    match_count_brief=[match_count_brief size(locs1,1)];
    match_count_surf=[match_count_surf size(locs11,1)];
end

%% Display histogram
figure;
bar(degree,match_count_brief);
title('Matched Features VS Rotation Degrees (BRIEF)')
xlabel('Rotation Degrees')
ylabel('Matched Features')

figure;
bar(degree,match_count_surf);
title('Matched Features VS Rotation Degrees (SURF)')
xlabel('Rotation Degrees')
ylabel('Matched Features')

