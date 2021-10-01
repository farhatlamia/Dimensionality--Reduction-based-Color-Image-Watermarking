function [ Wimg ] = svdExt_New(Transformed,IT_new,key1,key2,a)

 [u s v]=svd(Transformed);
 [u1 s1 v1]=svd(IT_new);

[u4] = key1;
[v4] = key2;
x=size(key1);
y=size(key2);


for i=1:x 
  for j=1:y
    Watermark_Extract(i,j)= (s1(i,j) - s(i,j))/a ;
  end 
end

Wimg=u4 * Watermark_Extract * v4'; 
end