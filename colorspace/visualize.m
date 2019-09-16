function visualize(input_image)
    inputSize = size(input_image);
    if (inputSize(1) ~= 0) %if the image is not grayscaled...
        subplot(2,2,1), imshow(input_image); %display the original image as if it were and RGB image
        [c1, c2, c3] = imsplit(input_image); 
        subplot(2,2,2), imshow(c1); %display its three components
        subplot(2,2,3), imshow(c2); %each component is displayed in grayscale to better highlight its values
        subplot(2,2,4), imshow(c3);     
    end
end

