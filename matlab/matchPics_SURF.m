function [ locs1, locs2] = matchPics_SURF( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
if size(I1,3)==3
    I1=rgb2gray(I1);
end
if size(I2,3)==3
    I2=rgb2gray(I2);
end 

%% Detect features in both images
feature1=detectSURFFeatures(I1);
feature2=detectSURFFeatures(I2);


%% Obtain descriptors for the computed feature locations
[desc1, locs1]=extractFeatures(I1,feature1,'Method','SURF');
[desc2, locs2]=extractFeatures(I2,feature2,'Method','SURF');

%% Match features using the descriptors
indexPairs=matchFeatures(desc1,desc2,'MatchThreshold',10,'MaxRatio',0.7);
locs1=locs1(indexPairs(:,1),:);
locs2=locs2(indexPairs(:,2),:);

end

