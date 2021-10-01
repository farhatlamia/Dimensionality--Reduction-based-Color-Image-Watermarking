function CoCoef(Host_image,Watermarked,wt2,Watermark )
 
%     flag=0;
%     [row col]=size(Host_image);
%     size_host=row*col*64;
%  for j = 1:size_host;
%     flag = flag+(Host_image(j) - Watermarked(j))^2;
%  end
%  vr=flag/size_host;
%  psnr =10*log10((255)^2/vr);
%  disp('psnr :');
%  disp(real(psnr));
 
 
%  R1 = corr2(Host_image,real(orgE));
R2 = corr2(Watermark,wt2);
%  disp('Host Img Corelation');
%  disp(R1);
 disp('Watermark corelation');
   disp(R2)
 
 
 
 
 
 
 
 
 
 
  [rowW colW]=size(Watermark);
  r=min(rowW,colW);
  [U, S ,V] =svd(Watermark);
  [U_ , S_ , V_]=svd(wt2);
  
  Smean=real(mean(mean(S)));
  S_mean=real(mean(mean(S_)));
  S=real(S);
  S_=real(S_);
  
  Pu=0;
  for j=1:r
      Pu=Pu+(S(j)-Smean)-(S_(j)-S_mean);
  end
  
  Pd1=0;Pd2=0;
  for j=1:r
      Pd1=Pd1+(S(j)-Smean)^2;
      Pd2=Pd2+(S_(j)-S_mean)^2;
  end
  Pd1=sqrt(Pd1);
  Pd2=sqrt(Pd2);
  P=Pu/(Pd1*Pd2);
%    disp((real(P)));
  
 end
 
