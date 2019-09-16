function [ height_map ] = construct_surface( p, q, path_type )
%CONSTRUCT_SURFACE construct the surface function represented as height_map
%   p : measures value of df / dx
%   q : measures value of df / dy
%   path_type: type of path to construct height_map, either 'column',
%   'row', or 'average'
%   height_map: the reconstructed surface


if nargin == 2
    path_type = 'column';
end

[h, w] = size(p);
height_map = zeros(h, w);

switch path_type
    case 'column'
        % =================================================================
        % YOUR CODE GOES HERE
        % top left corner of height_map is zero
        % for each pixel in the left column of height_map
        %   height_value = previous_height_value + corresponding_q_value
            for i=2:h % as top left is index 1 and bottom left is h
                height_map(i, 1) = height_map(i - 1, 1) + q(i, 1);
            end
    

        % for each row
        %   for each element of the row except for leftmost
        %       height_value = previous_height_value + corresponding_p_value
        
            for i=1:h
                for j=2:w % starting from column 2
                    height_map(i, j) =  height_map(i, j - 1) + p(i, j);
                end
            end
       
        % =================================================================
               
    case 'row'
        
        % =================================================================
        % YOUR CODE GOES HERE
            for i=2:w % same as above but with top left =0 and traversing across top row
                height_map(1, i) = height_map(1 , i-1) + p(1, i);
            end
            for i=1:w
                for j=2:h
                    height_map(j,i) =  height_map(j-1, i ) + q(j, i);
                end
            end
        % =================================================================
          
    case 'average'
        
        % =================================================================
        % YOUR CODE GOES HERE
        col_map = construct_surface(p, q, 'column');
        row_map = construct_surface(p, q, 'row');
        height_map = 0.5*(col_map + row_map)  ;
        
        % =================================================================
end


end

