close all
clear all
clc
 
disp('Part 1: Photometric Stereo')

% obtain many images in a fixed view under different illumination
disp('Loading images...')
image_dir = './photometrics_images/SphereGray5/';   % TODO: get the path of the script
%image_ext = '*.png';
%q1.1
[image_stack, scriptV] = load_syn_images(image_dir,1);
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);
% compute the surface gradient from the stack of imgs and light source mat
disp('Computing surface albedo and normal map...')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV, false,false);
imshow(albedo)
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);
threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));
%% compute the surface height
height_map = construct_surface( p, q );
%q1.2
% run for a number of different pictures
image_dir = './photometrics_images/MonkeyGray/';   % TODO: get the path of the script
[image_stack, scriptV] = load_syn_images(image_dir);
[albedo, normals , error] = estimate_alb_nrm(image_stack, scriptV, true,false);
batch_scriptV=scriptV;
batch_is=image_stack;
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);
threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));
%% compute the surface height
height_map = construct_surface( p, q );
%% Display
show_results(albedo, normals, SE);
show_model(albedo, height_map);
[h w d n]=size(image_stack)
figure
counter=1
%run through batch of images
for batch = (n-mod(n,5))/10:(n-mod(n,5))/10:(n-mod(n,5))
    batch_is=image_stack(:,:,:,1:batch);
    batch_scriptV=scriptV(1:batch,:);
    fprintf('Finish loading %d images.\n\n', n);
    % compute the surface gradient from the stack of imgs and light source mat
    disp('Computing surface albedo and normal map...')
    [albedo, normals,error] = estimate_alb_nrm(batch_is, batch_scriptV,true,false);
    subplot(2, 5, counter);
    imshow(albedo)
    counter=counter+1
    title('Albedo '+string(batch)+' Images');
end
    %% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);
threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization

[X, Y] = meshgrid(1:w, 1:h);
surf(X, Y, SE, gradient(SE))
title('Number of outliers:'+string(sum(sum(SE > threshold))));

%% compute the surface height
path_types=["column",'row','average'];
for counter = 1:3
    height_map = construct_surface( p, q ,path_types(counter));
    show_model(albedo, height_map)
end
%% Display
show_results(albedo, normals, SE);
%end
%q1.4
[image_stack, scriptV] = load_syn_images('./photometrics_images/MonkeyGray/');
batch_scriptV=scriptV;
batch_is=image_stack;
figure
%run through images
for batch = [5,10,15,20,25]
    image_stack=batch_is(:,:,:,1:batch);
    scriptV=batch_scriptV(1:batch,:);
    [h, w, n] = size(image_stack);
    fprintf('Finish loading %d images.\n\n', n);
    % compute the surface gradient from the stack of imgs and light source mat
    disp('Computing surface albedo and normal map...')
    [albedo, normals,error] = estimate_alb_nrm(image_stack, scriptV,true,false);
    show_results(albedo, normals, SE);
    show_model(albedo, height_map);
    %% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
    disp('Integrability checking')
    [p, q, SE] = check_integrability(normals);
    threshold = 0.005;
    SE(SE <= threshold) = NaN; % for good visualization
    fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));
    %% compute the surface height
    height_map = construct_surface( p, q );
    %% Display
    show_results(albedo, normals, SE);
    show_model(albedo, height_map);
    end
%q1.5
image_dir = './photometrics_images/SphereColor/';   % TODO: get the path of the script
[image_stack, scriptV] = load_syn_images(image_dir);
%image_ext = '*.png';
[h, w,d, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);
% compute the surface gradient from the stack of imgs and light source mat
disp('Computing surface albedo and normal map...')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV, true,true);
imshow(albedo)
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);
threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));
%% compute the surface height
height_map = construct_surface( p, q );
show_results(albedo, normals, SE);
show_model(albedo, height_map);


%% Face
[image_stack, scriptV] = load_face_images('./photometrics_images/yaleB02/');
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);
disp('Computing surface albedo and normal map...')
new_ScriptV=scriptV;%(mean(scriptV')>0,:);
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV, false,false);

%-------------method to filter dark images-------------------------
% new_image_stack=image_stack;%(:,:,mean(scriptV')>0);
% alpha_thresh=100
% while alpha_thresh>15
%     [albedo, normals error_image] = estimate_alb_nrm(new_image_stack, new_ScriptV,false,false);
%     idx=sum(sum(new_image_stack,1),2)> min(sum(sum(new_image_stack,1),2));
%     if mean(error_image)>15
% 
%         new_image_stack=new_image_stack(:,:,idx);%(:,:,mean(scriptV')>0);
%         new_ScriptV=new_ScriptV(idx,:);
%         disp('keeping image stack by')
%         disp(sum(idx))
%     else
%         alpha_thresh=mean(error_image);
%     end
%     disp(mean(error_image));
%     
%     
%     
% end
%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?

disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
path_types=["column",'row','average'];
for counter = 1:3
    height_map = construct_surface( p, q ,path_types(counter));
 
    show_model(albedo, height_map)
end
show_results(albedo, normals, SE);




