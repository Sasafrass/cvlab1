function [ albedo, normal ,photometric_error ] = estimate_alb_nrm( image_stack, scriptV, shadow_trick,rgb)
%COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   image_stack : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   shadow_trick: (true/false) whether or not to use shadow trick in solving
%   	linear equations
%   albedo : the surface albedo
%   normal : the surface normal

if ndims(image_stack)==4
[h, w,d, n] = size(image_stack);
else
    [h, w, n] = size(image_stack);

end

disp(n)
% create arrays for 
%   albedo (1 channel)
%   normal (3 channels)
if rgb==true
    channels=3;
else
    channels=1;
end
%initiallize arrays
albedo = zeros(h, w, channels);
normal = zeros(h, w, 3);
error_image = zeros(h, w, n);
photometric_error = zeros(n,1);

% =========================================================================
% YOUR CODE GOES HERE
% for each point in the image array
%   stack image values into a vector i
%   construct the diagonal matrix scriptI
%   solve scriptI * scriptV * g = scriptI * i to obtain g for this point
%   albedo at this point is |g|
%   normal at this point is g / |g|
if rgb==false

for k= 1:h
    for j=1:w
           if ndims(image_stack)==4
              i= reshape((image_stack(k,j,1,:)),[],1);
           else
              i= reshape((image_stack(k,j,:)),[],1);
           end
           scriptI=diag(i);%needed for shadow trick
           if shadow_trick==true 
               [g,R]=linsolve(scriptI * scriptV, scriptI * i);
               error_image(k,j,:)=scriptI*i-scriptI*scriptV*g;
           else
               [g,R]=linsolve( scriptV,  i);
               error_image(k,j,:)=i-scriptV*g;
               %amina method
%                top_images=floor(size(i,1)*.75);
% 
%                [i_sorted sortidx]=sort(i);
%                i_new=[i_sorted(1);i_sorted(end-top_images:end)];
%                scriptV_new=[scriptV(sortidx(1));scriptV(sortidx(end-top_images:end))];
%                [g,R]=linsolve( scriptV_new,  i_new);
% 
%                
%                
%                thresh=sum(norm((i_new-scriptV_new*g)/abs(scriptV_new*g)));
%                counter=2;
%                while thresh>5 && counter<(size(i,1)-top_images)
%                               i_new=[i_sorted(counter);i_sorted(end-top_images:end)];
%                         scriptV_new=[scriptV(sortidx(counter));scriptV(sortidx(end-top_images:end))];
%                         [g,R]=linsolve( scriptV_new,  i_new);
% 
%                     thresh=sum(norm((i_new-scriptV_new*g)/abs(scriptV_new*g)));
%                  counter=counter+1         ;    
%                end
%                thresh=mean((error_image(k,j,:)));
%                error_image_new=error_image;
%                while thresh>.10%mean((error_image(k,j,:)))*.75&&mean((error_image(k,j,:)))*.75>0.02;
%         
%                     [g,R]=linsolve( scriptV_new,  i_new);
% 
%                     error_image_new(k,j,:)=i_new-scriptV_new*g;
% 
%                     thresh=mean((error_image_new(k,j,:)));
%                     if size(i_new,1)<size(i,1)*.5;
%                         thresh=.1;
%                     end
%                     idx=i_new>prctile(i_new,10);
%                     i_new=i_new(idx);
%                     scriptV_new=scriptV_new(idx);
%                     error_image_new = zeros(h, w, size(i_new,1));
%                end
%            end
%              

            albedo(k,j)=norm(g);
            normal(k,j,:)=g/norm(g);
    end
end
end
if rgb==true
%    counter=1;
%    rgb_g = cell(3);
       i_r_1 = image_stack(:,:,1, :);
       i_g_1 = image_stack(:,:,2,:);
       i_b_1 = image_stack(:,:,3,:);
       for k= 1:h
       for j=1:w
            i_r= reshape((i_r_1(k,j,:)),[],1);
            i_g= reshape((i_g_1(k,j,:)),[],1);
            i_b= reshape((i_b_1(k,j,:)),[],1);
        if shadow_trick==true 
               scriptI_r=diag(i_r);%needed for shadow trick
               scriptI_g=diag(i_g);%needed for shadow trick
               scriptI_b=diag(i_b);%needed for shadow trick
               [g_r,R_r]=linsolve(scriptI_r * scriptV, scriptI_r * i_r);
               [g_g,R_g]=linsolve(scriptI_g * scriptV, scriptI_g * i_g);
               [g_b,R_b]=linsolve(scriptI_b * scriptV, scriptI_b * i_b);
        else
               [g_r,R_r]=linsolve( scriptV,  (i_r));
               [g_g,R_g]=linsolve( scriptV,  (i_g));
               [g_b,R_b]=linsolve( scriptV,  (i_b));
        end
           %averaging over norms
%            norm_r=g_r / norm(g_r);
%             norm_g=g_g / norm(g_g);
%             norm_b=g_b / norm(g_b);
%             normal(k, j, :) =((norm_b+norm_g+norm_r)/3); %mean([g_r/norm(g_r) ,g_g/norm(g_g) ,g_b/norm(g_b)])

%-----USING ONE CHANNEL FOR TO DETERMINE SURFACE NORMAL ------------
%            normal(k, j, :) =g_r / norm(g_r);
%             N=g_r / norm(g_r);
%             norm_g_g = sum((i_g' * scriptV *N)) / sum((scriptV * N) .^ 2);
%             norm_g_b = sum((i_b' * scriptV * N)) / sum((scriptV * N) .^ 2);
%             albedo(k, j, :) = [norm(g_r) norm_g_g norm_g_b];
            
%----using max method----------------------     
            albedo(k,j,:)=[norm(g_r) norm(g_g) norm(g_b)];

            if norm(g_r) == max(albedo(k,j,:))
               normal(k, j, :) = g_r / norm(g_r);
            elseif norm(g_g) == max(albedo(k,j,:))
                normal(k, j, :) = g_g / norm(g_g);
            else
                normal(k, j, :) = g_b / norm(g_b);
            end
    end
    end

   
   
end
                %error per image
                for i=1:n
                    photometric_error(i,1)=norm(error_image(:,:,i));

                end


% =========================================================================
end

