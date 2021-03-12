function [ composite_img ] = compositeH( H2to1, template, img )
%COMPOSITE Create a composite image after warping the template image on top
%of the image using the homography
% Note that the homography we compute is from the image to the template;
% x_template = H2to1*x_photo

% For warping the template to the image, we need to invert it.
H_template_to_img = inv(H2to1);
 
%% Create mask of same size as template
% filled values in warpH is 0 by default
mask=ones(size(template,1),size(template,2),3);
%% Warp mask by appropriate homography
 
Warped_mask=warpH(mask,H_template_to_img,size(img));
 
%% Warp template by appropriate homography
Warped_template=warpH(template,H_template_to_img,size(img));
 
%% Use mask to combine the warped template and the image
composite_img = Warped_template;
% fill original background to black in compositie_img
composite_img(Warped_mask==0)=img(Warped_mask==0);
 
end