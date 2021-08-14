# TRIM: Triangulating Images

<img src = "https://github.com/garyptchoi/TRIM/blob/master/lincoln.jpg" height="300" /> <img src = "https://github.com/garyptchoi/TRIM/blob/master/cover.png" height="300" />

imtriangulate: Generate a content-aware coarse triangulation of any image

This code triangulates any given image using the TRIM algorithm in [1], which aims at producing a content-aware coarse triangulation image representation. It can be used for image compression, simplification, registration as well as artistic design.

Any comments and suggestions are welcome. 

If you use this code in your own work, please cite the following paper:

[1] C. P. Yung, G. P. T. Choi, K. Chen and L. M. Lui, 
    "[Efficient feature-based image registration by mapping sparsified surfaces.](https://doi.org/10.1016/j.jvcir.2018.07.005)"
    Journal of Visual Communication and Image Representation, 55, pp. 561-571, 2018.

Copyright (c) 2016-2018, Gary Pui-Tung Choi

https://math.mit.edu/~ptchoi

===============================================================

Usage:
* [VertexSet, TRI, TRIcolor] = imtriangulate(I, density)

Input:
* I: an image 
* density: a nonnegative value controlling the density of the resultant triangulation (0 = coarsest)

Output:
* VertexSet: nv x 2 vertex coordinates of the triangulated image
* TRI: nf x 3 triangulation
* TRIcolor: nf x 3 RGB color interpolated on every triangle
