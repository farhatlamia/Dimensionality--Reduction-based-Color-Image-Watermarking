function [ D ] = svdExt(Transformed,Watermarked,key1,key2,angles,a)

[u s v]=svd(Transformed);
     
[u4] = key1;
[v4] = key2;

TWM=frft2(Watermarked,angles);

[u3 s3 v3]=svd(TWM);

% D=u * s1 * v';
x=size(key1);
y=size(key2);
for i=1:x 
  for j=1:y
     Watermark_Extract(i,j)= (s3(i,j) - s(i,j))/a ;
  end 
end
% Watermark_Extract;

% D=frft2((Watermark_Extract),-angles);
% % [u5 s5 v5]=svd(Watermark_Extract);
% % % IT=frft2((Wimg),-angles);
 

 D=u4 * Watermark_Extract * v4';






