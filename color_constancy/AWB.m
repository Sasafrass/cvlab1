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
    
    % Find the minimum of these average values
    minval = min(min(avgR, avgG), avgB);
    
    % Retrieve proper scaling factors
    scaleR = minval/avgR;
    scaleG = minval/avgG;
    scaleB = minval/avgB;
  
    % Scale the channels with scalars and put them in new array
     output(:,:,1) = R*scaleR;
     output(:,:,2) = G*scaleG;
     output(:,:,3) = B*scaleB;
     
     subplot(1,2,1), imshow(img);
     subplot(1,2,2), imshow(output);
end