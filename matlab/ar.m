% Q3.3.1
%% load videos
clear;
clc;

movie=loadVid('../data/ar_source.mov');
book=loadVid('../data/book.mov');
cv_img = imread('../data/cv_cover.jpg');

%% video writer
videoWriter=VideoWriter('../result/ar.avi');
open(videoWriter);
%%  combine movie and book
for idx=1:size(movie,2)
    book_frame=book(idx).cdata;
    movie_frame=movie(idx).cdata;
    [locs1, locs2] = matchPics(cv_img, book_frame);
    
    % skip images with less than 4 points in locs1 and locs2
    try 
    [bestH2to1, ~] = computeH_ransac(locs1, locs2);
    catch
        continue;
    end
  
    % crop the center of movie and scale
    center_x=ceil(size(movie_frame,1)/2);center_y=ceil(size(movie_frame,2)/2);
    crop_img=movie_frame(center_x-130:center_x+130,center_y-250:center_y+250,:);
    scaled_mov_img = imresize(crop_img, [size(cv_img,1) size(cv_img,2)]);
    
    % combine frames
    composite_img=compositeH(inv(bestH2to1), scaled_mov_img, book_frame);
    writeVideo(videoWriter,composite_img);
    disp(idx);
end
close(videoWriter);