R = imread('ball_albedo.png');
S = imread('ball_shading.png');
I = imread('ball.png');


R(R == 141) = 255;
R(R ~= 255) = 0;

R = im2double(R);
S = im2double(S);
I = im2double(I);
RS = R.*S;

subplot(1,2,1),imshow(I);
title('Original Image');
subplot(1,2,2),imshow(RS);
title({'Reconstructed image where';'albedo RGB(0,255,0)'});