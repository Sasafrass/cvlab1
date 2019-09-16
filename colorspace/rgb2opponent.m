function [output_image] = rgb2opponent(input_image)
% converts an RGB image into opponent color space
[r, g, b] = getColorChannels(input_image);
O1 = (r-g)./sqrt(2);
O2 = (r+g-2*b)./sqrt(6);
O3 = (r+g+b)./sqrt(3);
output_image = cat(3,O1,O2,O3);
% subplot(1,2,1), imshow(output_image);
% subplot(1,2,2), imshow(input_image);
end

