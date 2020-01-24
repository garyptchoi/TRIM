function [BWs, EdgePointSet] = get_edge_point_set(SegmentedImage)
% Get the edge point set of the segmented image.
%
% If you use this code in your own work, please cite the following paper:
% [1] C. P. Yung, G. P. T. Choi, K. Chen, and L. M. Lui, 
%     "Efficient feature-based image registration by mapping sparsified surfaces."
%     Journal of Visual Communication and Image Representation, 55, pp. 561-571, 2018.
%
% Copyright (c) 2016-2018, Gary Pui-Tung Choi
% https://scholar.harvard.edu/choi

if length(size(SegmentedImage)) ~= 2 % not grayscale image
    GraySegmentedImage = rgb2gray(SegmentedImage);
else
    GraySegmentedImage = SegmentedImage;
end 
% [~, threshold] = edge(GraySegmentedImage, 'sobel');
fudgeFactor = .5;
threshold = 0.01;
BWs = edge(GraySegmentedImage,'sobel', threshold * fudgeFactor);
locationArray = find(BWs);
[EdgePointSet_y,EdgePointSet_x] = ind2sub(size(SegmentedImage),locationArray);
EdgePointSet = [EdgePointSet_x EdgePointSet_y];

end