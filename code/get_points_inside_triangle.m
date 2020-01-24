function points = get_points_inside_triangle(vertex_1,vertex_2,vertex_3)
% Get the grid points inside the input triangle.
% 
% If you use this code in your own work, please cite the following paper:
% [1] C. P. Yung, G. P. T. Choi, K. Chen, and L. M. Lui, 
%     "Efficient feature-based image registration by mapping sparsified surfaces."
%     Journal of Visual Communication and Image Representation, 55, pp. 561-571, 2018.
%
% Copyright (c) 2016-2018, Gary Pui-Tung Choi
% https://scholar.harvard.edu/choi

vertex_set = [vertex_1;vertex_2;vertex_3];
square_grid_max_y = max(vertex_set(:,2));
square_grid_min_y = min(vertex_set(:,2));
square_grid_max_x = max(vertex_set(:,1));
square_grid_min_x = min(vertex_set(:,1));
[X,Y] = meshgrid(square_grid_min_x:2:square_grid_max_x, square_grid_min_y:2:square_grid_max_y);
points = zeros(numel(X),2);
for i = 1:numel(X)
    points(i,:) = [X(i) Y(i)];
end
points = points(inpolygon(points(:,1),points(:,2),vertex_set(:,1),vertex_set(:,2)),:);
end
