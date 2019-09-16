function [output_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb
[r, g, b] = getColorChannels(input_image);
norm_const = r+g+b;
R = r./norm_const;
G = g./norm_const;
B = b./norm_const;
output_image = cat(3,R,G,B);
end

