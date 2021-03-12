function visualize_results(I1,I2,x1,H2to1)
% visualize 20 random points
counts=size(x1,1);
s=10;
points=randperm(counts,s);
X1=[];
transformed_X1=[];
    for i=1:s
        X1=[X1;x1(points(i),:)];
        pair=[x1(points(i),:) 1];
        P=pair*H2to1';
        transformed_X1=[transformed_X1; P(:,1)./P(:,3) P(:,2)./P(:,3)];
    end

figure; ax=axes;
showMatchedFeatures(I1,I2,X1,transformed_X1,'montage','Parent',ax);
title(ax,"Candidate point matched");
legend(ax, 'Matched points 1','Matched points 2');
end 