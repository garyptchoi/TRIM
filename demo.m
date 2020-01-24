% imtriangulate: Generate a content-aware coarse triangulation of an image using the TRIM algorithm in [1].
% 
% Usage:
% [VertexSet, TRI, TRIcolor] = imtriangulate(I, density)
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

addpath('code'); 
addpath(genpath('ext'));

%% Example 1
I = imread('lena.tif');

figure;
subplot(1,2,1);
imshow(I);
title('Original image')

% Triangulate the image
tic;
density = 0.2; 
[VertexSet, TRI, TRIcolor] = imtriangulate(I, density); 
toc;

% plot the result
subplot(1,2,2);
plot_triangulated_image(VertexSet,TRI,TRIcolor);
title('Triangulated image')

%% save the triangulated image (optional)
figure;
plot_triangulated_image(VertexSet,TRI,TRIcolor);
set(gcf,'Position',[0, 0, 2*size(I,1), 2*size(I,2)]);
export_fig output.png
close;
I2 = imread('output.png');
I2 = imresize(I2,[size(I,1),size(I,2)],'bilinear');
imwrite(I2,'output.png');


%% Example 2
I = imread('lincoln.jpg');

figure;
subplot(1,2,1);
imshow(I);
title('Original image')

% Triangulate the image
tic;
density = 0.8; 
[VertexSet, TRI, TRIcolor] = imtriangulate(I, density); 
toc;

% plot the result
subplot(1,2,2);
plot_triangulated_image(VertexSet,TRI,TRIcolor);
title('Triangulated image')

%% Example 3
I = imread('mandril.tif');

figure;
subplot(1,2,1);
imshow(I);
title('Original image')

% Triangulate the image
tic;
density = 0.1; 
[VertexSet, TRI, TRIcolor] = imtriangulate(I, density); 
toc;

% plot the result
subplot(1,2,2);
plot_triangulated_image(VertexSet,TRI,TRIcolor);
title('Triangulated image')

%% Example 4
I = imread('wave.jpg');

figure;
subplot(1,2,1);
imshow(I);
title('Original image')

% Triangulate the image
tic;
density = 0.1; 
[VertexSet, TRI, TRIcolor] = imtriangulate(I, density); 
toc;

% plot the result
subplot(1,2,2);
plot_triangulated_image(VertexSet,TRI,TRIcolor);
title('Triangulated image')
