function [VertexSet, landmark_index] = add_landmark_and_obtain_id(VertexSet, landmark) 
% Add landmarks to the existing vertex set.
%
% If you use this code in your own work, please cite the following paper:
% [1] C. P. Yung, G. P. T. Choi, K. Chen, and L. M. Lui, 
%     "Efficient feature-based image registration by mapping sparsified surfaces."
%     Journal of Visual Communication and Image Representation, 55, pp. 561-571, 2018.
%
% Copyright (c) 2016-2018, Gary Pui-Tung Choi
% https://scholar.harvard.edu/choi

[~, landmark_location_in_VertexSet] = ismember(landmark,VertexSet,'rows');
landmark_index = landmark_location_in_VertexSet;
landmark_not_in_VertexSet = landmark(landmark_location_in_VertexSet == 0,:);
landmark_index(landmark_location_in_VertexSet == 0,:) = size(VertexSet,1) + (1:size(landmark_not_in_VertexSet,1))'; 
VertexSet(end + 1:end + size(landmark_not_in_VertexSet,1),:) = landmark_not_in_VertexSet;
end

