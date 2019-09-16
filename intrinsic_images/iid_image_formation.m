R = imread('ball_albedo.png');
S = imread('ball_shading.png');
I = imread('ball.png');

R = im2double(R);
S = im2double(S);
I = im2double(I);

subplot(2,2,1),imshow(R);
title('Image Albedo');
subplot(2,2,2),imshow(S);
title('Image Shading');
subplot(2,2,3),imshow(I);
title('Original Image')
subplot(2,2,4),imshow(R.*S);
title('Reconstructed image');
