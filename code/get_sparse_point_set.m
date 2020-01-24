function sparsePointSet = get_sparse_point_set(locationX, locationY, height, width, pointSet, sparseRatio)
% Sparse feature extraction.
%
% If you use this code in your own work, please cite the following paper:
% [1] C. P. Yung, G. P. T. Choi, K. Chen, and L. M. Lui, 
%     "Efficient feature-based image registration by mapping sparsified surfaces."
%     Journal of Visual Communication and Image Representation, 55, pp. 561-571, 2018.
%
% Copyright (c) 2016-2018, Gary Pui-Tung Choi
% https://scholar.harvard.edu/choi

sparsePointSet = [];
num_of_grids = size(pointSet,1)*sparseRatio/2;
height_line_number = round(sqrt(num_of_grids/(height*width))*height + 2);
height_scan_line_location_array = round(locationY:((height - 1)/(height_line_number - 1)):locationY + height - 1);
width_line_number = round(sqrt(num_of_grids/(height*width))*width + 2);
width_scan_line_location_array = round(locationX:((width - 1)/(width_line_number - 1)):locationX + width - 1);

for i = 1:size(height_scan_line_location_array,2)
    temp_scanline_pointset_save = [];
    j = 1;
    while j <= size(pointSet,1)
        % save point set from current scan-lines
        if pointSet(j,2) == height_scan_line_location_array(i)
            temp_scanline_pointset_save(end + 1,:) = pointSet(j,:);
            pointSet(j,:) = [];
            j = j - 1;
        end
        j = j + 1;
    end
    
    for k = 1:size(width_scan_line_location_array,2) - 1
        temp_interval_pointset_save = [];
        m = 1;
        while m <= size(temp_scanline_pointset_save,1)
            if width_scan_line_location_array(k) < temp_scanline_pointset_save(m,1) && temp_scanline_pointset_save(m,1) <= width_scan_line_location_array(k + 1)
                temp_interval_pointset_save(end + 1,:) = temp_scanline_pointset_save(m,:);
                temp_scanline_pointset_save(m,:) = [];
                m = m - 1;
            end
            m = m + 1;
        end
       
        % pointset centre scheme
        if ~isempty(temp_interval_pointset_save)
            
            sparsePointSet(end + 1,:) = round((mean(temp_interval_pointset_save',2))');
        end

    end
    
    
end
for i = 1:size(width_scan_line_location_array,2)
    temp_scanline_pointset_save = [];
    j = 1;
    
    while j <= size(pointSet,1)
        % save point set from current scan-lines
        if pointSet(j,1) == width_scan_line_location_array(i)
            temp_scanline_pointset_save(end + 1,:) = pointSet(j,:);
            pointSet(j,:) = [];
            j = j - 1;
        end
        j = j + 1;
    end
    for k = 1:size(height_scan_line_location_array,2) - 1
        temp_interval_pointset_save = [];
        m = 1;
        while m <= size(temp_scanline_pointset_save,1)
            if height_scan_line_location_array(k) < temp_scanline_pointset_save(m,2) && temp_scanline_pointset_save(m,2) <= height_scan_line_location_array(k + 1)
                temp_interval_pointset_save(end + 1,:) = temp_scanline_pointset_save(m,:);
                temp_scanline_pointset_save(m,:) = [];
                m = m - 1;
                
            end
            m = m + 1;
        end
        % pointset centre scheme
        if ~isempty(temp_interval_pointset_save)
            sparsePointSet(end + 1,:) = round((mean(temp_interval_pointset_save',2))');
        end
              
    end
end


% let output be unique
sparsePointSet = unique(sparsePointSet, 'rows');

end
