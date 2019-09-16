function [output_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods

[r,g,b] = getColorChannels(input_image);

% ligtness method
avgLight = (max(max(r,g),b) + min(min(r,g),b))./2;

% average method
avgGray = (r + g + b)./3;

% luminosity method
lumGray = (0.21 * r + 0.72 * g + 0.07 * b);

% built-in MATLAB function 
matGray = rgb2gray(input_image);

subplot(2,2,1), imshow(avgLight);
subplot(2,2,2), imshow(avgGray);
subplot(2,2,3), imshow(lumGray);
subplot(2,2,4), imshow(matGray);

output_image = [];

end

