function [VertexSet, TRI, TRIcolor] = imtriangulate(I, density)
% Generate a content-aware coarse triangulation of the input image 
% using the TRIM algorithm in [1].
% 
% Input:
% I: an image 
% density: a nonnegative value controlling the density of the resultant triangulation (0 = coarsest)
%
% Output:
% VertexSet: nv x 2 vertex coordinates of the triangulated image
% TRI: nf x 3 triangulation
% TRIcolor: nf x 3 RGB color interpolated on every triangle
% 
% If you use this code in your own work, please cite the following paper:
% [1] C. P. Yung, G. P. T. Choi, K. Chen, and L. M. Lui, 
%     "Efficient feature-based image registration by mapping sparsified surfaces."
%     Journal of Visual Communication and Image Representation, 55, pp. 561-571, 2018.
%
% Copyright (c) 2016-2018, Gary Pui-Tung Choi
% https://scholar.harvard.edu/choi

% Convert the image to double matrix
image = im2double(I); 

% Subsampling
original_image = image;
max_image_size = 800^2; % can adjust this number to speed up the computation (smaller) or improve the accuracy (larger)
if size(image,1)*size(image,2) > max_image_size
    rescale_ratio = sqrt(max_image_size/(size(image,1)*size(image,2)));
    image = imresize(image,rescale_ratio);
end

% Unsharp masking
sharphened_image = imsharpen(image,'Amount', 1,'Radius', 2, 'Threshold', 0);

% Gaussian Filter to smooth image
smooth_image = im2uint8(sharphened_image);

% Segmentation
segmented_image = segmentation(smooth_image);

% Sparse feature extraction
[~, EdgePointSet] = get_edge_point_set(segmented_image);
VertexSet = get_sparse_point_set(1, 1, size(sharphened_image,1), size(sharphened_image,2), EdgePointSet, density);

% add corners as vertex
CornerVertex = [1 1;1 size(sharphened_image,1);size(sharphened_image,2) 1; size(sharphened_image,2) size(sharphened_image,1)];
[VertexSet, ~] = add_landmark_and_obtain_id(VertexSet, CornerVertex);

% Rescale back
VertexSet = VertexSet*min([size(original_image,1)/size(sharphened_image,1) size(original_image,2)/size(sharphened_image,2)]);

% Delaunay triangulation
TRI = delaunay(VertexSet);

% Construct piecewise color on triangle patch
vertex = zeros(3,2);
TRIcolor = zeros(length(TRI),3);
if length(size(segmented_image)) ~= 2 % not grayscale image
    for i = 1:size(TRI,1)
        vertex(1,:) = VertexSet(TRI(i,1),:);
        vertex(2,:) = VertexSet(TRI(i,2),:);
        vertex(3,:) = VertexSet(TRI(i,3),:);
        vertex = round(vertex);
        centroid = round(mean(vertex));
        points = get_points_inside_triangle(vertex(1,:),vertex(2,:),vertex(3,:));
        % add vertex
        points = [points; centroid];
        points_color_set = zeros(size(points,1),3);
        for j = 1:size(points,1)
            points_color_set(j,:) = [original_image(points(j,2),points(j,1),1), original_image(points(j,2),points(j,1),2), original_image(points(j,2),points(j,1),3)];
        end
        patch_color = mean(points_color_set);
        TRIcolor(i,:) = patch_color;
    end
else
    for i = 1:size(TRI,1)
        vertex(1,:) = VertexSet(TRI(i,1),:);
        vertex(2,:) = VertexSet(TRI(i,2),:);
        vertex(3,:) = VertexSet(TRI(i,3),:);
        vertex = round(vertex);
        centroid = round(mean(vertex));
        points = get_points_inside_triangle(vertex(1,:),vertex(2,:),vertex(3,:));
        % add vertex
        points = [points; centroid];
        points_color_set = zeros(size(points,1),3);
        for j = 1:size(points,1)
            points_color_set(j,:) = original_image(points(j,2),points(j,1));
        end
        patch_color = mean(points_color_set);
        TRIcolor(i,:) = patch_color;
    end
end

end



