function [output] = AWB(img)

    % Read input and create output with same dimensions
    img=imread(img);
    output = uint8(ones(size(img,1), size(img,2), size(img,3)));
   
    % Get R, G, B channels
    R = img(:,:,1);
    G = img(:,:,2);
    B = img(:,:,3);

    % Find avg values of R, G, B
    % Make sure to take mean twice: matrix -> vector -> scalar
    avgR = mean(mean(R));
    avgG = mean(mean(G));
    avgB = mean(mean(B));

    % Scale values so average becomes 128 for all colors
    output(:,:,1) = 128/avgR * R;
    output(:,:,2) = 128/avgG * G;
    output(:,:,3) = 128/avgB * B;

    % Plot two images side by side
    subplot(1,2,1), imshow(img);
    subplot(1,2,2), imshow(output);
end