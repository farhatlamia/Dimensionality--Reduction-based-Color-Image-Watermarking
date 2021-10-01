function [ IT ] = svdEmd( Watermark,Transformed,angles,a )
    [u s v]=svd(Transformed);
    [u1 s1 v1]=svd(Watermark);
     s_temp=s;
  
   [x y]=size(Watermark);
   for i=1:x
       for j=1:y
          s(i,j) =s(i,j) + a * s1(i,j);
%           s(i,j) =st(i,j);
       end 
   end 
   
%     [x1 y1]=size(st);
%    for i=1:x
%        for j=1:y
%           
%        end 
%    end 
%    
%    [u1 s1 v1]=svd(st);
Wimg =u* s* v';  
IT=frft2((Wimg),-angles);

end

