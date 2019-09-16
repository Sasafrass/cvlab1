function [ p, q, SE ] = check_integrability( normals )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   normals: normal image
%   p : df / dx
%   q : df / dy
%   SE : Squared Errors of the 2 second derivatives

% initalization
p = zeros(size(normals));
q = zeros(size(normals));
dp=zeros(size(normals(:,:,1)));
dq=zeros(size(normals(:,:,1)));

SE = zeros(size(normals(:,:,1)));

% ========================================================================
% YOUR CODE GOES HERE
% Compute p and q, where
% p measures value of df / dx
% q measures value of df / dy
p=normals(:,:,1)./normals(:,:,3);
q=normals(:,:,2)./normals(:,:,3);

% ========================================================================



p(isnan(p)) = 0;
q(isnan(q)) = 0;



% ========================================================================
% YOUR CODE GOES HERE
% approximate second derivate by neighbor difference
% and compute the Squared Errors SE of the 2 second derivatives SER

%Row diff
% A1=transpose(diff(transpose(p)));
% A1=[A1 zeros(size(p,1),1)];
% A2=(diff((p)));
% A2=[A2; zeros(1,size(p,2))];
% dp=0.5*(A1+A2);
% A1=diff(q(2:end,:));
% A2=([zeros(1,size(q,2));diff(q)]);
% A1=([zeros(1,size(q,2));A1; zeros(1,size(q,2))]);
% dq=0.5*(A1+A2);
% 
% A1=transpose(p);
% A1=diff(A1(2:end,:));
% A1=transpose(A1);
% A1=([zeros(size(p,1),1) A1  zeros(size(p,1),1)]);
% 
% A2=transpose(diff(transpose(p)));
% A2=([zeros(size(p,1),1) A2]);
% dp=0.5*(A1+A2);
% 
% dp(:,end)=0;
% dq(end,:)=0;
dp=gradient(p);
dq=gradient(q);


% ========================================================================
SE=(dp-dq).^2;
SE(isnan(SE)) = 0;



end

