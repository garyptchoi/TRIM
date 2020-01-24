function plot_triangulated_image(VertexSet,TRI,TRIcolor)
% Plot the triangulated image with piecewise color.
%
% If you use this code in your own work, please cite the following paper:
% [1] C. P. Yung, G. P. T. Choi, K. Chen, and L. M. Lui, 
%     "Efficient feature-based image registration by mapping sparsified surfaces."
%     Journal of Visual Communication and Image Representation, 55, pp. 561-571, 2018.
%
% Copyright (c) 2016-2018, Gary Pui-Tung Choi
% https://scholar.harvard.edu/choi

patch('Faces',TRI,'Vertices',[VertexSet(:,1),-VertexSet(:,2)],'FaceVertexCData',TRIcolor,'FaceColor','flat','EdgeColor','None');
axis equal tight off;