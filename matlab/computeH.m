function [ H2to1 ] = computeH( x1, x2 )
% COMPUTEH Computes the homography between two sets of points
counts=size(x1,1);
A=[];
for idx=1:counts
    eq1=[-x1(idx,1) -x1(idx,2) -1 0 0 0 x1(idx,1)*x2(idx,1) x1(idx,2)*x2(idx,1) x2(idx,1)];
    eq2=[0 0 0 -x1(idx,1) -x1(idx,2) -1 x1(idx,1)*x2(idx,2) x1(idx,2)*x2(idx,2) x2(idx,2)];
    A=[A; eq1;eq2];
end
 [~,~,V]=svd(A);
 H2to1=reshape(V(:,end),[3,3])';
 
end 